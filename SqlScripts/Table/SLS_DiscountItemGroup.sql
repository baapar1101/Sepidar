--<< TABLE DEFINITION >>--

If Object_ID('SLS.DiscountItemGroup') Is Null
CREATE TABLE [SLS].[DiscountItemGroup](
	[DiscountItemGroupID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Title_En] [nvarchar](50) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DiscountItemGroup')
ALTER TABLE [SLS].[DiscountItemGroup] ADD  CONSTRAINT [PK_DiscountItemGroup] PRIMARY KEY CLUSTERED 
(
	[DiscountItemGroupID] ASC
) ON [PRIMARY]
GO


--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_DiscountItemGroup_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_DiscountItemGroup_Title] ON [SLS].[DiscountItemGroup] 
(
	[Title] 
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_DiscountItemGroup_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_DiscountItemGroup_Title_En] ON [SLS].[DiscountItemGroup] 
(
	[Title_En] 
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--

GO
--<< DROP OBJECTS >>--
