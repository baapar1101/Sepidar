--<<FileName:ACC_DL.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.DL') Is Null
CREATE TABLE [ACC].[DL](
	[DLId] [int] NOT NULL,
	[Code] [varchar](40) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[Type] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('ACC.DL') and
				[name] = 'IsActive')
    Alter table ACC.DL Add [IsActive] [bit] NULL
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('ACC.DL') AND [name] = 'IsActive' AND is_Nullable = 1)
BEGIN
	--fill IsActive
	UPDATE ACC.DL
	SET IsActive = 1
	WHERE IsActive IS NULL
	
	ALTER TABLE ACC.DL ALTER COLUMN [IsActive] [bit] NOT NULL
END
Go

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DL')
ALTER TABLE [ACC].[DL] ADD  CONSTRAINT [PK_DL] PRIMARY KEY CLUSTERED 
(
	[DLId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_DL_Code')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DL_Code] ON [ACC].[DL] 
(
	[Code] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_DL_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DL_Title] ON [ACC].[DL] 
(
	[Title] ASC
) ON [PRIMARY]

GO

--temporary: drop corrupt index
If Exists (select 1 from sys.indexes where name = 'UIX_DL_TitleEn')
DROP INDEX ACC.DL.UIX_DL_TitleEn
--temporary

If not Exists (select 1 from sys.indexes where name = 'UIX_DL_TitleEn')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DL_TitleEn] ON [ACC].[DL] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
