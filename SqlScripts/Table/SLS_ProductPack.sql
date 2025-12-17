--<<FileName:SLS_ProductPack.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ProductPack') Is Null
CREATE TABLE [SLS].[ProductPack](
	[ProductPackID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Title_En] [nvarchar](50) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ProductPack') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ProductPack Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ProductPack')
ALTER TABLE [SLS].[ProductPack] ADD  CONSTRAINT [PK_ProductPack] PRIMARY KEY CLUSTERED 
(
	[ProductPackID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_ProductPack_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_ProductPack_Title] ON [SLS].[ProductPack] 
(
	[Title] ASC
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_ProductPack_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_ProductPack_Title_En] ON [SLS].[ProductPack] 
(
	[Title_En] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
