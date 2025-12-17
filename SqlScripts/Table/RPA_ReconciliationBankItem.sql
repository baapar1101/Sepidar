--<<FileName:RPA_ReconciliationBankItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReconciliationBankItem') Is Null
CREATE TABLE [RPA].[ReconciliationBankItem](
	[ReconciliationBankItemId] [int] NOT NULL,
	[BankBillItemRef] [int] NULL,
	[RelationNo] [int] NULL,
	[Number] [nvarchar](255) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Debit] [decimal](19, 4) NOT NULL,
	[Credit] [decimal](19, 4) NOT NULL,
	[ReconciliationRef] [int] NOT NULL,
	[ReconciliationBankItemRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReconciliationBankItem') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReconciliationBankItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReconciliationBankItem')
ALTER TABLE [RPA].[ReconciliationBankItem] ADD  CONSTRAINT [PK_ReconciliationBankItem] PRIMARY KEY CLUSTERED 
(
	[ReconciliationBankItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--

If  Exists (select 1 from sys.objects where name = 'FK_ReconciliationBankItem_BankBillItemRef')
ALTER TABLE [RPA].[ReconciliationBankItem]  DROP FK_ReconciliationBankItem_BankBillItemRef
Go

If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationBankItem_BankBillItem')
ALTER TABLE [RPA].[ReconciliationBankItem]  ADD  CONSTRAINT [FK_ReconciliationBankItem_BankBillItem] FOREIGN KEY([BankBillItemRef])
REFERENCES [RPA].[BankBillItem] ([BankBillItemId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationBankItem_ReconciliationRef')
ALTER TABLE [RPA].[ReconciliationBankItem]  ADD  CONSTRAINT [FK_ReconciliationBankItem_ReconciliationRef] FOREIGN KEY([ReconciliationRef])
REFERENCES [RPA].[Reconciliation] ([ReconciliationId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationBankItem_ReconciliationBankItemRef')
ALTER TABLE [RPA].[ReconciliationBankItem]  ADD  CONSTRAINT [FK_ReconciliationBankItem_ReconciliationBankItemRef] FOREIGN KEY([ReconciliationBankItemRef])
REFERENCES [RPA].[ReconciliationBankItem] ([ReconciliationBankItemId])

GO



