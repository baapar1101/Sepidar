
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.InvoiceBroker') AND
				[name] = 'ParteyRef')
BEGIN
	exec sp_ExecuteSql N'UPDATE SLS.InvoiceBroker SET PartyRef = ParteyRef'
	ALTER TABLE SLS.InvoiceBroker ALTER COLUMN PartyRef INT NOT NULL

	If Exists (select 1 from sys.objects where name = 'FK_Broker_PartyRef')
		exec sp_ExecuteSql N'ALTER TABLE SLS.InvoiceBroker DROP CONSTRAINT FK_Broker_PartyRef'
	exec sp_ExecuteSql N'Alter Table SLS.InvoiceBroker Drop Column ParteyRef'
	
	If not Exists (select 1 from sys.objects where name = 'FK_Broker_PartyRef')
	ALTER TABLE [SLS].[InvoiceBroker]  ADD  CONSTRAINT [FK_Broker_PartyRef] FOREIGN KEY([PartyRef])
	REFERENCES [GNR].[Party] ([PartyId])
END
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoiceBroker') AND
				[name] = 'ParteyRef')
BEGIN
	exec sp_ExecuteSql N'UPDATE SLS.ReturnedInvoiceBroker SET PartyRef= ParteyRef'
	ALTER TABLE SLS.ReturnedInvoiceBroker ALTER COLUMN PartyRef INT NOT NULL

	If Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceBroker_PartyRef')
		exec sp_ExecuteSql N'ALTER TABLE SLS.ReturnedInvoiceBroker DROP CONSTRAINT FK_ReturnedInvoiceBroker_PartyRef'
	exec sp_ExecuteSql N'Alter Table SLS.ReturnedInvoiceBroker Drop Column ParteyRef'
	
	If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceBroker_PartyRef')
		ALTER TABLE [SLS].[ReturnedInvoiceBroker]  ADD  CONSTRAINT [FK_ReturnedInvoiceBroker_PartyRef] FOREIGN KEY([PartyRef])
		REFERENCES [GNR].[Party] ([PartyId])
END