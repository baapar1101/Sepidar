--<<FileName:GNR_ClosingOperation.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.ClosingOperation') Is Null
CREATE TABLE [GNR].[ClosingOperation](
	[ClosingOperationId] [int] NOT NULL,
	[ClosingGroup] [int] NOT NULL,
	[ItemId] [int] NULL,
	[State] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[Version] [INT] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.ClosingOperation') and
				[name] = 'ColumnName')
begin
    Alter table GNR.ClosingOperation Add ColumnName DataType Nullable
end*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.ClosingOperation') and [name] = 'Version')
BEGIN
    ALTER TABLE [GNR].[ClosingOperation] ADD [Version] [int] NOT NULL DEFAULT(0)
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ClosingOperation')
ALTER TABLE [GNR].[ClosingOperation] ADD  CONSTRAINT [PK_ClosingOperation] PRIMARY KEY CLUSTERED 
(
	[ClosingOperationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_ClosingOperation_ClosingGroupItemIdFiscalYearRef')
	CREATE UNIQUE NONCLUSTERED INDEX [UIX_ClosingOperation_ClosingGroupItemIdFiscalYearRef] ON [GNR].[ClosingOperation]
	(
		[ClosingGroup],
		[ItemId],
		[FiscalYearRef]
	) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ClosingOperation_FiscalYearRef')
ALTER TABLE [GNR].[ClosingOperation]  ADD  CONSTRAINT [FK_ClosingOperation_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
