--<<FileName:CNT_ContractPriceList.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractPriceList') Is Null
CREATE TABLE [CNT].[ContractPriceList](
    [ContractPriceListID]                    [int]           NOT NULL,
    [ContractPriceListChapterTitle]          [nvarchar](250) NULL,
    [ContractPriceListClassTitle]            [nvarchar](250) NULL,
    [ContractPriceListFieldTitle]            [nvarchar](250) NULL,
    [OperationalYear]                        [nvarchar](250) NULL,
    [OperationCode]                          [nvarchar](250) NULL,
    [OperationDescription]                   [nvarchar](250) NULL,
    [OperationUnit]                          [nvarchar](250) NULL,
    [OperationFee]                           [decimal](19,4) NULL,
    [TaxPayerContractAgreementItemMapperRef] [int]           NULL,
    [Version]                                [int]           NOT NULL,
    [Creator]                                [int]           NOT NULL,
    [CreationDate]                           [datetime]      NOT NULL,
    [LastModifier]                           [int]           NOT NULL,
    [LastModificationDate]                   [datetime]      NOT NULL,
    
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractPriceList') and
                [name] = 'ColumnName')
begin
    Alter table CNT.ContractPriceList Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('CNT.ContractPriceList') and
                [name] = 'TaxPayerContractAgreementItemMapperRef')
BEGIN
    ALTER TABLE CNT.ContractPriceList ADD [TaxPayerContractAgreementItemMapperRef] [int] NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractPriceList')
ALTER TABLE [CNT].[ContractPriceList] ADD  CONSTRAINT [PK_ContractPriceList] PRIMARY KEY CLUSTERED 
(
    [ContractPriceListID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ContractPriceList_TaxPayerContractAgreementItemMapperRef')
ALTER TABLE [CNT].[ContractPriceList]  ADD  CONSTRAINT [FK_ContractPriceList_TaxPayerContractAgreementItemMapperRef] FOREIGN KEY([TaxPayerContractAgreementItemMapperRef])
REFERENCES [GNR].[TaxPayerContractAgreementItemMapper] ([TaxPayerContractAgreementItemMapperID])
ON DELETE SET NULL
GO

--<< DROP OBJECTS >>--
