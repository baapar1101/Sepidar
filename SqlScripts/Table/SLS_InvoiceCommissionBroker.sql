--<<FileName:SLS_InvoiceCommissionBroker.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.InvoiceCommissionBroker') Is Null
CREATE TABLE [SLS].[InvoiceCommissionBroker](
	[InvoiceCommissionBrokerID] [int]			 NOT NULL,
	[InvoiceRef]				[int]			 NOT NULL,
	[PartyRef]					[int]			 NOT NULL,
	[SalePortionPercent]		[decimal](19, 4) NOT NULL,
	[ManualCommissionAmount]	[decimal](19, 4)	 NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceCommissionBroker') and
				[name] = 'ColumnName')
begin
    Alter table SLS.InvoiceCommissionBroker Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceCommissionBroker') AND
				[NAME] = 'ManualCommissionAmount')
BEGIN
    ALTER TABLE SLS.InvoiceCommissionBroker ADD [ManualCommissionAmount] [decimal](19, 4)	 NULL
END
GO


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InvoiceCommissionBroker')
ALTER TABLE [SLS].[InvoiceCommissionBroker] ADD  CONSTRAINT [PK_InvoiceCommissionBroker] PRIMARY KEY CLUSTERED 
(
	[InvoiceCommissionBrokerID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceCommissionBroker_InvoiceRef')
ALTER TABLE [SLS].[InvoiceCommissionBroker]  ADD  CONSTRAINT [FK_InvoiceCommissionBroker_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_InvoiceCommissionBroker_PartyRef')
ALTER TABLE [SLS].[InvoiceCommissionBroker]  ADD  CONSTRAINT [FK_InvoiceCommissionBroker_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
