--<<FileName:SLS_CommissionArea.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('SLS.CommissionArea') IS NULL
CREATE TABLE [SLS].[CommissionArea](
	[CommissionAreaId] [int] NOT NULL,
	[CommissionRef]    [int] NOT NULL,
	[AreaRef]         [int] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('SLS.CommissionArea') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.CommissionArea ADD ColumnName DataType Nullable
END
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CommissionArea')
ALTER TABLE [SLS].[CommissionArea] ADD CONSTRAINT [PK_CommissionArea] PRIMARY KEY CLUSTERED 
(
	[CommissionAreaId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_CommissionArea_CommissionRef_AreaRef')
CREATE UNIQUE NONCLUSTERED INDEX [UX_CommissionArea_CommissionRef_AreaRef] ON [SLS].[CommissionArea] 
(
	[CommissionRef] ASC,
	[AreaRef] ASC
) ON [PRIMARY]

GO


--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_CommissionArea_CommissionRef')
	ALTER TABLE [SLS].[CommissionArea] ADD CONSTRAINT [FK_CommissionArea_CommissionRef] FOREIGN KEY([CommissionRef])
	REFERENCES [SLS].[Commission] ([CommissionId])
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_CommissionArea_AreaRef')
BEGIN
	ALTER TABLE [SLS].[CommissionArea] ADD CONSTRAINT [FK_CommissionArea_AreaRef] FOREIGN KEY([AreaRef])
	REFERENCES [DST].[AreaAndPath] ([AreaAndPathId])
END
GO

--<< DROP OBJECTS >>--
