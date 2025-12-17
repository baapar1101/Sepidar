--<<FileName:GNR_TaxPayerPartyMapping.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.TaxPayerPartyMapping') Is Null
CREATE TABLE [GNR].[TaxPayerPartyMapping](
	[TaxPayerPartyMappingID]		[int]	NOT NULL,
	[PartyRef]				        [int]	NOT NULL,
	[TaxPayerPartyType]				[INT]	NULL,
	[Version]				        [INT]	NOT NULL,
    [Creator]						[int]   NOT NULL,
	[CreationDate]					[datetime] NOT NULL,
	[LastModifier]					[int]      NOT NULL,
	[LastModificationDate]			[datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_TaxPayerPartyMapping')
ALTER TABLE [GNR].[TaxPayerPartyMapping] ADD CONSTRAINT [PK_TaxPayerPartyMapping] PRIMARY KEY CLUSTERED
(
    [TaxPayerPartyMappingID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_TaxPayerPartyMapping_TaxPayerPartyType')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TaxPayerPartyMapping_TaxPayerPartyType] ON [GNR].TaxPayerPartyMapping
(
    PartyRef,
    TaxPayerPartyType
) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'U_TaxPayerPartyMapping_PartyRef')
    ALTER TABLE [GNR].[TaxPayerPartyMapping] ADD CONSTRAINT [U_TaxPayerPartyMapping_PartyRef] UNIQUE ([PartyRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerPartyMapping_PartyRef')
ALTER TABLE [GNR].[TaxPayerPartyMapping] ADD CONSTRAINT [FK_TaxPayerPartyMapping_PartyRef] FOREIGN KEY(PartyRef)
REFERENCES GNR.Party ([PartyId])
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
