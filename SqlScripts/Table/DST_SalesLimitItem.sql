--<<FileName:DST_SalesLimitItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.SalesLimitItem') Is Null
CREATE TABLE [DST].[SalesLimitItem]
(
	[SalesLimitItemId] [int] NOT NULL,
	[SalesLimitRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,

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

If not Exists (select 1 from sys.objects where name = 'PK_DST_SalesLimitItem')
ALTER TABLE [DST].[SalesLimitItem] ADD  CONSTRAINT [PK_DST_SalesLimitItem] PRIMARY KEY CLUSTERED 
(
	[SalesLimitItemId] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_SalesLimitItem_ItemRef_TracingRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SalesLimitItem_ItemRef_TracingRef] ON [DST].[SalesLimitItem] 
(	[SalesLimitRef] ,
	[ItemRef] ,
	[TracingRef]
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_SalesLimitItem_SalesLimitRef')
ALTER TABLE [DST].[SalesLimitItem]  ADD  CONSTRAINT [FK_SalesLimitItem_SalesLimitRef] FOREIGN KEY([SalesLimitRef])
REFERENCES [DST].[SalesLimit]  ([SalesLimitID]) ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_SalesLimitItem_Item')
ALTER TABLE [DST].[SalesLimitItem]  ADD  CONSTRAINT [FK_SalesLimitItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_SalesLimitItem_Tracing')
ALTER TABLE [DST].[SalesLimitItem]  ADD  CONSTRAINT [FK_SalesLimitItem_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])
GO
--<< DROP OBJECTS >>--
