IF Object_ID('ACC.spUpdateConfiguration') IS NOT NULL
	DROP PROCEDURE ACC.spUpdateConfiguration
GO
CREATE PROCEDURE ACC.spUpdateConfiguration @Type int
AS
BEGIN

		DECLARE @Value NVARCHAR(max)
	
	IF @Type IN(0, 1, 2, 3) 
	BEGIN
		if Exists (Select 1 from acc.vwAccount where FullCode = '111810')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111810')
		Exec FMK.spSetConfiguration 'PrepaymentTaxSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'PrepaymentTaxSL' , ''
		if Exists (Select 1 from acc.vwAccount where FullCode = '111811')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111811')
			Exec FMK.spSetConfiguration 'PrepaymentDutySL' , @Value
	    END
		else 
			Exec FMK.spSetConfiguration 'PrepaymentDutySL' , ''
		if Exists (Select 1 from acc.vwAccount where FullCode = '211131')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211131')
			Exec FMK.spSetConfiguration 'DutyPayableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'DutyPayableSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '211130')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211130')
			Exec FMK.spSetConfiguration 'TaxPayableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'TaxPayableSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '211001')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211001')
			Exec FMK.spSetConfiguration 'InventoryPayableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'InventoryPayableSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '621105')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '621105')
			Exec FMK.spSetConfiguration 'InventoryPurchaseCashDiscountSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'InventoryPurchaseCashDiscountSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111601')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111601')
			Exec FMK.spSetConfiguration 'InventoryInprogressWorkSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'InventoryInprogressWorkSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '211110')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211110')
			Exec FMK.spSetConfiguration 'InventoryTransportBrokerSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'InventoryTransportBrokerSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111304')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111304')
			Exec FMK.spSetConfiguration 'InventoryOtherReceivableAccountsSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'InventoryOtherReceivableAccountsSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111005')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111005')
			Exec FMK.spSetConfiguration 'BankAmountAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'BankAmountAccount' , ''

	    if Exists (Select 1 from acc.vwAccount where FullCode = '621002')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '621002')
			Exec FMK.spSetConfiguration 'BankFeeSlRef' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'BankFeeSlRef' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111006')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111006')
			Exec FMK.spSetConfiguration 'BankAmountCurrencyAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'BankAmountCurrencyAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111001')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111001')
			Exec FMK.spSetConfiguration 'CashAmountAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'CashAmountAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111002')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111002')
			Exec FMK.spSetConfiguration 'CashAmountCurrencyAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'CashAmountCurrencyAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111007')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111007')
			Exec FMK.spSetConfiguration 'PosAmountAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'PosAmountAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111008')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111008')
			Exec FMK.spSetConfiguration 'PosAmountCurrencyAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'PosAmountCurrencyAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111202')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111202')
			Exec FMK.spSetConfiguration 'CashDocAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'CashDocAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111203')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111203')
			Exec FMK.spSetConfiguration 'SubmitChequeAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SubmitChequeAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '211002')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211002')
			Exec FMK.spSetConfiguration 'DurationChequeAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'DurationChequeAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '911201')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '911201')
			Exec FMK.spSetConfiguration 'GuaranteeAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'GuaranteeAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111201')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111201')
			Exec FMK.spSetConfiguration 'SalesReceivableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesReceivableSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '111201')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111201')
			Exec FMK.spSetConfiguration 'AccountAnalysisSl' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'AccountAnalysisSl' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '621104')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '621104')
			Exec FMK.spSetConfiguration 'SalesCashSalesDiscountSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesCashSalesDiscountSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '511001')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '511001')
			Exec FMK.spSetConfiguration 'SalesPartFinalCostSL' , @Value
			Exec FMK.spSetConfiguration 'HotDistributionInventoryNoteSL' , @Value
		END
		else 
		BEGIN
			Exec FMK.spSetConfiguration 'SalesPartFinalCostSL' , ''
			Exec FMK.spSetConfiguration 'HotDistributionInventoryNoteSL' , ''
		END

		if Exists (Select 1 from acc.vwAccount where FullCode = '411001')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411001')
			Exec FMK.spSetConfiguration 'SalesPartSalesSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411002')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411002')
			Exec FMK.spSetConfiguration 'SalesPartSalesSLExport' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesSLExport' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411003')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411003')
			Exec FMK.spSetConfiguration 'SalesServiceSalesSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesServiceSalesSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411004')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411004')
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411005')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411005')
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSLExport' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSLExport' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411006')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411006')
			Exec FMK.spSetConfiguration 'SalesServiceSalesReturnSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesServiceSalesReturnSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411007')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411007')
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411008')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411008')
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSLExport' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSLExport' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411009')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411009')
			Exec FMK.spSetConfiguration 'SalesServiceSalesDiscountSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesServiceSalesDiscountSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '411204')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '411204')
			Exec FMK.spSetConfiguration 'SalesAdditionSLExport' , @Value
			Exec FMK.spSetConfiguration 'SalesAdditionSL' , @Value
		END
		else 
		BEGIN
			Exec FMK.spSetConfiguration 'SalesAdditionSLExport' , ''
			Exec FMK.spSetConfiguration 'SalesAdditionSL' , ''
		END

		if Exists (Select 1 from acc.vwAccount where FullCode = '111204')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111204')
			Exec FMK.spSetConfiguration 'ProtestDocAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'ProtestDocAccount' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '211110')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211110')
			Exec FMK.spSetConfiguration 'SalesCommiosionPayableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesCommiosionPayableSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '611403')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '611403')
			Exec FMK.spSetConfiguration 'SalesCommisionCostSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'SalesCommisionCostSL' , ''
			
		if Exists (Select 1 from acc.vwAccount where FullCode = '621107')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '621107')
			Exec FMK.spSetConfiguration 'EliminationLossSubsidiary' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'EliminationLossSubsidiary' , ''
--------------------------------------------------------

		if Exists (Select 1 from acc.vwAccount where FullCode = '111304')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111304')
			Exec FMK.spSetConfiguration 'AssetSaleSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'AssetSaleSL' , ''

		if Exists (Select 1 from acc.vwAccount where FullCode = '211129')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211129')
			Exec FMK.spSetConfiguration 'WithHoldingTaxSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'WithHoldingTaxSL' , ''

        if Exists (Select 1 from acc.vwAccount where FullCode = '211124')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211124')
			Exec FMK.spSetConfiguration 'InsuranceSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'InsuranceSL' , ''


	    if Exists (Select 1 from acc.vwAccount where FullCode = '211003')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211003')
			Exec FMK.spSetConfiguration 'DurationChequeCurrencyAccount' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'DurationChequeCurrencyAccount' , ''

	     if Exists (Select 1 from acc.vwAccount where FullCode = '211201')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '211201')
			Exec FMK.spSetConfiguration 'AdvanceReceivedSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'AdvanceReceivedSL' , ''

	   if Exists (Select 1 from acc.vwAccount where FullCode = '111512')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '111512')
			Exec FMK.spSetConfiguration 'InventoryTransferBrokerSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'InventoryTransferBrokerSL' , ''

	IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111003')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111003')
			EXEC FMK.spSetConfiguration 'PettyCashSL' , @Value
		END	
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111004')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111004')
			EXEC FMK.spSetConfiguration 'PettyCashCurrencySL' , @Value
		END	


	END
---------------------------------------------------------------------------------
	IF @Type IN(0, 4)
	BEGIN
		if Exists (Select 1 from acc.Account where AccountId = 56)
			Exec FMK.spSetConfiguration 'CashPaymentCostSL' , '56'
		else 
			Exec FMK.spSetConfiguration 'CashPaymentCostSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 130)
			Exec FMK.spSetConfiguration 'CreditPaymentCostSL' , '130'
		else 
			Exec FMK.spSetConfiguration 'CreditPaymentCostSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 152)
			Exec FMK.spSetConfiguration 'ContractReceiptSL' , '152'
		else 
			Exec FMK.spSetConfiguration 'ContractReceiptSL' , ''
		
		if Exists (Select 1 from acc.Account where AccountId = 152)
			Exec FMK.spSetConfiguration 'StatusOnAccountReceiptSL' , '152'
		else 
			Exec FMK.spSetConfiguration 'StatusOnAccountReceiptSL' , ''		
		
		if Exists (Select 1 from acc.Account where AccountId = 153)
			Exec FMK.spSetConfiguration 'ContractInventorySL' , '153'
		else 
			Exec FMK.spSetConfiguration 'ContractInventorySL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 70)
			Exec FMK.spSetConfiguration 'ContractStatusReceivableSL' , '70'
		else 
			Exec FMK.spSetConfiguration 'ContractStatusReceivableSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 174)
			Exec FMK.spSetConfiguration 'ContractStatusConfirmedSL' , '174'
		else 
			Exec FMK.spSetConfiguration 'ContractStatusConfirmedSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 108)
			Exec FMK.spSetConfiguration 'TaxCoefficientSL' , '108'
		else 
			Exec FMK.spSetConfiguration 'TaxCoefficientSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 141)
			Exec FMK.spSetConfiguration 'InsuranceCoefficientSL' , '141'
		else 
			Exec FMK.spSetConfiguration 'InsuranceCoefficientSL' , ''		
		if Exists (Select 1 from acc.Account where AccountId = 68)
			Exec FMK.spSetConfiguration 'GoodJobCoefficientSL' , '68'
		else 
			Exec FMK.spSetConfiguration 'GoodJobCoefficientSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 112)
			Exec FMK.spSetConfiguration 'PrepaymentDutySL' , '112'
		else 
			Exec FMK.spSetConfiguration 'PrepaymentDutySL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 111)
			Exec FMK.spSetConfiguration 'PrepaymentTaxSL' , '111'
		else 
			Exec FMK.spSetConfiguration 'PrepaymentTaxSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 149)
			Exec FMK.spSetConfiguration 'DutyPayableSL' , '149'
		else 
			Exec FMK.spSetConfiguration 'DutyPayableSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 148)
			Exec FMK.spSetConfiguration 'TaxPayableSL' , '148'
		else 
			Exec FMK.spSetConfiguration 'TaxPayableSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 139)
			Exec FMK.spSetConfiguration 'WithHoldingTaxSL' , '139'
		else 
			Exec FMK.spSetConfiguration 'WithHoldingTaxSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 141)
			Exec FMK.spSetConfiguration 'InsuranceSL' , '141'
		else 
			Exec FMK.spSetConfiguration 'InsuranceSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 130)
			Exec FMK.spSetConfiguration 'InventoryPayableSL' , '130'
		else 
			Exec FMK.spSetConfiguration 'InventoryPayableSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 90)
			Exec FMK.spSetConfiguration 'InventoryTransportBrokerSL' , '130'
		else 
			Exec FMK.spSetConfiguration 'InventoryTransportBrokerSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 84)
			Exec FMK.spSetConfiguration 'InventoryOtherReceivableAccountsSL' , '84'
		else 
			Exec FMK.spSetConfiguration 'InventoryOtherReceivableAccountsSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 70)
			Exec FMK.spSetConfiguration 'SalesReceivableSL' , '70'
		else 
			Exec FMK.spSetConfiguration 'SalesReceivableSL' , ''	

		if Exists (Select 1 from acc.Account where AccountId = 70)
			Exec FMK.spSetConfiguration 'AccountAnalysisSl' , '70'
		else 
			Exec FMK.spSetConfiguration 'AccountAnalysisSl' , ''

		if Exists (Select 1 from acc.Account where AccountId = 150)
			Exec FMK.spSetConfiguration 'SalesCommiosionPayableSL' , '150'
		else 
			Exec FMK.spSetConfiguration 'SalesCommiosionPayableSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 232)
			Exec FMK.spSetConfiguration 'SalesCommisionCostSL' , '232'
		else 
			Exec FMK.spSetConfiguration 'SalesCommisionCostSL' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 58)
			Exec FMK.spSetConfiguration 'BankAmountAccount' , '58'
		else 
			Exec FMK.spSetConfiguration 'BankAmountAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 54)
			Exec FMK.spSetConfiguration 'CashAmountAccount' , '54'
		else 
			Exec FMK.spSetConfiguration 'CashAmountAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 60)
			Exec FMK.spSetConfiguration 'PosAmountAccount' , '60'
		else 
			Exec FMK.spSetConfiguration 'PosAmountAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 71)
			Exec FMK.spSetConfiguration 'CashDocAccount' , '71'
		else 
			Exec FMK.spSetConfiguration 'CashDocAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 72)
			Exec FMK.spSetConfiguration 'SubmitChequeAccount' , '72'
		else 
			Exec FMK.spSetConfiguration 'SubmitChequeAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 131)
			Exec FMK.spSetConfiguration 'DurationChequeAccount' , '131'
		else 
			Exec FMK.spSetConfiguration 'DurationChequeAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 74)
			Exec FMK.spSetConfiguration 'ProtestDocAccount' , '74'
		else 
			Exec FMK.spSetConfiguration 'ProtestDocAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 256)
			Exec FMK.spSetConfiguration 'GuaranteeAccount' , '256'
		else 
			Exec FMK.spSetConfiguration 'GuaranteeAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 59)
			Exec FMK.spSetConfiguration 'BankAmountCurrencyAccount' , '59'
		else 
			Exec FMK.spSetConfiguration 'BankAmountCurrencyAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 55)
			Exec FMK.spSetConfiguration 'CashAmountCurrencyAccount' , '55'
		else 
			Exec FMK.spSetConfiguration 'CashAmountCurrencyAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 61)
			Exec FMK.spSetConfiguration 'PosAmountCurrencyAccount' , '61'
		else 
			Exec FMK.spSetConfiguration 'PosAmountCurrencyAccount' , ''	
		if Exists (Select 1 from acc.Account where AccountId = 132)
			Exec FMK.spSetConfiguration 'DurationChequeCurrencyAccount' , '132'
		else 
			Exec FMK.spSetConfiguration 'DurationChequeCurrencyAccount' , ''		
		if Exists (Select 1 from acc.Account where AccountId = 269)
			Exec FMK.spSetConfiguration 'SalesPartFinalCostSL' , '269'
		else 
			Exec FMK.spSetConfiguration 'SalesPartFinalCostSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 258)
			Exec FMK.spSetConfiguration 'SalesPartSalesSL' , '258'
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 260)
			Exec FMK.spSetConfiguration 'SalesServiceSalesSL' , '260'
		else 
			Exec FMK.spSetConfiguration 'SalesServiceSalesSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 262)
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSL' , '262'
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 264)
			Exec FMK.spSetConfiguration 'SalesServiceSalesReturnSL' , '264'
		else 
			Exec FMK.spSetConfiguration 'SalesServiceSalesReturnSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 265)
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSL' , '265'
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 267)
			Exec FMK.spSetConfiguration 'SalesServiceSalesDiscountSL' , '267'
		else 
			Exec FMK.spSetConfiguration 'SalesServiceSalesDiscountSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 181)
			Exec FMK.spSetConfiguration 'SalesAdditionSL' , '181'
		else 
			Exec FMK.spSetConfiguration 'SalesAdditionSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 259)
			Exec FMK.spSetConfiguration 'SalesPartSalesSLExport' , '259'
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesSLExport' , ''
		if Exists (Select 1 from acc.Account where AccountId = 263)
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSLExport' , '263'
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesReturnSLExport' , ''
		if Exists (Select 1 from acc.Account where AccountId = 266)
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSLExport' , '266'
		else 
			Exec FMK.spSetConfiguration 'SalesPartSalesDiscountSLExport' , ''
		if Exists (Select 1 from acc.Account where AccountId = 181)
			Exec FMK.spSetConfiguration 'SalesAdditionSLExport' , '181'
		else 
			Exec FMK.spSetConfiguration 'SalesAdditionSLExport' , ''
		if Exists (Select 1 from acc.Account where AccountId = 272)
			Exec FMK.spSetConfiguration 'SalesCashSalesDiscountSL' , '272'
		else 
			Exec FMK.spSetConfiguration 'SalesCashSalesDiscountSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 273)
			Exec FMK.spSetConfiguration 'InventoryPurchaseCashDiscountSL' , '273'
		else 
			Exec FMK.spSetConfiguration 'InventoryPurchaseCashDiscountSL' , ''

		if Exists (Select 1 from acc.Account where AccountId = 103)
			Exec FMK.spSetConfiguration 'PettyCashSL' , '103'
		else 
			Exec FMK.spSetConfiguration 'PettyCashSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 104)
			Exec FMK.spSetConfiguration 'PettyCashCurrencySL' , '104'
		else 
			Exec FMK.spSetConfiguration 'PettyCashCurrencySL' , ''
	END

	IF @Type IN(3, 4)
	BEGIN
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111706')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111706')
			EXEC FMK.spSetConfiguration 'CustomsClearanceSlAccount' , @Value
		END
		ELSE
		BEGIN
			Exec FMK.spSetConfiguration 'CustomsClearanceSlAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111702')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111702')
			EXEC FMK.spSetConfiguration 'CommercialOrderSlAccount' , @Value
		END
		ELSE
		BEGIN
			Exec FMK.spSetConfiguration 'CommercialOrderSlAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111703')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111703')
			EXEC FMK.spSetConfiguration 'InsurancePolicySLAccount' , @Value
		END
		ELSE
		BEGIN
			Exec FMK.spSetConfiguration 'InsurancePolicySLAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111709')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111709')
			EXEC FMK.spSetConfiguration 'BillOfLoadingSLAccount' , @Value
		END
		ELSE
		BEGIN
			Exec FMK.spSetConfiguration 'BillOfLoadingSLAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111701')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111701')
			EXEC FMK.spSetConfiguration 'PurchaseCostSLAccount' , @Value
		END
		ELSE
		BEGIN
			Exec FMK.spSetConfiguration 'PurchaseCostSLAccount' , ''
		END
	END

	IF @Type IN(1, 3, 4)
	BEGIN
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001 ')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001 ')
			EXEC FMK.spSetConfiguration 'PurchaseInvoicePayableSLAccount' , @Value
		END
		ELSE
		BEGIN
			Exec FMK.spSetConfiguration 'PurchaseInvoicePayableSLAccount' , ''
		END
	END

	IF @Type = 1 --بازرگاني
	BEGIN 
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621102')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621102')
			EXEC FMK.spSetConfiguration 'AssetIncomeSL' , @Value
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621106')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621106')
			EXEC FMK.spSetConfiguration 'SalvageLossSubsidiary' , @Value
		END

		
		EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionPurchaseSL' , ''
		--EXEC FMK.spSetConfiguration 'AssetSaleSL' , ''
		EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionProduceSL' , ''
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001')
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , ''	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111706')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111706')
			EXEC FMK.spSetConfiguration 'CustomsClearanceSlAccount' , @Value
		END
		ELSE
		BEGIN
			EXEC FMK.spSetConfiguration 'CustomsClearanceSlAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111702')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111702')
			EXEC FMK.spSetConfiguration 'CommercialOrderSlAccount' , @Value
		END
		ELSE
		BEGIN
			EXEC FMK.spSetConfiguration 'CommercialOrderSlAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111703')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111703')
			EXEC FMK.spSetConfiguration 'InsurancePolicySLAccount' , @Value
		END
		ELSE
		BEGIN
			EXEC FMK.spSetConfiguration 'InsurancePolicySLAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111709')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111709')
			EXEC FMK.spSetConfiguration 'BillOfLoadingSLAccount' , @Value
		END
		ELSE
		BEGIN
			EXEC FMK.spSetConfiguration 'BillOfLoadingSLAccount' , ''
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111701')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111701')
			EXEC FMK.spSetConfiguration 'PurchaseCostSLAccount' , @Value
		END
		ELSE
		BEGIN
			EXEC FMK.spSetConfiguration 'PurchaseCostSLAccount' , ''
		END
	END

	IF @Type = 2 --خدماتي
	BEGIN
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621102')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621102')
			EXEC FMK.spSetConfiguration 'AssetIncomeSL' , @Value
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621106')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621106')
			EXEC FMK.spSetConfiguration 'SalvageLossSubsidiary' , @Value
		END
		
		EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionPurchaseSL' , ''		 
		--EXEC FMK.spSetConfiguration 'AssetSaleSL' , ''
		EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionProduceSL' , ''
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001')
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , ''	
		
	END

	IF @Type = 3 --توليدي
	BEGIN
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111802')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111802')
			EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionPurchaseSL' , @Value
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621102')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621102')
			EXEC FMK.spSetConfiguration 'AssetIncomeSL' , @Value
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621106')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621106')
			EXEC FMK.spSetConfiguration 'SalvageLossSubsidiary' , @Value
		END
		 
		--EXEC FMK.spSetConfiguration 'AssetSaleSL' , ''
		EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionProduceSL' , ''
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001')
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , ''	

		
	END

	IF @Type = 4 --پيمانكاري
	BEGIN
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111802')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111802')
			EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionPurchaseSL' , @Value
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621302')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621302')
			EXEC FMK.spSetConfiguration 'AssetIncomeSL' , @Value
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '621307')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '621307')
			EXEC FMK.spSetConfiguration 'SalvageLossSubsidiary' , @Value
		END
		 
		EXEC FMK.spSetConfiguration 'AssetSaleSL' , ''
		EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionProduceSL' , ''
		if Exists (Select 1 from acc.Account where AccountId = 130)
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , '130'
		else 
	 		Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , ''	
	 		
	    if Exists (Select 1 from acc.Account where AccountId = 439)
			Exec FMK.spSetConfiguration 'EliminationLossSubsidiary' , '439'
		else 
			Exec FMK.spSetConfiguration 'EliminationLossSubsidiary' , ''
			
		if Exists (Select 1 from acc.vwAccount where FullCode = '621102')
		BEGIN
		SET @Value = (Select AccountId from acc.vwAccount where FullCode = '621102')
			Exec FMK.spSetConfiguration 'BankFeeSlRef' , @Value
		END
		else 
			Exec FMK.spSetConfiguration 'BankFeeSlRef' , ''

		--Contract	
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211301')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211301')
			EXEC FMK.spSetConfiguration 'ContractReceiptSL' , @Value
		END
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211007')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211007')
			EXEC FMK.spSetConfiguration 'StatusOnAccountReceiptSL' , @Value
		END
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111217')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111217')
			EXEC FMK.spSetConfiguration 'ContractPaymentSL' , @Value
		END
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111208')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111208')
			EXEC FMK.spSetConfiguration 'StatusOnAccountPaymentSL' , @Value
		END
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211303')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211303')
			EXEC FMK.spSetConfiguration 'ContractInventorySL' , @Value
		END
	
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111817')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111817')
			EXEC FMK.spSetConfiguration 'ContractInventoryDeliverySL' , @Value
		END		
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111201')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111201')
			EXEC FMK.spSetConfiguration 'ContractStatusReceivableSL' , @Value
		END	
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '411001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '411001')
			EXEC FMK.spSetConfiguration 'ContractStatusConfirmedSL' , @Value
		END			
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111003')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111003')
			EXEC FMK.spSetConfiguration 'CashPaymentCostSL' , @Value
		END				
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001')
			EXEC FMK.spSetConfiguration 'CreditPaymentCostSL' , @Value
		END				
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111815')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111815')
			EXEC FMK.spSetConfiguration 'InsuranceCoefficientSL' , @Value
		END	
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111105')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111105')
			EXEC FMK.spSetConfiguration 'sltGoodJobCoefficientSL' , @Value
		END			

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001')
			EXEC FMK.spSetConfiguration 'ContractStatusPayableSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111601')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111601')
			EXEC FMK.spSetConfiguration 'ContractStatusConfirmedPayableSL' , @Value
		END	
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '911201')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '911201')
			EXEC FMK.spSetConfiguration 'GuaranteePaidCreditSL' , @Value
			EXEC FMK.spSetConfiguration 'GuaranteeReceivedCreditSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211301')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211301')
			EXEC FMK.spSetConfiguration 'ContractReceiptSL' , @Value
		END		

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211007')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211007')
			EXEC FMK.spSetConfiguration 'StatusOnAccountReceiptSL' , @Value
		END		
		
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111217')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111217')
			EXEC FMK.spSetConfiguration 'ContractPaymentSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111208')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111208')
			EXEC FMK.spSetConfiguration 'StatusOnAccountPaymentSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211303')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211303')
			EXEC FMK.spSetConfiguration 'ContractInventorySL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111201')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111201')
			EXEC FMK.spSetConfiguration 'StatusOnAccountReceiptSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '411001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '411001')
			EXEC FMK.spSetConfiguration 'ContractStatusConfirmedSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111003')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111003')
			EXEC FMK.spSetConfiguration 'CashPaymentCostSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001')
			EXEC FMK.spSetConfiguration 'CreditPaymentCostSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211001')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '211001')
			EXEC FMK.spSetConfiguration 'ContractStatusPayableSL' , @Value
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111601')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111601')
			EXEC FMK.spSetConfiguration 'ContractStatusConfirmedPayableSL' , @Value
		END										

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211116')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 13, '211116'
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211115')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 12, '211115'
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211105')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 11, '211105'
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211103')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 10, '211103'
		END	

				IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211202')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 9, '211202'
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211116')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 6, '211116'
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '211115')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 5, '211115'
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111815')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 4, '111815'
		END	


		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111808')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 2, '111808'
		END	

		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111105')	
		BEGIN 
			EXEC CNT.spSetCoefficientSlDefault 1, '111105'
		END	
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111505')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111505')
			EXEC FMK.spSetConfiguration 'ContractInventoryDeliverySL' , @Value
		END
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111003')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111003')
			EXEC FMK.spSetConfiguration 'PettyCashSL' , @Value
		END	
		IF EXISTS (SELECT 1 FROM Acc.vwAccount where FullCode = '111004')	
		BEGIN 
			SET @Value = (SELECT AccountId FROM Acc.vwAccount WHERE FullCode = '111004')
			EXEC FMK.spSetConfiguration 'PettyCashCurrencySL' , @Value
		END	
	END

	IF @Type = 0
	BEGIN
		EXEC FMK.spSetConfiguration 'AssetSaleSL' , ''
		EXEC FMK.spSetConfiguration 'DefaultFixedAssetAcquisitionPurchaseSL' , ''
		EXEC FMK.spSetConfiguration 'SalvageLossSubsidiary' , ''
		if Exists (Select 1 from acc.Account where AccountId = 130)
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , '130'
		else 
			Exec FMK.spSetConfiguration 'FixedAssetPayableSL' , ''	

		EXEC FMK.spSetConfiguration 'CustomsClearanceSlAccount' , ''
		EXEC FMK.spSetConfiguration 'CommercialOrderSlAccount' , ''
		EXEC FMK.spSetConfiguration 'InsurancePolicySLAccount' , ''
		EXEC FMK.spSetConfiguration 'BillOfLoadingSLAccount' , ''
		EXEC FMK.spSetConfiguration 'PurchaseInvoicePayableSLAccount' , ''
		EXEC FMK.spSetConfiguration 'PurchaseCostSLAccount' , ''
		EXEC FMK.spSetConfiguration 'ContractStatusPayableSL' , ''
		EXEC FMK.spSetConfiguration 'GuaranteePaidCreditSL' , ''
		EXEC FMK.spSetConfiguration 'GuaranteeReceivedCreditSL' , ''
	END

END