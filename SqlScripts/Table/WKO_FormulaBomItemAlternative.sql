--<<FileName:WKO_FormulaBomItemAlternative.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('WKO.FormulaBomItemAlternative') Is Null
CREATE TABLE [WKO].[FormulaBomItemAlternative](
	[FormulaBomItemAlternativeID] [int] NOT NULL,
	[FormulaBomItemRef] [int] NOT NULL,
    [ItemRef] [int] NOT NULL,
    [AlternativeRatio] [float] NOT NULL,
	[ItemTracingRef] int NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.FormulaBomItemAlternative') AND
				[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.FormulaBomItemAlternative ADD ColumnName DataType Nullable
END
GO*/

IF COLUMNPROPERTY(OBJECT_ID('WKO.FormulaBomItemAlternative'), 'ItemTracingRef' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.FormulaBomItemAlternative ADD [ItemTracingRef] int NULL
END
GO

--<< ALTER COLUMNS >>--

/*IF EXISTS (SELECT 1 FROM sys.columns WHERE  object_id=object_id('WKO.FormulaBomItemAlternative') AND
	[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.FormulaBomItemAlternative ALTER COLUMN ColumnName DataType NOT NULL
END*/

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_FormulaBomItemAlternativeID')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItemAlternative] ADD CONSTRAINT [PK_FormulaBomItemAlternativeID] PRIMARY KEY CLUSTERED 
	(
		[FormulaBomItemAlternativeID] ASC
	) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_FormulaBomItemAlternative_FormulaBomItemRef_ItemRef')
CREATE UNIQUE NONCLUSTERED INDEX [IX_FormulaBomItemAlternative_FormulaBomItemRef_ItemRef] ON [WKO].[FormulaBomItemAlternative]
(
	[FormulaBomItemRef] ASC,
	[ItemRef] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_FormulaBomItemAlternative_FormulaBomItemRef')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItemAlternative] ADD CONSTRAINT [FK_FormulaBomItemAlternative_FormulaBomItemRef]
	FOREIGN KEY([FormulaBomItemRef])
	REFERENCES [WKO].[FormulaBomItem] ([FormulaBomItemID])
	ON DELETE CASCADE
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_FormulaBomItemAlternative_ItemRef')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItemAlternative] ADD CONSTRAINT [FK_FormulaBomItemAlternative_ItemRef]
	FOREIGN KEY([ItemRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_FormulaBomItemAlternative_ItemTracingRef')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItemAlternative] ADD CONSTRAINT [FK_FormulaBomItemAlternative_ItemTracingRef] FOREIGN KEY([ItemTracingRef])
	REFERENCES [INV].[Tracing] ([TracingID])
END
GO
--<< DROP OBJECTS >>--