--<<FileName:DST_OrderingFailure.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.OrderingFailure') IS NULL
CREATE TABLE [DST].[OrderingFailure](
	[OrderingFailureId]		[INT]		NOT NULL,
	[Date]					[DATETIME]	NOT NULL,
	[PartyRef]				[INT]		NOT NULL,
	[FiscalYearRef]			[INT]		NOT NULL,
	[Version]				[INT]		NOT NULL,
	[Creator]				[INT]		NOT NULL,
	[CreationDate]			[DATETIME]	NOT NULL,
	[LastModifier]			[INT]		NOT NULL,
	[LastModificationDate]	[DATETIME]	NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_OrderingFailure')
ALTER TABLE [DST].[OrderingFailure] ADD CONSTRAINT [PK_OrderingFailure] PRIMARY KEY CLUSTERED 
(
	[OrderingFailureId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_OrderingFailure_Date_PartyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_OrderingFailure_Date_PartyRef] ON [DST].[OrderingFailure] 
(
	[Date] ASC,
	[PartyRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_OrderingFailure_PartyRef')
ALTER TABLE [DST].[OrderingFailure]  ADD CONSTRAINT [FK_OrderingFailure_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If NOT Exists (select 1 from sys.objects where name = 'FK_OrderingFailure_FiscalYearRef')
ALTER TABLE [DST].[OrderingFailure] ADD CONSTRAINT [FK_OrderingFailure_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearID])

GO
--<< DROP OBJECTS >>--
