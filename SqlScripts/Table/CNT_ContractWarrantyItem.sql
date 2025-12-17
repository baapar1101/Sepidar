--<<FileName:CNT_ContractWarrantyItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractWarrantyItem') Is Null
CREATE TABLE [CNT].[ContractWarrantyItem](
	[ContractWarrantyItemID] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[WarrantyRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[Regard] [int] NOT NULL,
	[DueDate] [datetime] NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[DeliveryDate] [datetime] NOT NULL,
	[FurtherInfo] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractWarrantyItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractWarrantyItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.ContractWarrantyItem') AND
				[name] = 'DueDate' AND is_nullable = 0)
BEGIN
	ALTER TABLE CNT.ContractWarrantyItem ALTER COLUMN DueDate DATETIME NULL 
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractWarrantyItem')
ALTER TABLE [CNT].[ContractWarrantyItem] ADD  CONSTRAINT [PK_ContractWarrantyItem] PRIMARY KEY CLUSTERED 
(
	[ContractWarrantyItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractWarrantyItem_Contract')
ALTER TABLE [CNT].[ContractWarrantyItem]  ADD  CONSTRAINT [FK_ContractWarrantyItem_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractWarrantyItem_Warranty')
ALTER TABLE [CNT].[ContractWarrantyItem]  ADD  CONSTRAINT [FK_ContractWarrantyItem_Warranty] FOREIGN KEY([WarrantyRef])
REFERENCES [CNT].[Warranty] ([warrantyID])

GO

--<< DROP OBJECTS >>--
