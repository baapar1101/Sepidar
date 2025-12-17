--<<FileName:CNT_Project.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.Project') Is Null
CREATE TABLE [CNT].[Project](
	[ProjectID] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Title_En] [nvarchar](250) NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Project') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Project Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Project')
ALTER TABLE [CNT].[Project] ADD  CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
