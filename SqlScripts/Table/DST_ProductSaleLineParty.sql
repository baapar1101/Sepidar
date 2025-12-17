--<<FileName:DST_ProductSaleLineParty.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.ProductSaleLineParty') Is Null
CREATE TABLE [DST].[ProductSaleLineParty]
(
	[ProductSaleLinePartyId] [int] NOT NULL,
	[ProductSaleLineRef] INT NOT NULL,
	[PartyRef] INT NOT NULL,
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

If not Exists (select 1 from sys.objects where name = 'PK_DST_ProductSaleLineParty')
ALTER TABLE [DST].[ProductSaleLineParty] ADD  CONSTRAINT [PK_DST_ProductSaleLineParty] PRIMARY KEY CLUSTERED 
(
	[ProductSaleLinePartyId] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_ProductSaleLineParty_ProductSaleLineRef_PartyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ProductSaleLineParty_ProductSaleLineRef_PartyRef] ON [DST].[ProductSaleLineParty]
(
	[ProductSaleLineRef], [PartyRef]
)

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ProductSaleLineParty_ProductSaleLine')
ALTER TABLE [DST].[ProductSaleLineParty]  ADD  CONSTRAINT [FK_ProductSaleLineParty_ProductSaleLine] FOREIGN KEY([ProductSaleLineRef])
REFERENCES [DST].[ProductSaleLine] ([ProductSaleLineId])
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_ProductSaleLineParty_Party')
ALTER TABLE [DST].[ProductSaleLineParty]  ADD  CONSTRAINT [FK_ProductSaleLineParty_Party] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyID])

GO

GO

--<< DROP OBJECTS >>--
