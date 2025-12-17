--<<FileName:DST_SaleTypeConstraintItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.SaleTypeConstraintItem') Is Null
CREATE TABLE [DST].[SaleTypeConstraintItem]
(
	[SaleTypeConstraintItemID] [int] NOT NULL,
	[SaleTypeConstraintRef] [int] NOT NULL,
	[SaleTypeRef] [int] NOT NULL,
	[Version] [int] NOT NULL,
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

If not Exists (select 1 from sys.objects where name = 'PK_DST_SaleTypeConstraintItem')
ALTER TABLE [DST].[SaleTypeConstraintItem] ADD  CONSTRAINT [PK_DST_SaleTypeConstraintItem] PRIMARY KEY CLUSTERED 
(
	[SaleTypeConstraintItemID] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_DST_SaleTypeConstraintItem_SaleTypeConstraintRef')
CREATE NONCLUSTERED INDEX [UIX_DST_SaleTypeConstraintItem_SaleTypeConstraintRef] ON [DST].[SaleTypeConstraintItem]
(
	[SaleTypeConstraintRef] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_SaleTypeConstraintItem_SaleTypeConstraintRef')
ALTER TABLE [DST].[SaleTypeConstraintItem] ADD CONSTRAINT [FK_SaleTypeConstraintItem_SaleTypeConstraintRef] FOREIGN KEY([SaleTypeConstraintRef])
REFERENCES [DST].[SaleTypeConstraint] ([SaleTypeConstraintID])
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_SaleTypeConstraintItem_SaleTypeRef')
ALTER TABLE [DST].[SaleTypeConstraintItem] ADD CONSTRAINT [FK_SaleTypeConstraintItem_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeID])

GO

--<< DROP OBJECTS >>--


