--<<FileName:AST_Emplacement.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('AST.Emplacement') IS NULL
CREATE TABLE [AST].Emplacement(
	[EmplacementId] [int] NOT NULL,
	[Code] [nvarchar](250) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Title_EN] [nvarchar](250) NULL,
	[ParentRef] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_EN] [nvarchar](4000) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF object_Id('AST.PK_Emplacement') is null
  ALTER TABLE [AST].[Emplacement] ADD  CONSTRAINT 
    [PK_Emplacement] PRIMARY KEY CLUSTERED ([EmplacementId] ASC) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF object_Id('AST.FK_Emplacement_ParentRef') is null
	ALTER TABLE [AST].[Emplacement] ADD  CONSTRAINT 
	[FK_Emplacement_ParentRef] FOREIGN KEY  ([ParentRef]) REFERENCES [AST].[Emplacement]([EmplacementId])
GO
--<< DROP OBJECTS >>--

 