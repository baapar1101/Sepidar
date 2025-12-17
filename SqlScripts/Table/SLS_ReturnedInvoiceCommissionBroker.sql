--<<FileName:SLS_ReturnedInvoiceCommissionBroker.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ReturnedInvoiceCommissionBroker') Is Null
CREATE TABLE [SLS].[ReturnedInvoiceCommissionBroker](
	[ReturnedInvoiceCommissionBrokerID] [int]			 NOT NULL,
	[ReturnedInvoiceRef]				[int]			 NOT NULL,
	[PartyRef]							[int]			 NOT NULL,
	[SalePortionPercent]				[decimal](19, 4) NOT NULL,
	[ManualCommissionAmount] 			[decimal](19, 4)	 NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceCommissionBroker') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ReturnedInvoiceCommissionBroker Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoiceCommissionBroker') AND
				[NAME] = 'ManualCommissionAmount')
BEGIN
    ALTER TABLE SLS.ReturnedInvoiceCommissionBroker ADD [ManualCommissionAmount] [decimal](19, 4)	 NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReturnedInvoiceCommissionBroker')
ALTER TABLE [SLS].[ReturnedInvoiceCommissionBroker] ADD  CONSTRAINT [PK_ReturnedInvoiceCommissionBroker] PRIMARY KEY CLUSTERED 
(
	[ReturnedInvoiceCommissionBrokerID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceCommissionBroker_ReturnedInvoiceRef')
ALTER TABLE [SLS].[ReturnedInvoiceCommissionBroker]  ADD  CONSTRAINT [FK_ReturnedInvoiceCommissionBroker_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceCommissionBroker_PartyRef')
ALTER TABLE [SLS].[ReturnedInvoiceCommissionBroker]  ADD  CONSTRAINT [FK_ReturnedInvoiceCommissionBroker_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
