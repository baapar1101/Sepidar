--<<FileName:DST_SalesLimitItemParty.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.SalesLimitItemParty') Is Null
CREATE TABLE [DST].[SalesLimitItemParty]
(
	[SalesLimitItemPartyId] [int] NOT NULL,
	[SalesLimitItemRef] [int] NOT NULL,	
	[PartyRef] [int] NOT NULL,
	[Quantity] [decimal](19, 4)  NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
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

If not Exists (select 1 from sys.objects where name = 'PK_DST_SalesLimitItemParty')
ALTER TABLE [DST].[SalesLimitItemParty] ADD  CONSTRAINT [PK_DST_SalesLimitItemParty] PRIMARY KEY CLUSTERED 
(
	[SalesLimitItemPartyId] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_SalesLimitItemParty_PartyRef_SalesLimitItemRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SalesLimitItemParty_PartyRef_SalesLimitItemRef] ON [DST].[SalesLimitItemParty] 
(	[SalesLimitItemRef] ,	
	[PartyRef]
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_SalesLimitItemParty_SalesLimitItemRef')
ALTER TABLE [DST].[SalesLimitItemParty]  ADD  CONSTRAINT [FK_SalesLimitItemParty_SalesLimitItemRef] FOREIGN KEY([SalesLimitItemRef])
REFERENCES [DST].[SalesLimitItem]  ([SalesLimitItemID])
ON DELETE CASCADE
GO
If not Exists (select 1 from sys.objects where name = 'FK_SalesLimitItemParty_Party')
ALTER TABLE [DST].[SalesLimitItemParty]  ADD  CONSTRAINT [FK_SalesLimitItemParty_Party] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyID])


GO
--<< DROP OBJECTS >>--
