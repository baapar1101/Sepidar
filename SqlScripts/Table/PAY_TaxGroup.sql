--<<FileName:PAY_TaxGroup.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.TaxGroup') Is Null
CREATE TABLE [PAY].[TaxGroup](
	[TaxGroupId] [int] NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.TaxGroup') and
				[name] = 'ColumnName')
begin
    Alter table PAY.TaxGroup Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_TaxGroup')
ALTER TABLE [PAY].[TaxGroup] ADD  CONSTRAINT [PK_TaxGroup] PRIMARY KEY CLUSTERED 
(
	[TaxGroupId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_TaxGroup_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TaxGroup_Title] ON [PAY].[TaxGroup] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If Exists (select 1 from sys.indexes where name = 'UIX_TaxGroup_Title_En')
Drop index [PAY].[TaxGroup].[UIX_TaxGroup_Title_En]

go
If not Exists (select 1 from sys.indexes where name = 'UIX_TaxGroup_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TaxGroup_Title_En] ON [PAY].[TaxGroup] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
