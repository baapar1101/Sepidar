--<<FileName:CNT_StatusItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.StatusItem') Is Null
CREATE TABLE [CNT].[StatusItem](
    [StatusItemID]               [int] NOT NULL,
    [StatusRef]                  [int] NOT NULL,
    [RowNumber]                  [int] NOT NULL,
    [ItemRef]                    [int]     NULL,
    [ContractAgreementItemRef]   [int]     NULL,
    [ItemTitle]                  [nvarchar](250) NULL,
    [ItemTitle_En]               [nvarchar](250) NULL,
    [Quantity]                   [decimal](19, 4) NOT NULL,
    [Fee]                        [decimal](19, 4) NOT NULL,
    [ConfirmedFee]               [decimal](19, 4) NOT NULL,
    [Price]                      [decimal](19, 4) NOT NULL,
    [ConfirmedQuantity]          [decimal](19, 4) NOT NULL,
    [ConfirmedPrice]             [decimal] (19, 4) NOT NULL,
    [TaxPayerContractAgreementItemMapperRef] [int] NULL,
    [Description]                [nvarchar](250) NULL,
    [Description_En]             [nvarchar](250) NULL,
    ) ON [PRIMARY]
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and
                [name] = 'ColumnName')
begin
    Alter table CNT.StatusItem Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and
                [name] = 'ConfirmedQuantity')
BEGIN
    Alter table CNT.StatusItem Add [ConfirmedQuantity] [decimal](19, 4) NOT NULL
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.StatusItem') AND [name] = 'ConfirmedFee')
BEGIN
    ALTER TABLE CNT.StatusItem ADD [ConfirmedFee] [decimal](19, 4) NULL        
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.StatusItem')
    AND [Name] = 'ConfirmedPrice')
BEGIN
DECLARE @query NVARCHAR(1000);
    SET @query = 'ALTER TABLE CNT.StatusItem ADD [ConfirmedPrice] [decimal](19, 4)  NULL'
EXECUTE(@query)
END     


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.StatusItem') AND [name] = 'ContractAgreementItemRef')
BEGIN
    ALTER TABLE CNT.StatusItem ADD [ContractAgreementItemRef] [int] NULL    
END
GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and
                [name] = 'ItemTitle')
BEGIN
    ALTER TABLE CNT.StatusItem ADD [ItemTitle] [nvarchar](250) NULL
END
GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and
                [name] = 'ItemTitle_En')
BEGIN
    ALTER TABLE CNT.StatusItem ADD [ItemTitle_En] [nvarchar](250) NULL
END
GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and
                [name] = 'TaxPayerContractAgreementItemMapperRef')
BEGIN
    ALTER TABLE CNT.StatusItem ADD [TaxPayerContractAgreementItemMapperRef] [int] NULL
END
GO

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.StatusItem') AND
                [Name] = 'Quantity' AND system_type_id=62 /* float */)
BEGIN            
    ALTER TABLE CNT.StatusItem ALTER COLUMN Quantity [decimal](19,4) NOT NULL
END

GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.StatusItem') 
            AND [name] = 'ConfirmedFee' AND Is_Nullable = 1)
BEGIN
    --Fill ConfirmedFee
    UPDATE CNT.StatusItem SET ConfirmedFee = Fee        
    ALTER TABLE CNT.StatusItem ALTER COLUMN [ConfirmedFee] [decimal](19, 4) NOT NULL
END    
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.StatusItem') 
            AND [name] = 'ItemRef' AND Is_Nullable = 0)
BEGIN
    ALTER TABLE CNT.StatusItem ALTER COLUMN [ItemRef] [int] NULL
END    
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.StatusItem') AND
                [Name] = 'ConfirmedPrice' AND is_computed = 1)
BEGIN

    ALTER TABLE CNT.StatusItem DROP COLUMN ConfirmedPrice
 
END
 
 GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.StatusItem')
    AND [Name] = 'ConfirmedPrice'
    AND is_nullable = 1)
BEGIN
DECLARE @query2 NVARCHAR(1000);
    SET @query2 = '
    UPDATE CNT.StatusItem SET ConfirmedPrice = (ConfirmedFee * ConfirmedQuantity)
    ALTER TABLE CNT.StatusItem ALTER COLUMN [ConfirmedPrice] [decimal](19, 4) NOT NULL'
EXECUTE(@query2)
END         
    
     

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_StatusItem_1')
ALTER TABLE [CNT].[StatusItem] ADD  CONSTRAINT [PK_StatusItem_1] PRIMARY KEY CLUSTERED 
(
    [StatusItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_StatusItem_Status')
ALTER TABLE [CNT].[StatusItem]  Add  CONSTRAINT [FK_StatusItem_Status] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_StatusItem_ItemRef')
ALTER TABLE [CNT].[StatusItem]  ADD  CONSTRAINT [FK_StatusItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_StatusItem_ContractAgreementItemRef')
ALTER TABLE [CNT].[StatusItem]  ADD  CONSTRAINT [FK_StatusItem_ContractAgreementItemRef] FOREIGN KEY([ContractAgreementItemRef])
REFERENCES [CNT].[contractAgreementItem] ([ContractAgreementItemID])
 
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_StatusItem_TaxPayerContractAgreementItemMapperRef')
ALTER TABLE [CNT].[StatusItem]  ADD  CONSTRAINT [FK_StatusItem_TaxPayerContractAgreementItemMapperRef] FOREIGN KEY([TaxPayerContractAgreementItemMapperRef])
REFERENCES [GNR].[TaxPayerContractAgreementItemMapper] ([TaxPayerContractAgreementItemMapperID])
ON DELETE SET NULL
GO

--<< DROP OBJECTS >>--

if exists (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and
                [name] = 'StockRef')
begin
    Alter table CNT.StatusItem Drop Column StockRef
end
GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and
                [name] = 'partyRef')
begin
    Alter table CNT.StatusItem Drop Column [partyRef]
end
GO


If Exists (select 1 from sys.objects where name = 'FK_StatusItem_Account' AND parent_object_id = object_id('CNT.StatusItem'))
    ALTER TABLE [CNT].[StatusItem]  DROP  CONSTRAINT [FK_StatusItem_Account]
GO


if exists (select 1 from sys.columns where object_id=object_id('CNT.StatusItem') and [name] = 'SLRef')
    Alter table CNT.StatusItem Drop Column SLRef
GO
