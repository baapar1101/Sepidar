--<<FileName:PAY_Worksite.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Worksite') Is Null
CREATE TABLE [PAY].[Worksite](
	[WorksiteId] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[Code] [int] NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.Worksite') and
				[name] = 'ColumnName')
begin
    Alter table PAY.Worksite Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Worksite')
ALTER TABLE [PAY].[Worksite] ADD  CONSTRAINT [PK_Worksite] PRIMARY KEY CLUSTERED 
(
	[WorksiteId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Worksite_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Worksite_Title] ON [PAY].[Worksite] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Worksite_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Worksite_Title_En] ON [PAY].[Worksite] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
