--<<FileName:SLS_CommissionCalculationItem.sql>>--
--<< TABLE DEFINITION >>--
if OBJECT_ID('SLS.CommissionCalculationItem') IS NULL
	Create Table SLS.CommissionCalculationItem(
        CommissionCalculationItemID int not null,
        CommissionCalculationRef int not null,
        ItemRef int null,
        InvoiceRef int null,        
        ReturnedInvoiceRef int null,
        IsExtraReturnedInvoice bit not null,
        Amount decimal(19, 4) NOT NULL,
	) ON [PRIMARY]
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.CommissionCalculationItem') AND
	[name] = 'IsExtraReturnedInvoice' )
BEGIN
	ALTER TABLE SLS.CommissionCalculationItem ADD [IsExtraReturnedInvoice] bit NOT NULL DEFAULT(0)
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF OBJECT_ID('SLS.PK_CommissionCalculationItemID') IS NULL
	ALTER TABLE SLS.CommissionCalculationItem ADD CONSTRAINT [PK_CommissionCalculationItemID] PRIMARY KEY CLUSTERED
	(
		CommissionCalculationItemID ASC
	) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF OBJECT_ID('SLS.FK_CommissionCalculationItem_CommissionCalculationRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationItem ADD CONSTRAINT [FK_CommissionCalculationItem_CommissionCalculationRef] 
		FOREIGN KEY ([CommissionCalculationRef]) REFERENCES [SLS].[CommissionCalculation] ([CommissionCalculationID])ON DELETE CASCADE
GO
IF OBJECT_ID('SLS.FK_CommissionCalculationItem_ItemRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationItem ADD CONSTRAINT [FK_CommissionCalculationItem_ItemRef]
		FOREIGN KEY ([ItemRef]) REFERENCES [INV].[Item]  ([ItemID])
GO
IF OBJECT_ID('SLS.FK_CommissionCalculationItem_InvoiceRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationItem ADD CONSTRAINT [FK_CommissionCalculationItem_InvoiceRef]
		FOREIGN KEY ([InvoiceRef]) REFERENCES [SLS].[Invoice]  ([InvoiceID])
GO
IF OBJECT_ID('SLS.FK_CommissionCalculationItem_ReturnedInvoiceRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationItem ADD CONSTRAINT [FK_CommissionCalculationItem_ReturnedInvoiceRef]
		FOREIGN KEY ([ReturnedInvoiceRef]) REFERENCES [SLS].[ReturnedInvoice]  ([ReturnedInvoiceID])
GO
--<< DROP OBJECTS >>--
