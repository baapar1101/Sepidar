--<<FileName:SLS_CustomsDeclarationItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.CustomsDeclarationItem') Is Null
CREATE TABLE [SLS].[CustomsDeclarationItem]
(
    [CustomsDeclarationItemId] [int]            NOT NULL,
    [CustomsDeclarationRef]    [int]            NOT NULL,
    [RowNumber]                [int]            NULL,
    [InvoiceItemRef]           [int]            NULL,
    [Quantity]                 [decimal](19, 4) NOT NULL,
    [Price]                    [decimal](19, 4) NOT NULL,
    [PriceInBaseCurrency]      [decimal](19, 4) NOT NULL,
    [NetWeight]                [decimal](19, 4) NULL,
    [OtherTaxes]               [decimal](19, 4) NULL,
    [OtherAmounts]             [decimal](19, 4) NULL,
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS where OBJECT_ID=OBJECT_ID('SLS.CustomsDeclarationItem') and
				[name] = 'RowNumber')
BEGIN
    ALTER TABLE SLS.CustomsDeclarationItem ADD [RowNumber] [int]  NULL
END
GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CustomsDeclarationItem')
ALTER TABLE [SLS].[CustomsDeclarationItem] ADD  CONSTRAINT [PK_CustomsDeclarationItem] PRIMARY KEY CLUSTERED
(
	[CustomsDeclarationItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CustomsDeclarationItem_CustomsDeclarationRef')
ALTER TABLE [SLS].[CustomsDeclarationItem]  ADD  CONSTRAINT [FK_CustomsDeclarationItem_CustomsDeclarationRef] FOREIGN KEY([CustomsDeclarationRef])
REFERENCES [SLS].[CustomsDeclaration] ([CustomsDeclarationId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_CustomsDeclarationItem_InvoiceItemRef')
ALTER TABLE [SLS].[CustomsDeclarationItem]  ADD  CONSTRAINT [FK_CustomsDeclarationItem_InvoiceItemRef] FOREIGN KEY([InvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemId])
GO

--<< DROP OBJECTS >>--
--<< DROP OBJECTS >>--
