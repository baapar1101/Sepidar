--<<FileName:DST_ProductSaleLine.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.ProductSaleLine') Is Null
CREATE TABLE [DST].[ProductSaleLine]
(
	[ProductSaleLineId] [int] NOT NULL,
	[Code] NVARCHAR(250) NOT NULL,
	[Title] NVARCHAR(250) NOT NULL,
	[Title_En] NVARCHAR(250) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[ProductsState] [int] NULL,
	[ServicesState] [int] NULL
) 
ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Quotation Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.ProductSaleLine') AND
				[Name]='ProductsState')
	ALTER TABLE DST.ProductSaleLine ADD [ProductsState] [int] NULL

GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.ProductSaleLine') AND
				[Name]='ServicesState')
	ALTER TABLE DST.ProductSaleLine ADD [ServicesState] [int] NULL

GO

/* Sample
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN PriceInBaseCurrency
	END
END
*/

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DST_ProductSaleLine')
ALTER TABLE [DST].[ProductSaleLine] ADD  CONSTRAINT [PK_DST_ProductSaleLine] PRIMARY KEY CLUSTERED 
(
	[ProductSaleLineId] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

GO

--<< DROP OBJECTS >>--
