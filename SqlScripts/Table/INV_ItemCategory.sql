--<<FileName:INV_ItemCategory.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.ItemCategory') Is Null
CREATE TABLE [INV].[ItemCategory](
	[ItemCategoryID] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Title] [nvarchar](4000) NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.ItemCategory') and
				[name] = 'ColumnName')
begin
    Alter table INV.ItemCategory Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ItemCategory')
ALTER TABLE [INV].[ItemCategory] ADD  CONSTRAINT [PK_ItemCategory] PRIMARY KEY CLUSTERED 
(
	[ItemCategoryID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
