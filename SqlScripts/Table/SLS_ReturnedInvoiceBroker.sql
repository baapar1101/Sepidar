--<<FileName:SLS_ReturnedInvoiceBroker.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ReturnedInvoiceBroker') Is Null
CREATE TABLE [SLS].[ReturnedInvoiceBroker](
	[ReturnedInvoiceBrokerID] [int] NOT NULL,
	[ReturnedInvoiceRef] [int] NOT NULL,
	[ParteyRef] [int] NOT NULL,
	[Commission] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[CommissionInBaseCurrency] [decimal](19, 4) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceBroker') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ReturnedInvoiceBroker Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceBroker') and
				[name] = 'PartyRef')
begin
    Alter table SLS.ReturnedInvoiceBroker Add [PartyRef] INT
end
GO
--<< ALTER COLUMNS >>--
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoiceBroker') AND
				[name] = 'CommissionInBaseCurrency' AND is_Computed = 1)
BEGIN
	ALTER TABLE SLS.ReturnedInvoiceBroker DROP COLUMN CommissionInBaseCurrency
	ALTER TABLE SLS.ReturnedInvoiceBroker ADD CommissionInBaseCurrency DECIMAL(19,4)
END
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReturnedInvoiceBroker')
ALTER TABLE [SLS].[ReturnedInvoiceBroker] ADD  CONSTRAINT [PK_ReturnedInvoiceBroker] PRIMARY KEY CLUSTERED 
(
	[ReturnedInvoiceBrokerID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceBroker_PartyRef')
ALTER TABLE [SLS].[ReturnedInvoiceBroker]  ADD  CONSTRAINT [FK_ReturnedInvoiceBroker_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceBroker_ReturnedInvoiceRef')
ALTER TABLE [SLS].[ReturnedInvoiceBroker]  ADD  CONSTRAINT [FK_ReturnedInvoiceBroker_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
