--<<FileName:POM_PurchaseRequestItemVendor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POM.PurchaseRequestItemVendor') Is Null
CREATE TABLE [POM].[PurchaseRequestItemVendor](
	[PurchaseRequestItemVendorID] [int] NOT NULL,
	[PurchaseRequestItemRef] [int] NOT NULL,
	[VendorDlRef] [int] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseRequestItemVendor') and
--				[name] = 'Description')
--begin
--    Alter table POM.PurchaseRequestItem Add Description NVARCHAR(255) NULL
--end
--GO

--<< ALTER COLUMNS >>--

--IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('POM.PurchaseRequestItemVendor') AND
--				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
--BEGIN
--	UPDATE POM.PurchaseRequestItemVendor
--	SET DiscountInBaseCurrency = 0
--	WHERE DiscountInBaseCurrency IS NULL

--	ALTER TABLE POM.PurchaseRequestItemVendor ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
--END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PurchaseRequestItemVendor')
ALTER TABLE [POM].[PurchaseRequestItemVendor] ADD CONSTRAINT [PK_PurchaseRequestItemVendor] PRIMARY KEY CLUSTERED 
(
	[PurchaseRequestItemVendorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PurchaseRequestItemVendor_PurchaseRequestItemRef')
	CREATE NONCLUSTERED INDEX IX_PurchaseRequestItemVendor_PurchaseRequestItemRef
		ON [POM].[PurchaseRequestItemVendor] ([PurchaseRequestItemRef], [VendorDlRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

If NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseRequestItemVendor_PurchaseRequestItemRef')
ALTER TABLE [POM].[PurchaseRequestItemVendor] ADD CONSTRAINT [FK_PurchaseRequestItemVendor_PurchaseRequestItemRef] 
FOREIGN KEY([PurchaseRequestItemRef])
REFERENCES [POM].[PurchaseRequestItem] ([PurchaseRequestItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseRequestItemVendor_VendorDlRef')
ALTER TABLE [POM].[PurchaseRequestItemVendor] ADD CONSTRAINT [FK_PurchaseRequestItemVendor_VendorDlRef] 
FOREIGN KEY([VendorDlRef])
REFERENCES [ACC].[DL] ([DLID])
GO

--<< DROP OBJECTS >>--
