--<<FileName:SLS_CommissionItem.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('SLS.CommissionItem') IS NULL
CREATE TABLE [SLS].[CommissionItem](
	[CommissionItemId] [int] NOT NULL,
	[CommissionRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.CommissionItem') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.CommissionItem Add ColumnName DataType Nullable
END
GO*/

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CommissionItem')
ALTER TABLE [SLS].[CommissionItem] ADD  CONSTRAINT [PK_CommissionItem] PRIMARY KEY CLUSTERED 
(
	[CommissionItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_CommissionItem_CommissionRef_ItemRef')
CREATE UNIQUE NONCLUSTERED INDEX [UX_CommissionItem_CommissionRef_ItemRef] ON [SLS].[CommissionItem] 
(
	[CommissionRef] ASC,
	[ItemRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_CommissionItem_CommissionRef')
	ALTER TABLE [SLS].[CommissionItem] ADD CONSTRAINT [FK_CommissionItem_CommissionRef] FOREIGN KEY([CommissionRef])
	REFERENCES [SLS].[Commission] ([CommissionId])
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_CommissionItem_ItemRef')
BEGIN
	ALTER TABLE [SLS].[CommissionItem] ADD CONSTRAINT [FK_CommissionItem_ItemRef] FOREIGN KEY([ItemRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO
	
--<< DROP OBJECTS >>--
