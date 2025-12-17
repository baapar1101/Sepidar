--<<FileName:AST_EliminationITEM.sql>>--
--<< TABLE DEFINITION >>--

IF (Object_ID('AST.EliminationItem') Is Null)
BEGIN
CREATE TABLE [AST].[EliminationItem](
	[EliminationItemID] [int] NOT NULL,
	[AssetRef] [int] NOT NULL,
	[EliminationRef] [int] NOT NULL,
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
If not Exists (select 1 from sys.objects where name = 'PK_EliminationItem')
ALTER TABLE [AST].[EliminationItem] ADD  CONSTRAINT [PK_EliminationItem] PRIMARY KEY CLUSTERED 
(
	[EliminationItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
if NOT exists (select 1 from sys.objects where name =N'FK_AST_EliminationItem_EliminationRef')
BEGIN
    ALTER TABLE [AST].[EliminationItem]
    ADD CONSTRAINT [FK_AST_EliminationItem_EliminationRef]     
    FOREIGN KEY (EliminationRef) 
	REFERENCES [AST].[Elimination](EliminationID)
	ON UPDATE CASCADE
    ON DELETE CASCADE
END
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_EliminationItem_AssetRef')
ALTER TABLE [AST].[EliminationItem]  ADD  CONSTRAINT [FK_AST_EliminationItem_AssetRef] FOREIGN KEY(AssetRef)
REFERENCES [AST].[Asset](AssetId)