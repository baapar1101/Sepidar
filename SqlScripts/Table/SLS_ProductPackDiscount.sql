--<<FileName:SLS_ProductPackDiscount.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ProductPackDiscount') Is Null
CREATE TABLE [SLS].[ProductPackDiscount](
	[ProductPackDiscountID] [int] NOT NULL,
	[DiscountRef] [int] NOT NULL,	
	[ProductPackRef] [INT] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ProductPackDiscount') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ProductPackDiscount Add ColumnName DataType Nullable
end
GO*/
--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ProductPackDiscount')
ALTER TABLE [SLS].[ProductPackDiscount] ADD  CONSTRAINT [PK_ProductPackDiscount] PRIMARY KEY CLUSTERED 
(
	[ProductPackDiscountID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ProductPackDiscount_Discount')
ALTER TABLE [SLS].[ProductPackDiscount]  ADD  CONSTRAINT [FK_ProductPackDiscount_Discount] FOREIGN KEY([DiscountRef])
REFERENCES [SLS].[Discount] ([DiscountId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ProductPackDiscount_ProductPack')
ALTER TABLE [SLS].[ProductPackDiscount]  ADD  CONSTRAINT [FK_ProductPackDiscount_ProductPack] FOREIGN KEY([ProductPackRef])
REFERENCES [SLS].[ProductPack] ([ProductPackId])

GO
--<< DROP OBJECTS >>--
