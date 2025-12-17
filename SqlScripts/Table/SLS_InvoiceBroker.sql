--<<FileName:SLS_InvoiceBroker.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.InvoiceBroker') Is Null
CREATE TABLE [SLS].[InvoiceBroker](
	[BrokerID] [int] NOT NULL,
	[InvoiceRef] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[Commission] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16)  NOT NULL,
	[CommissionInBaseCurrency] [decimal](19, 4) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceBroker') and
				[name] = 'ColumnName')
begin
    Alter table SLS.InvoiceBroker Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceBroker') and
				[name] = 'Rate')
begin
    Alter table SLS.InvoiceBroker Add Rate [decimal](18, 4) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceBroker') and
				[name] = 'CommissionInBaseCurrency')
begin
    Alter table SLS.InvoiceBroker Add [CommissionInBaseCurrency]  AS ([Commission]*[Rate]) PERSISTED 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceBroker') and
				[name] = 'PartyRef')
begin
    Alter table SLS.InvoiceBroker Add [PartyRef] INT
end
GO
--<< ALTER COLUMNS >>--
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceBroker') AND
				[name] = 'CommissionInBaseCurrency' AND is_Computed = 1)
BEGIN
	ALTER TABLE SLS.InvoiceBroker DROP COLUMN CommissionInBaseCurrency
	ALTER TABLE SLS.InvoiceBroker ADD CommissionInBaseCurrency DECIMAL(19,4)
END
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Broker')
ALTER TABLE [SLS].[InvoiceBroker] ADD  CONSTRAINT [PK_Broker] PRIMARY KEY CLUSTERED 
(
	[BrokerID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Broker_InvoiceRef')
ALTER TABLE [SLS].[InvoiceBroker]  ADD  CONSTRAINT [FK_Broker_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_Broker_PartyRef')
ALTER TABLE [SLS].[InvoiceBroker]  ADD  CONSTRAINT [FK_Broker_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
