--<<FileName:DST_SaleTypeConstraint.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.SaleTypeConstraint') Is Null
CREATE TABLE [DST].[SaleTypeConstraint]
(
	[SaleTypeConstraintID] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
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

If not Exists (select 1 from sys.objects where name = 'PK_DST_SaleTypeConstraint')
ALTER TABLE [DST].[SaleTypeConstraint] ADD  CONSTRAINT [PK_DST_SaleTypeConstraint] PRIMARY KEY CLUSTERED 
(
	[SaleTypeConstraintID] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_DST_SaleTypeConstraint_PartyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DST_SaleTypeConstraint_PartyRef] ON [DST].[SaleTypeConstraint]
(
	[PartyRef] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_SaleTypeConstraint_PartyRef')
ALTER TABLE [DST].[SaleTypeConstraint]  ADD  CONSTRAINT [FK_SaleTypeConstraint_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party]  ([PartyID])

GO

--<< DROP OBJECTS >>--


