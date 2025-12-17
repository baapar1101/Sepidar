--<<FileName:CNT_Contract.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.Contract') Is Null
CREATE TABLE [CNT].[Contract](
	[ContractID]					[int] NOT NULL,
	[ProjectRef]					[int] NOT NULL,
	[Date]							[datetime] NOT NULL,
	[Title]							[nvarchar](250) NULL,
	[Title_En]						[nvarchar](250) NULL,
	[ContractorPartyRef]			[int] NOT NULL,
	[Location]						[nvarchar](250) NULL,
	[StartDate]						[datetime] NOT NULL,
	[EndDate]						[datetime] NOT NULL,
	[Cost]							[decimal](19, 4) NOT NULL,
	[DLRef]							[int] NOT NULL,
	[ContractTypeRef]				[int] NOT NULL,
	[Description]					[nvarchar](250) NULL,
	[Description_En]				[nvarchar](250) NULL,
	[AllowedChangePercent]			[real] NOT NULL,
	[Established]					[bit] NOT NULL,
	[EstimatedCost]					[decimal](19,4) NOT NULL,
	[DepositSum]					[decimal](19,4) NOT NULL,
	[MaterialSum]					[decimal](19,4) NOT NULL,
	[DepositDepreciationPercent]	[decimal](10,4) NULL,
	[DocumentNumber]				[nvarchar](50) NULL,
	[TenderRef]						[int] NULL,
	[CancelDate]					[DateTime] NULL,
	[ContractRef]					[int] NULL,	
	[Type]							[int] NOT NULL,
	[AffectedChange]				[int] NULL,
	[PrimaryFee]					[decimal](19, 4) NULL,
	[ChangeAmount]					[decimal](19, 4) NULL,
	[ChangeAmountType]				[int] NULL,
	[RowNumber]						[int] NOT NULL,
	[AnnexDocumentNumber]			[nvarchar](50) NULL,
	[AnnexDate]						[datetime] NULL,
	[OldChangeID]					[int] NULL,
	[Nature]						[int] NOT NULL,
	[Version]						[int] NOT NULL,
	[Creator]						[int] NOT NULL,
	[CreationDate]					[datetime] NOT NULL,
	[LastModifier]					[int] NOT NULL,
	[LastModificationDate]			[datetime] NOT NULL,
	[FiscalYearRef]					[int] NOT NULL, 
	[ContractRowNumber]				[nvarchar](250) NULL,
	[ContractDLType]				[int] NOT NULL,
	[ParentContractRef]				[int] NULL,	
	[IsActive]					[bit] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ALTER COLUMNS >>--
IF EXISTS (
	SELECT 1
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_SCHEMA = 'CNT' AND
		  TABLE_NAME = 'Contract' AND 
	      COLUMN_NAME = 'DepositDepreciationPercent' AND
	      DATA_TYPE = 'real')
BEGIN
	ALTER TABLE CNT.[Contract]
		ALTER COLUMN DepositDepreciationPercent decimal(10, 4) NULL
END	
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Contract Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ContractDLType')
begin
    Alter table CNT.Contract Add [ContractDLType] [int] NOT NULL DEFAULT 7
end
GO


if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'FiscalYearRef')
begin
    Alter table CNT.Contract Add [FiscalYearRef] [int] NOT NULL DEFAULT 1
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'DLRef')
begin
    Alter table CNT.Contract Add 	[DLRef] [int] NOT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'Established')
begin
    Alter table CNT.Contract Add Established bit NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'EstimatedCost')
begin
    Alter table CNT.Contract Add EstimatedCost Decimal(19,4) NOT NULL DEFAULT 0  
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'OnAccountSum')
begin
    Alter table CNT.Contract Add OnAccountSum Decimal(19,4) NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'DepositSum')
begin
    Alter table CNT.Contract Add DepositSum Decimal(19,4) NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'MaterialSum')
begin
    Alter table CNT.Contract Add MaterialSum Decimal(19,4) NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'OnAccountDepreciationPercent')
begin
    Alter table CNT.Contract Add OnAccountDepreciationPercent real  null  
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'DepositDepreciationPercent')
begin
    Alter table CNT.Contract Add DepositDepreciationPercent real  null  
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'DocumentNumber')
begin
    Alter table CNT.Contract Add DocumentNumber [nvarchar](50)  null
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ProjectRef')
begin
    Alter table CNT.Contract Add [ProjectRef] [int] NOT NULL
end
GO

if not exists (select 1 from sys.columns where object_id = object_id('CNT.Contract') and
				[name] = 'ContractRowNumber') 
begin
	Alter table CNT.Contract Add [ContractRowNumber] [nvarchar] (250) null
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'NeedsBillSerial')
begin
    ALTER TABLE CNT.Contract ADD NeedsBillSerial bit NOT NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'TenderRef')
begin
    Alter table CNT.Contract Add TenderRef [int] NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'CancelDate')
begin
    Alter table CNT.Contract Add CancelDate [DateTime] NULL
end
GO

--

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ContractRef')
begin
    Alter table CNT.Contract Add ContractRef [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'Type')
begin
    Alter table CNT.Contract Add [Type] [int] NULL
end

GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'Type')
begin
	UPDATE CNT.Contract set [Type] = 5 WHERE [Type] IS NULL
    Alter table CNT.Contract ALTER COLUMN [Type] [int] not NULL
end
go

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'AffectedChange')
begin
    Alter table CNT.Contract Add AffectedChange [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'PrimaryFee')
begin
    Alter table CNT.Contract Add PrimaryFee [decimal](19, 4) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ChangeAmount')
begin
    Alter table CNT.Contract Add ChangeAmount [decimal](19, 4) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ChangeAmountType')
begin
    Alter table CNT.Contract Add ChangeAmountType [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'RowNumber')
begin
    Alter table CNT.Contract Add RowNumber [int] NULL
end
GO
if exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'RowNumber')
begin
	update CNT.Contract set RowNumber = 1 where RowNumber is null
    Alter table CNT.Contract ALTER COLUMN RowNumber [int] not NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'AnnexDocumentNumber')
begin
    Alter table CNT.Contract Add AnnexDocumentNumber [nvarchar](50) NULL
end

GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'AnnexDate')
begin
    Alter table CNT.Contract Add AnnexDate [datetime] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'OldChangeID')
begin
    Alter table CNT.Contract Add OldChangeID [int] NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'Nature')
begin
    Alter table CNT.Contract Add Nature [int] NULL
end
GO
if exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'Nature')
begin
	update CNT.Contract set Nature = 1 where Nature is null
    Alter table CNT.Contract ALTER COLUMN Nature [int] not NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ParentContractRef')
begin
    Alter table CNT.Contract Add ParentContractRef [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'IsActive')
begin
    Alter table CNT.Contract Add IsActive [bit] NULL DEFAULT(1)
end
GO
if exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'IsActive')
begin
	update CNT.Contract set IsActive = 1 where IsActive is null
    Alter table CNT.Contract ALTER COLUMN IsActive [bit] NOT NULL
end
GO



--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Contract') and
				[name] = 'OnAccountSum')
BEGIN
    ALTER TABLE CNT.Contract ALTER COLUMN OnAccountSum [decimal](19,4)  NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Contract_1')
ALTER TABLE [CNT].[Contract] ADD  CONSTRAINT [PK_Contract_1] PRIMARY KEY CLUSTERED 
(
	[ContractID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Contract_ContractorPartyRef')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_ContractorPartyRef] FOREIGN KEY([ContractorPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_ContractType')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_ContractType] FOREIGN KEY([ContractTypeRef])
REFERENCES [CNT].[ContractType] ([ContractTypeID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_DLRef')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_DLRef] FOREIGN KEY([DLRef])
REFERENCES [ACC].[DL] ([DLId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Contract_FiscalYearRef')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Contract_ProjectRef')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_ProjectRef] FOREIGN KEY([ProjectRef])
REFERENCES [CNT].[Project] ([ProjectId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Contract_TenderRef')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_TenderRef] FOREIGN KEY([TenderRef])
REFERENCES [CNT].[Tender] ([TenderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Contract_ContractRef')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_ContractRef] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Contract_ParentContractRef')
ALTER TABLE [CNT].[Contract]  ADD  CONSTRAINT [FK_Contract_ParentContractRef] FOREIGN KEY([ParentContractRef])
REFERENCES [CNT].[Contract] ([ContractId])

GO

--<< DROP OBJECTS >>--
If  Exists (select 1 from sys.indexes where name = 'UIX_Contract_CostCenter')
DROP INDEX [UIX_Contract_CostCenter] ON [CNT].[Contract]

GO

If Exists (select 1 from sys.foreign_keys where name = 'FK_Contract_CostCenterRef' AND parent_object_id=object_id('CNT.Contract'))
ALTER TABLE [CNT].[Contract]  DROP  CONSTRAINT [FK_Contract_CostCenterRef]

GO


If Exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'CostCenterRef')
ALTER TABLE [CNT].[Contract]  DROP COLUMN [CostCenterRef]
GO


if exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'Number')
begin
    Alter table CNT.Contract DROP COLUMN Number
end
GO
