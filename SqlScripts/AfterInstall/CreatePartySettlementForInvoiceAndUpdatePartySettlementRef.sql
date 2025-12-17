IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('SLS.Invoice')
					AND [name]='ReceiptHeaderRef')
BEGIN
	EXEC('
		/****  CREATE RPA.PartySettlement ****/
		INSERT INTO RPA.PartySettlement
		(
			PartySettlementID,
			Number,
			Date,
			State,
			PartyRef,
			CurrencyRef,
			Rate,
			SettlementByRemainingAmount,
			SettlementByRemainingAmountInBaseCurrency,
			SettlementByRemainingRate,
			ReceiptHeaderRef,
			SettlementType,
			Description,
			FiscalYearRef,
			CreatorForm,
			Creator,
			CreationDate,
			LastModifier,
			LastModificationDate,
			Version
		)
		SELECT ROW_NUMBER() OVER(ORDER BY I.InvoiceId),
			   ROW_NUMBER() OVER(PARTITION BY RH.FiscalYearRef ORDER BY I.InvoiceId, RH.FiscalYearRef),
			   RH.Date, 
			   1 /*Saved*/,
			   I.CustomerPartyRef,
			   RH.CurrencyRef,
			   RH.Rate,
			   0,
			   0,
			   RH.Rate,
			   RH.ReceiptHeaderId,
			   1,
			   NULL,
			   RH.FiscalYearRef,
			   1 /*Factor*/,
			   RH.Creator,
			   RH.CreationDate,
			   RH.LastModifier,
			   RH.LastModificationDate,
			   0   
		FROM RPA.ReceiptHeader RH
			INNER JOIN SLS.Invoice I ON RH.ReceiptHeaderId = I.ReceiptHeaderRef AND RH.CreatorForm = 1 /*Factor*/
		
		DECLARE @PartySettlementID INT
		SELECT @PartySettlementID = MAX(PartySettlementID) FROM RPA.PartySettlement
		IF (ISNULL(@PartySettlementID,0) > 0)
		BEGIN
			EXEC FMK.[spSetLastId] ''RPA.PartySettlement'', @PartySettlementID
		END	
		
		/**** CREAT RPA.PartySettlementItem ****/
		INSERT INTO RPA.PartySettlementItem
		(
			PartySettlementItemID,
			PartySettlementRef,
			InvoiceRef,
			CurrencyRef,
			Rate,
			Amount,
			AmountInBaseCurrency,
			RemainingAmount
		)
		SELECT ROW_NUMBER() OVER(ORDER BY PSI.PartySettlementID),
			   PSI.PartySettlementID,
			   I.InvoiceId,
			   PSI.CurrencyRef,
			   PSI.Rate,
			   CASE
				WHEN RH.ReceiptAmount >= I.NetPrice THEN I.NetPrice
				ELSE RH.ReceiptAmount
			   END,
			   CASE
				WHEN (RH.TotalAmountInBaseCurrency + RH.DiscountInBaseCurrency) >= I.NetPriceInBaseCurrency THEN I.NetPriceInBaseCurrency
				ELSE (RH.TotalAmountInBaseCurrency + RH.DiscountInBaseCurrency)
			   END,
			   I.NetPrice
		FROM SLS.Invoice I
			INNER JOIN RPA.ReceiptHeader RH ON I.ReceiptHeaderRef = RH.ReceiptHeaderId
			INNER JOIN RPA.PartySettlement PSI ON RH.ReceiptHeaderId = PSI.ReceiptHeaderRef
			
		
		DECLARE @PartySettlementItemID INT
		SELECT @PartySettlementItemID = MAX(PartySettlementItemID) FROM RPA.PartySettlementItem
		IF (ISNULL(@PartySettlementItemID,0) > 0)
		BEGIN
			EXEC FMK.[spSetLastId] ''RPA.PartySettlementItem'', @PartySettlementItemID
		END	
		
		
		/**** UPDATE ReceiptHeader ****/
		UPDATE RH
		SET RH.CreatorForm = 17 /*PartySettlement*/
		FROM RPA.ReceiptHeader RH
			INNER JOIN RPA.PartySettlement PS ON RH.ReceiptHeaderId = PS.ReceiptHeaderRef
		
		
		/**** ALTER SLS.Invoice ****/

		ALTER TABLE SLS.Invoice DROP FK_Invoice_ReceiptHeaderRef
		ALTER TABLE SLS.Invoice DROP COLUMN ReceiptHeaderRef')
END
