--<<FileName:SLS_QuotationCommissionBroker.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.QuotationCommissionBroker') Is Null
CREATE TABLE [SLS].[QuotationCommissionBroker](
	[QuotationCommissionBrokerID] [int] NOT NULL,
	[QuotationRef] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[SalePortionPercent] [decimal](5, 2) NOT NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationCommissionBroker') and
				[name] = 'ColumnName')
begin
    Alter table SLS.QuotationCommissionBroker Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_QuotationCommissionBroker')
ALTER TABLE [SLS].[QuotationCommissionBroker] ADD  CONSTRAINT [PK_QuotationCommissionBroker] PRIMARY KEY CLUSTERED 
(
	[QuotationCommissionBrokerID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_QuotationCommissionBroker_QuotationRef')
ALTER TABLE [SLS].[QuotationCommissionBroker]  ADD  CONSTRAINT [FK_QuotationCommissionBroker_QuotationRef] FOREIGN KEY([QuotationRef])
REFERENCES [SLS].[Quotation] ([QuotationId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_QuotationCommissionBroker_PartyRef')
ALTER TABLE [SLS].[QuotationCommissionBroker]  ADD  CONSTRAINT [FK_QuotationCommissionBroker_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
