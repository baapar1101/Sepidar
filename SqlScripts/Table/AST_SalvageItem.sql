--<<FileName:AST_SalvageITEM.sql>>--
--<< TABLE DEFINITION >>--

IF (Object_ID('AST.SalvageItem') Is Null)
BEGIN
CREATE TABLE [AST].[SalvageItem](
	[SalvageItemID] [int] NOT NULL,
	[AssetRef] [int] NOT NULL,
	[SalvageRef] [int] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Description_En] [nvarchar](255) NULL,
	[AssetTransactionRef] [int] NOT NULL,
 ) ON [PRIMARY]
END

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.Commission') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.Commission ADD ColumnName DataType Nullable
END
GO*/


--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_SalvageItem')
ALTER TABLE [AST].[SalvageItem] ADD  CONSTRAINT [PK_SalvageItem] PRIMARY KEY CLUSTERED 
(
	[SalvageItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
if NOT exists (select 1 from sys.objects where name =N'FK_AST_SalvageItem_SalvageRef')
BEGIN
    ALTER TABLE [AST].[SalvageItem]
    ADD CONSTRAINT [FK_AST_SalvageItem_SalvageRef]     
    FOREIGN KEY (SalvageRef) 
	REFERENCES [AST].[Salvage](SalvageID)
	ON UPDATE CASCADE
    ON DELETE CASCADE
END
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_SalvageItem_AssetRef')
ALTER TABLE [AST].[SalvageItem]  ADD  CONSTRAINT [FK_AST_SalvageItem_AssetRef] FOREIGN KEY(AssetRef)
REFERENCES [AST].[Asset](AssetId)