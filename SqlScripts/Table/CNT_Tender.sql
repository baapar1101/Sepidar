--<<FileName:CNT_Tender.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('CNT.Tender') Is Null
CREATE TABLE [CNT].[Tender](
	[TenderID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[DocumentNumber] [int] NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Title_En] [nvarchar](250) NULL,
	[TenderPartyRef] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[DLRef] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,		
	[IsActive] [bit] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,

) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Tender') AND [Name] = 'Established')
		ALTER TABLE CNT.Tender DROP COLUMN Established
				

--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Tender') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Tender Add ColumnName DataType Nullable
end
GO*/


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Tender_ID')
ALTER TABLE [CNT].[Tender] ADD  CONSTRAINT [PK_Tender_ID] PRIMARY KEY CLUSTERED 
(
	[TenderID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


If not Exists (select 1 from sys.objects where name = 'FK_Tender_DLRef')
ALTER TABLE [CNT].[Tender]  ADD  CONSTRAINT [FK_Tender_DLRef] FOREIGN KEY([DLRef])
REFERENCES [ACC].[DL] ([DLId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_Tender_PartyRef')
ALTER TABLE [CNT].[Tender]  ADD  CONSTRAINT [FK_Tender_PartyRef] FOREIGN KEY([TenderPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO


If not Exists (select 1 from sys.objects where name = 'FK_Tender_FiscalYearRef')
ALTER TABLE [CNT].[Tender]  ADD  CONSTRAINT [FK_Tender_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO


