--<<FileName:WKO_ProductionScheduling.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('WKO.ProductionScheduling') IS NULL
CREATE TABLE [WKO].[ProductionScheduling](
	[ProductionSchedulingID] [int] NOT NULL,
	[ProductOrderRef] [int] NOT NULL,
    [Description] [NVARCHAR](4000) NULL,
    [Start] [DATETIME] NOT NULL,
    [End] [DATETIME] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.ProductOrder') AND
				[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductOrder ADD ColumnName DataType Nullable
END
GO*/

--<< ALTER COLUMNS >>--

/*IF EXISTS (SELECT 1 FROM sys.columns WHERE  object_id=object_id('WKO.ProductOrder') AND
	[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductOrder ALTER COLUMN ColumnName DataType NOT NULL
END*/

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ProductionSchedulingID')
BEGIN
	ALTER TABLE [WKO].[ProductionScheduling] ADD CONSTRAINT [PK_ProductionSchedulingID] PRIMARY KEY CLUSTERED 
	(
		[ProductionSchedulingID] ASC
	) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductionScheduling_ProductOrder')
BEGIN
	ALTER TABLE [WKO].[ProductionScheduling] ADD CONSTRAINT [FK_ProductionScheduling_ProductOrder] FOREIGN KEY([ProductOrderRef])
	REFERENCES [WKO].[ProductOrder] ([ProductOrderId])
END
GO
--<< DROP OBJECTS >>--