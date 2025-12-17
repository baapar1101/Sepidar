--<<FileName:DST_ReturnReason.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.ReturnReason') IS NULL
CREATE TABLE [DST].[ReturnReason](
	[ReturnReasonID]	        [INT]			NOT NULL,
	[Title]						[NVARCHAR](250)	NOT NULL,
	[Title_En]					[NVARCHAR](250) NOT NULL,
	[IsActive]					[BIT]			NOT NULL,
	[Version]					[INT]			NOT NULL,
	[Creator]					[INT]			NOT NULL,
	[CreationDate]				[DATETIME]		NOT NULL,
	[LastModifier]				[INT]			NOT NULL,
	[LastModificationDate]		[DATETIME]		NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnReason') and
				[name] = 'ColumnName')
begin
    Alter table DST.ReturnReason Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ReturnReason')
ALTER TABLE [DST].[ReturnReason] ADD CONSTRAINT [PK_ReturnReason] PRIMARY KEY CLUSTERED 
(
	[ReturnReasonID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ReturnReason_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ReturnReason_Title] ON [DST].[ReturnReason] 
(
	[Title] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ReturnReason_TitleEn')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ReturnReason_TitleEn] ON [DST].[ReturnReason] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
