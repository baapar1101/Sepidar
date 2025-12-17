--<<FileName:SLS_CommissionCalculationInvoice.sql>>--
--<< TABLE DEFINITION >>--
if OBJECT_ID('SLS.CommissionCalculationInvoice') IS NULL
	Create Table SLS.CommissionCalculationInvoice(
        CommissionCalculationInvoiceID int not null,
        CommissionCalculationRef int not null,
        InvoiceItemRef int null,        
        ReturnedInvoiceItemRef int null
	) ON [PRIMARY]
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF OBJECT_ID('SLS.PK_CommissionCalculationInvoiceID') IS NULL
	ALTER TABLE SLS.CommissionCalculationInvoice ADD CONSTRAINT [PK_CommissionCalculationInvoiceID] PRIMARY KEY CLUSTERED
	(
		CommissionCalculationInvoiceID ASC
	) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF OBJECT_ID('SLS.FK_CommissionCalculationInvoice_CommissionCalculationRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationInvoice ADD CONSTRAINT [FK_CommissionCalculationInvoice_CommissionCalculationRef] 
		FOREIGN KEY ([CommissionCalculationRef]) REFERENCES [SLS].[CommissionCalculation] ([CommissionCalculationID])ON DELETE CASCADE
GO
IF OBJECT_ID('SLS.FK_CommissionCalculationInvoice_InvoiceItemRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationInvoice ADD CONSTRAINT [FK_CommissionCalculationInvoice_InvoiceItemRef]
		FOREIGN KEY ([InvoiceItemRef]) REFERENCES [SLS].[InvoiceItem]  ([InvoiceItemID])
GO
IF OBJECT_ID('SLS.FK_CommissionCalculationInvoice_ReturnedInvoiceItemRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationInvoice ADD CONSTRAINT [FK_CommissionCalculationInvoice_ReturnedInvoiceItemRef]
		FOREIGN KEY ([ReturnedInvoiceItemRef]) REFERENCES [SLS].[ReturnedInvoiceItem]  ([ReturnedInvoiceItemID])
GO
--<< DROP OBJECTS >>--
