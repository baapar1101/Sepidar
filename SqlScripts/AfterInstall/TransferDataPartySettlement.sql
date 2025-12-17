IF NOT EXISTS (SELECT 1 
FROM RPA.PartySettlement ps INNER JOIN RPA.PartyAccountSettlement pas 
ON ps.PartySettlementID = pas.OldPartySettlementID)

BEGIN
  DECLARE @RecordCount int = 0
  DECLARE @ItemId int

  DECLARE @Step int = 0
  DECLARE @ID int = 0
  SELECT
    @RecordCount = COUNT(1)
  FROM rpa.PartySettlement

  EXEC [FMK].[spGetNextId] @tablename = 'rpa.PartyAccountSettlement',
                           @id = @ItemId OUTPUT,
                           @incvalue = @RecordCount

  SET @Step = @ItemId - @RecordCount
  SELECT
    @ID = @Step

  INSERT INTO rpa.PartyAccountSettlement (PartyAccountSettlementId,
  Number,
  Date,
  State,
  PartyRef,
  CurrencyRef,
  Rate,
  PartyAccountSettlementType,
  Description,
  FiscalYearRef,
  VoucherRef,
  CreatorForm,
  Creator,
  CreationDate,
  LastModifier,
  LastModificationDate,
  Version,
  OldPartySettlementID)
    SELECT
      ROW_NUMBER() OVER (ORDER BY partysettlementid) + @ID,
      Number,
      Date,
      State,
      PartyRef,
      CurrencyRef,
      Rate,
      SettlementType,
      Description,
      FiscalYearRef,
      VoucherRef,
      CreatorForm,
      Creator,
      CreationDate,
      LastModifier,
      LastModificationDate,
      Version,
      PartySettlementID

    FROM rpa.PartySettlement
    WHERE PartySettlementID NOT IN (SELECT DISTINCT OldPartySettlementID 
    FROM RPA.PartyAccountSettlement 
    WHERE OldPartySettlementID IS NOT NULL)

  IF @RecordCount > 0
    UPDATE fmk.IDGeneration
    SET LastId = (SELECT
      MAX(PartyAccountSettlementId)
    FROM rpa.PartyAccountSettlement)
    WHERE TableName = 'rpa.PartyAccountSettlement'

END
GO
IF NOT EXISTS (SELECT 1 FROM RPA.PartySettlement ps 
  INNER JOIN RPA.PartyAccountSettlementItem pasi 
  ON ps.PartySettlementID = pasi.OldPartySettlementID
  WHERE ps.ReceiptHeaderRef IS NOT NULL AND pasi.CreditEntityType = 23)
BEGIN
  DECLARE @RecordCount int = 0
  DECLARE @ItemId int

  DECLARE @Step int = 0
  DECLARE @ID int = 0
  SELECT
    @RecordCount = 0,
    @ItemId = 0,
    @Step = 0,
    @ID = 0
  SELECT
    @RecordCount = COUNT(1)
  FROM rpa.PartySettlement
  WHERE ReceiptHeaderRef IS NOT NULL


  EXEC [FMK].[spGetNextId] @tablename = 'rpa.PartyAccountSettlementItem',
                           @id = @ItemId OUTPUT,
                           @incvalue = @RecordCount

  SET @Step = @ItemId - @RecordCount
  SELECT
    @ID = @Step

  INSERT INTO rpa.PartyAccountSettlementItem (PartyAccountSettlementItemID,
  PartyAccountSettlementRef,
  CurrencyRef,
  Amount,
  CreditEntityType,
  CreditEntityRef,
  OldPartySettlementID)
    SELECT
      ROW_NUMBER() OVER (ORDER BY S.partysettlementid) + @ID,
      A.PartyAccountSettlementId,
      S.CurrencyRef,
      S.TotalAmount - S.SettlementByRemainingAmount,
      23, --CreditEntityType = Receipt
      S.ReceiptHeaderRef,
      S.PartySettlementID


    FROM rpa.vwPartySettlement S
    INNER JOIN rpa.PartyAccountSettlement A
      ON S.PartySettlementID = A.OldPartySettlementID
    WHERE ReceiptHeaderRef IS NOT NULL AND S.PartySettlementID NOT IN (SELECT DISTINCT pasi.OldPartySettlementID 
    FROM RPA.PartyAccountSettlementItem pasi 
    WHERE pasi.CreditEntityType = 23 
    AND pasi.OldPartySettlementID IS NOT NULL)

  IF @RecordCount > 0
    UPDATE fmk.IDGeneration
    SET LastId = (SELECT
      MAX(PartyAccountSettlementItemId)
    FROM rpa.PartyAccountSettlementItem)
    WHERE TableName = 'rpa.PartyAccountSettlementItem'
END
GO
IF NOT EXISTS(SELECT 1 FROM 
  RPA.PartySettlementItem psi JOIN RPA.PartyAccountSettlementItem pasi 
  ON pasi.OldPartySettlementItemID = psi.PartySettlementItemID
   WHERE psi.InvoiceRef IS NOT NULL AND pasi.DebitEntityType = 1)
  BEGIN
  DECLARE @RecordCount int = 0
  DECLARE @ItemId int

  DECLARE @Step int = 0
  DECLARE @ID int = 0
  SELECT
    @RecordCount = 0,
    @ItemId = 0,
    @Step = 0,
    @ID = 0
  SELECT
    @RecordCount = COUNT(1)
  FROM rpa.PartySettlementItem
  WHERE InvoiceRef IS NOT NULL

  EXEC [FMK].[spGetNextId] @tablename = 'rpa.PartyAccountSettlementItem',
                           @id = @ItemId OUTPUT,
                           @incvalue = @RecordCount

  SET @Step = @ItemId - @RecordCount
  SELECT
    @ID = @Step

  INSERT INTO rpa.PartyAccountSettlementItem (PartyAccountSettlementItemID,
  PartyAccountSettlementRef,
  CurrencyRef,
  Amount,
  DebitEntityType,
  DebitEntityRef,
  OldPartySettlementID,
  OldPartySettlementItemID)
    SELECT
      ROW_NUMBER() OVER (ORDER BY S.partysettlementid)+ @ID ,
      A.PartyAccountSettlementId,
      SI.CurrencyRef,
         SI.Amount,
        1, --DebitEntityType = Invoice
      SI.InvoiceRef,
      S.PartySettlementID,
      SI.PartySettlementItemID
    FROM rpa.vwPartySettlementItem SI
    INNER JOIN rpa.vwPartySettlement S
      ON SI.PartySettlementRef = S.PartySettlementID
    INNER JOIN rpa.PartyAccountSettlement A
      ON S.PartySettlementID = A.OldPartySettlementID
	    WHERE si.InvoiceRef IS NOT NULL AND SI.PartySettlementItemID NOT IN (SELECT DISTINCT pasi.OldPartySettlementItemID 
		From rpa.PartyAccountSettlementItem pasi 
		WHERE pasi.DebitEntityType = 1 AND pasi.OldPartySettlementItemID IS NOT NULL)

  IF @RecordCount > 0
    UPDATE fmk.IDGeneration
    SET LastId = (SELECT
      MAX(PartyAccountSettlementItemId)
    FROM rpa.PartyAccountSettlementItem)
    WHERE TableName = 'rpa.PartyAccountSettlementItem'
	END
GO
IF NOT EXISTS (SELECT 1 FROM RPA.PartySettlement ps 
	INNER JOIN RPA.PartyAccountSettlementItem pasi 
	ON pasi.OldPartySettlementID = ps.PartySettlementID
    WHERE ps.PaymentHeaderRef IS NOT NULL AND pasi.DebitEntityType = 2)
	BEGIN
  DECLARE @RecordCount int = 0
  DECLARE @ItemId int

  DECLARE @Step int = 0
  DECLARE @ID int = 0
	 SELECT
    @RecordCount = 0,
    @ItemId = 0,
    @Step = 0,
    @ID = 0

  SELECT
    @RecordCount = COUNT(1)
  FROM rpa.PartySettlement
  WHERE PaymentHeaderRef IS NOT NULL

  EXEC [FMK].[spGetNextId] @tablename = 'rpa.PartyAccountSettlementItem',
                           @id = @ItemId OUTPUT,
                           @incvalue = @RecordCount

  SET @Step = @ItemId - @RecordCount
  SELECT
    @ID = @Step

  INSERT INTO rpa.PartyAccountSettlementItem (PartyAccountSettlementItemID,
  PartyAccountSettlementRef,
  CurrencyRef,
  Amount,
  DebitEntityType,
  DebitEntityRef,
  OldPartySettlementID)
    SELECT
      ROW_NUMBER() OVER (ORDER BY S.partysettlementid) + @ID,
      A.PartyAccountSettlementId,
      S.CurrencyRef,
        S.TotalAmount,
      2, --DebitEntityType = Payment
      S.PaymentHeaderRef,
      S.PartySettlementID


    FROM rpa.vwPartySettlement S
    INNER JOIN rpa.PartyAccountSettlement A
      ON S.PartySettlementID = A.OldPartySettlementID AND S.PartySettlementID NOT IN (SELECT DISTINCT pasi.OldPartySettlementID 
	  FROM RPA.PartyAccountSettlementItem pasi 
	  WHERE pasi.DebitEntityType = 2 AND pasi.OldPartySettlementID IS NOT NULL)
    WHERE PaymentHeaderRef IS NOT NULL 

  IF @RecordCount > 0
    UPDATE fmk.IDGeneration
    SET LastId = (SELECT
      MAX(PartyAccountSettlementItemId)
    FROM rpa.PartyAccountSettlementItem)
    WHERE TableName = 'rpa.PartyAccountSettlementItem'
END
GO
IF NOT EXISTS (SELECT 1 FROM RPA.PartySettlement ps 
  INNER JOIN RPA.PartyAccountSettlementItem pasi 
  ON pasi.OldPartySettlementID = ps.PartySettlementID
  WHERE  ps.SettlementByRemainingAmount <> 0 AND pasi.CreditEntityType = 29)
BEGIN
  DECLARE @RecordCount int = 0
  DECLARE @ItemId int

  DECLARE @Step int = 0
  DECLARE @ID int = 0
    SELECT
    @RecordCount = 0,
    @ItemId = 0,
    @Step = 0,
    @ID = 0

  SELECT
    @RecordCount = COUNT(1)
  FROM rpa.PartySettlement
  WHERE SettlementByRemainingAmount <> 0


  EXEC [FMK].[spGetNextId] @tablename = 'rpa.PartyAccountSettlementItem',
                           @id = @ItemId OUTPUT,
                           @incvalue = @RecordCount

  SET @Step = @ItemId - @RecordCount
  SELECT
    @ID = @Step

  INSERT INTO rpa.PartyAccountSettlementItem (PartyAccountSettlementItemID,
  PartyAccountSettlementRef,
  CurrencyRef,
   Amount,
  CreditEntityType,
  CreditEntityRef,
  OldPartySettlementID)
    SELECT
      ROW_NUMBER() OVER (ORDER BY S.partysettlementid) + @ID,
      A.PartyAccountSettlementId,
      S.CurrencyRef,
      S.SettlementByRemainingAmount,
      29, --CreditEntityType = SettlementByRemaining
      S.PaymentHeaderRef,
      S.PartySettlementID


    FROM rpa.vwPartySettlement S
    INNER JOIN rpa.PartyAccountSettlement A
      ON S.PartySettlementID = A.OldPartySettlementID
    WHERE SettlementByRemainingAmount <> 0 AND S.PartySettlementID NOT IN(SELECT DISTINCT pasi.OldPartySettlementID 
    FROM RPA.PartyAccountSettlementItem pasi 
    WHERE pasi.CreditEntityType = 29 AND pasi.OldPartySettlementID IS NOT NULL)

  IF @RecordCount > 0
    UPDATE fmk.IDGeneration
    SET LastId = (SELECT
      MAX(PartyAccountSettlementItemId)
    FROM rpa.PartyAccountSettlementItem)
    WHERE TableName = 'rpa.PartyAccountSettlementItem'
END
GO
IF NOT EXISTS (SELECT 1 FROM RPA.PartySettlementItem psi 
  INNER JOIN RPA.PartyAccountSettlementItem pasi 
  ON pasi.OldPartySettlementItemID = psi.PartySettlementItemID
  WHERE psi.CommissionCalculationRef IS NOT NULL AND pasi.CreditEntityType = 21)
BEGIN
  DECLARE @RecordCount int = 0
  DECLARE @ItemId int

  DECLARE @Step int = 0
  DECLARE @ID int = 0
   SELECT
    @RecordCount = 0,
    @ItemId = 0,
    @Step = 0,
    @ID = 0
  SELECT
    @RecordCount = COUNT(1)
  FROM rpa.PartySettlementItem
  WHERE CommissionCalculationRef IS NOT NULL

  EXEC [FMK].[spGetNextId] @tablename = 'rpa.PartyAccountSettlementItem',
                           @id = @ItemId OUTPUT,
                           @incvalue = @RecordCount

  SET @Step = @ItemId - @RecordCount
  SELECT
    @ID = @Step

  INSERT INTO rpa.PartyAccountSettlementItem (PartyAccountSettlementItemID,
  PartyAccountSettlementRef,
  CurrencyRef,
  Amount,
  CreditEntityType,
  CreditEntityRef,
  OldPartySettlementID,
  OldPartySettlementItemID)
    SELECT
      ROW_NUMBER() OVER (ORDER BY S.partysettlementid) + @ID,
      A.PartyAccountSettlementId,
      SI.CurrencyRef,
      SI.Amount,
      21, --CreditEntityType = CommissionCalculation
      SI.CommissionCalculationRef,
      S.PartySettlementID,
      SI.PartySettlementItemID



    FROM rpa.vwPartySettlementItem SI
    INNER JOIN rpa.vwPartySettlement S
      ON SI.PartySettlementRef = S.PartySettlementID
    INNER JOIN rpa.PartyAccountSettlement A
      ON S.PartySettlementID = A.OldPartySettlementID
    WHERE CommissionCalculationRef IS NOT NULL AND SI.PartySettlementItemID NOT IN (SELECT DISTINCT pasi.OldPartySettlementItemID 
  From rpa.PartyAccountSettlementItem pasi 
  WHERE pasi.CreditEntityType = 21 AND pasi.OldPartySettlementItemID IS NOT NULL)	

  IF @RecordCount > 0
    UPDATE fmk.IDGeneration
    SET LastId = (SELECT
      MAX(PartyAccountSettlementItemId)
    FROM rpa.PartyAccountSettlementItem)
    WHERE TableName = 'rpa.PartyAccountSettlementItem'
END
GO