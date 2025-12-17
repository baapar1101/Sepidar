--<<FileName:FMK_NumberedEntity.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.NumberedEntity') Is Null
CREATE TABLE [FMK].[NumberedEntity](
	[NumberedEntityID] [int] NOT NULL,
	[EntityFullName] [varchar](800) NOT NULL,
	[Method] [int] NOT NULL,
	[StartValue] [BigInt] NOT NULL,
	[FinishValue] [BigInt] NULL,
	[ApplyProperty1] [bit] NOT NULL,
	[ApplyProperty2] [bit] NOT NULL,
	[ApplyProperty3] [bit] NOT NULL,
	[ApplyPorperty4] [bit] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.NumberedEntity') and
				[name] = 'ColumnName')
begin
    Alter table FMK.NumberedEntity Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS ISC
	WHERE ISC.COLUMN_NAME = 'StartValue'
		AND ISC.DATA_TYPE = 'int' AND ISC.TABLE_SCHEMA = 'FMK'
		AND TABLE_NAME = 'NumberedEntity' )
BEGIN
	ALTER TABLE FMK.NumberedEntity ALTER COLUMN StartValue BigInt NOT NULL
END

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS ISC 
	WHERE ISC.COLUMN_NAME = 'FinishValue'
		AND ISC.DATA_TYPE = 'int' AND ISC.TABLE_SCHEMA = 'FMK'
		AND TABLE_NAME = 'NumberedEntity' )
BEGIN
	ALTER TABLE FMK.NumberedEntity ALTER COLUMN FinishValue BigInt NULL
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_NumberedEntity')
ALTER TABLE [FMK].[NumberedEntity] ADD  CONSTRAINT [PK_NumberedEntity] PRIMARY KEY CLUSTERED 
(
	[NumberedEntityID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_NumberedEntity_EntityFullName')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_NumberedEntity_EntityFullName] ON [FMK].[NumberedEntity] 
(
	[EntityFullName] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
