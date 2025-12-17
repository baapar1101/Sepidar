--<<FileName:DST_DebtCollectionList.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.DebtCollectionList') IS NULL
CREATE TABLE [DST].[DebtCollectionList](
	[DebtCollectionListId]	[INT]				NOT NULL,
	[Date]					[DATETIME]			NOT NULL,
	[Number]				[INT]				NOT NULL,
	[DebtCollectorPartyRef]	[INT]				NOT NULL,
	[CurrencyRef] 			[INT]				NOT NULL,
	[Rate]					[DECIMAL](26, 16)	NOT NULL,
	[State]					[INT]				NOT NULL,
	[IsModifiedByDevice]	[bit]				NOT NULL DEFAULT 0,

	[FiscalYearRef]			[INT]				NOT NULL,

	[Version]				[INT]				NOT NULL,
	[Creator]				[INT]				NOT NULL,
	[CreationDate]			[DATETIME]			NOT NULL,
	[LastModifier]			[INT]				NOT NULL,
	[LastModificationDate]	[DATETIME]			NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('DST.DebtCollectionList') and
				[name] = 'IsModifiedByDevice')
begin
    Alter table DST.DebtCollectionList Add IsModifiedByDevice [BIT] NOT NULL  DEFAULT 0
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_DebtCollectionList')
ALTER TABLE [DST].[DebtCollectionList] ADD CONSTRAINT [PK_DebtCollectionList] PRIMARY KEY CLUSTERED 
(
	[DebtCollectionListId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_DebtCollectionList_Number_FiscalYearRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DebtCollectionList_Number_FiscalYearRef] ON [DST].[DebtCollectionList] 
(
	[Number] ASC,
	[FiscalYearRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_DebtCollectionList_DebtCollectorPartyRef')
ALTER TABLE [DST].[DebtCollectionList] ADD CONSTRAINT [FK_DebtCollectionList_DebtCollectorPartyRef] FOREIGN KEY([DebtCollectorPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_DebtCollectionList_CurrencyRef')
ALTER TABLE [DST].[DebtCollectionList] ADD CONSTRAINT [FK_DebtCollectionList_CurrencyRef] FOREIGN KEY ([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_DebtCollectionList_FiscalYearRef')
ALTER TABLE [DST].[DebtCollectionList] ADD CONSTRAINT [FK_DebtCollectionList_FiscalYearRef] FOREIGN KEY ([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
