--<<FileName:GNR_BillItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.BillItem') Is Null
CREATE TABLE [GNR].[BillItem](
	[BillItemID] [int] NOT NULL,
	[BillRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[InvoiceRef] [int] NULL,
	[ReturnedInvoiceRef] [int] NULL,
	[DebitCreditNoteRef] [int] NULL,
	[InventoryReceiptRef] [int] NULL,
	[ServiceInventoryPurchaseInvoiceRef] [int] NULL,
	[PaymentHeaderRef] [int] NULL,
	[ReceiptHeaderRef] [int] NULL,
	[RefundChequeRef] [int] NULL,
	[ShredRef] [int] NULL,
	[PurchaseInvoiceRef] [int] NULL,
	[BillOfLoadingRef] [int] NULL,
	[InsurancePolicyRef] [int] NULL,
	[CommercialOrderRef] [int] NULL,
	[CustomsClearanceRef] [int] NULL,

	AmountInBaseCurrency decimal(19, 4) NULL,
	Amount decimal(19, 4) NULL,
	[VoucherRef] [int] NULL,
	EntityFullName varchar(500)
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'AmountInBaseCurrency')
begin
    Alter table GNR.BillItem Add AmountInBaseCurrency decimal(19, 4) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'Amount')
begin
    Alter table GNR.BillItem Add Amount decimal(19, 4) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'EntityFullName')
begin
    Alter table GNR.BillItem Add EntityFullName varchar(500)
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'RefundChequeRef')
begin
    Alter table GNR.BillItem Add RefundChequeRef INT NULL
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.BillItem') and
				[name] = 'ServiceInventoryPurchaseInvoiceRef')
BEGIN
    ALTER TABLE GNR.BillItem ADD [ServiceInventoryPurchaseInvoiceRef] [int] NULL
END
GO	 

if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'ShredRef')
begin
    Alter table GNR.BillItem Add ShredRef INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'PurchaseInvoiceRef')
begin
    Alter table GNR.BillItem Add PurchaseInvoiceRef INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'BillOfLoadingRef')
begin
    Alter table GNR.BillItem Add BillOfLoadingRef INT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'InsurancePolicyRef')
begin
    Alter table GNR.BillItem Add InsurancePolicyRef INT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'CommercialOrderRef')
begin
    Alter table GNR.BillItem Add CommercialOrderRef INT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'CustomsClearanceRef')
begin
    Alter table GNR.BillItem Add CustomsClearanceRef INT NULL
end
GO
--<< ALTER COLUMNS >>--
If Exists (select 1 from sys.objects where name = 'FK_BillItem_VoucherRef')
begin
	ALTER TABLE [GNR].[BillItem]  DROP CONSTRAINT [FK_BillItem_VoucherRef] 
end
GO
if exists (select 1 from sys.columns where object_id=object_id('GNR.BillItem') and
				[name] = 'VoucherRef')
begin
    Alter table GNR.BillItem drop column VoucherRef
end
GO	

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_BillItem')
ALTER TABLE [GNR].[BillItem] ADD  CONSTRAINT [PK_BillItem] PRIMARY KEY CLUSTERED 
(
	[BillItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_BillRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_BillRef] FOREIGN KEY([BillRef])
REFERENCES [GNR].[Bill] ([BillID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_BillItem_DebitCreditNoteRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_DebitCreditNoteRef] FOREIGN KEY([DebitCreditNoteRef])
REFERENCES [GNR].[DebitCreditNote] ([DebitCreditNoteID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BillItem_InventoryReceiptRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_InventoryReceiptRef] FOREIGN KEY([InventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_BillItem_ServiceInventoryPurchaseInvoiceRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_ServiceInventoryPurchaseInvoiceRef] FOREIGN KEY([ServiceInventoryPurchaseInvoiceRef])
REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_InvoiceRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BillItem_PaymentHeaderRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_PaymentHeaderRef] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BillItem_ReceiptHeaderRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_ReceiptHeaderRef] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BillItem_ReturnedInvoiceRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_ShredRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_ShredRef] FOREIGN KEY([ShredRef])
REFERENCES [GNR].[Shred] ([ShredId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_PurchaseInvoiceRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_PurchaseInvoiceRef] FOREIGN KEY([PurchaseInvoiceRef])
REFERENCES [POM].[PurchaseInvoice] ([PurchaseInvoiceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_BillOfLoadingRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_BillOfLoadingRef] FOREIGN KEY([BillOfLoadingRef])
REFERENCES [POM].[BillOfLoading] ([BillOfLoadingID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_InsurancePolicyRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_InsurancePolicyRef] FOREIGN KEY([InsurancePolicyRef])
REFERENCES [POM].[InsurancePolicy] ([InsurancePolicyID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_CommercialOrderRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_CommercialOrderRef] FOREIGN KEY([CommercialOrderRef])
REFERENCES [POM].[CommercialOrder] ([CommercialOrderID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_CustomsClearanceRef')
ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_CustomsClearanceRef] FOREIGN KEY([CustomsClearanceRef])
REFERENCES [POM].[CustomsClearance] ([CustomsClearanceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillItem_RefundChequeRef')
BEGIN
	DECLARE @problems AS TABLE (BillID INT,BillNumber INT, BillDate DATETIME, BillItemID INT)

	INSERT INTO @problems
	SELECT DISTINCT b.BillID, b.Number AS BillNumber, b.Date AS BillDate, bi.BillItemID
	FROM
		GNR.Bill b INNER JOIN
		GNR.BillItem bi ON b.BillID = bi.BillRef LEFT JOIN
		RPA.RefundCheque rc ON bi.RefundChequeRef=rc.RefundChequeId
	WHERE bi.RefundChequeRef IS NOT NULL AND rc.RefundChequeId IS NULL

	IF EXISTS(SELECT * FROM @problems)
	BEGIN
		--SELECT * INTO GNR.BillRefundChequeProblem FROM @problems
		UPDATE bi SET RefundChequeRef = NULL FROM GNR.BillItem bi INNER JOIN @problems p ON bi.BillItemID=p.BillItemID
	END

	ALTER TABLE [GNR].[BillItem]  ADD  CONSTRAINT [FK_BillItem_RefundChequeRef] FOREIGN KEY([RefundChequeRef])
	REFERENCES [RPA].[RefundCheque] ([RefundChequeId])
END
GO

--<< DROP OBJECTS >>--
