--<<FileName:CNT_ContractAgreementItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractAgreementItem') Is Null
CREATE TABLE [CNT].[ContractAgreementItem](
	[ContractAgreementItemID]		[int] NOT NULL,
	[ContractRef]				    [int] NOT NULL,
	[ContractPriceListFieldTitle]   [nvarchar](250) NULL,
	[ContractPriceListChapterTitle] [nvarchar](250) NULL,
	[ContractPriceListClassTitle]   [nvarchar](250) NULL,
	[OperationalYear]               [nvarchar](250) NULL,
	[OperationCode]                 [nvarchar](250) NULL,
	[OperationDescription]          [nvarchar](250) NULL,
	[OperationUnit]                 [nvarchar](250) NULL,
	[OperationFee]                  [decimal](19,4) NOT NULL,
	[Quantity]                      [decimal](19,4) NOT NULL,
	[Price]                         [decimal](19,4) NOT NULL,
	[PrvOperationFee]               [decimal](19,4) NOT NULL,
	[PrvQuantity]                   [decimal](19,4) NOT NULL,
	[PrvPrice]                      [decimal](19,4) NOT NULL,
	[ContractAgreementItemRef]	    [int] NULL,
    [TaxPayerContractAgreementItemMapperRef] [int] NULL
	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractAgreementItem Add ColumnName DataType Nullable
end
GO*/


if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
				[name] = 'PrvOperationFee')
begin
    Alter table CNT.ContractAgreementItem Add PrvOperationFee Decimal(19,4) NULL
end
GO
if exists (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
				[name] = 'PrvOperationFee')
begin
	UPDATE CNT.ContractAgreementItem set PrvOperationFee = 0 WHERE PrvOperationFee IS NULL
    Alter table CNT.ContractAgreementItem ALTER COLUMN PrvOperationFee Decimal(19,4) not NULL
end
GO 

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
				[name] = 'PrvQuantity')
begin
    Alter table CNT.ContractAgreementItem Add PrvQuantity Decimal(19,4) NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
				[name] = 'PrvQuantity')
begin
	UPDATE CNT.ContractAgreementItem set PrvQuantity = 0 WHERE PrvQuantity IS NULL
    Alter table CNT.ContractAgreementItem ALTER COLUMN PrvQuantity Decimal(19,4) not NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
				[name] = 'PrvPrice')
begin
    Alter table CNT.ContractAgreementItem Add PrvPrice Decimal(19,4) NULL
end
GO
if exists (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
				[name] = 'PrvPrice')
begin
	UPDATE CNT.ContractAgreementItem set PrvPrice = 0 WHERE PrvPrice IS NULL
    Alter table CNT.ContractAgreementItem ALTER COLUMN PrvPrice Decimal(19,4) not NULL
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.ContractAgreementItem') AND
				[name] = 'ContractAgreementItemRef')
BEGIN
    ALTER TABLE CNT.ContractAgreementItem Add [ContractAgreementItemRef]	[int] NULL
END
GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('CNT.ContractAgreementItem') and
                [name] = 'TaxPayerContractAgreementItemMapperRef')
BEGIN
    ALTER TABLE CNT.ContractAgreementItem ADD [TaxPayerContractAgreementItemMapperRef] [int] NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractAgreementItem')
ALTER TABLE [CNT].[ContractAgreementItem] ADD  CONSTRAINT [PK_ContractAgreementItem] PRIMARY KEY CLUSTERED 
(
	[ContractAgreementItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractAgreementItem_ContractRef')
ALTER TABLE [CNT].[ContractAgreementItem]  ADD  CONSTRAINT [FK_ContractAgreementItem_ContractRef] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ContractAgreementItem_TaxPayerContractAgreementItemMapperRef')
ALTER TABLE [CNT].[ContractAgreementItem]  ADD  CONSTRAINT [FK_ContractAgreementItem_TaxPayerContractAgreementItemMapperRef] FOREIGN KEY([TaxPayerContractAgreementItemMapperRef])
REFERENCES [GNR].[TaxPayerContractAgreementItemMapper] ([TaxPayerContractAgreementItemMapperID])
ON DELETE SET NULL
GO

--<< DROP OBJECTS >>--
