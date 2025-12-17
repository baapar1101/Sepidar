--<<FileName:RPA_PosSettlementReceipt.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PosSettlementReceipt') Is Null
CREATE TABLE [RPA].[PosSettlementReceipt](
	[PosSettlementReceiptID] [int] NOT NULL,
	[PosSettlementRef] [int] NOT NULL,
	[ReceiptPosRef] [int] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.PosSettlementReceipt') and
				[name] = 'ColumnName')
begin
    Alter table RPA.PosSettlementReceipt Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PosSettlementReceipt')
ALTER TABLE [RPA].[PosSettlementReceipt] ADD  CONSTRAINT [PK_PosSettlementReceipt] PRIMARY KEY CLUSTERED 
(
	[PosSettlementReceiptID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PosSettlementReceipt_ReceiptPosRef')
CREATE NONCLUSTERED INDEX [IX_PosSettlementReceipt_ReceiptPosRef]
ON [RPA].[PosSettlementReceipt] ([ReceiptPosRef])
GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PosSettlementReceipt_PosSettlement')
ALTER TABLE [RPA].[PosSettlementReceipt]  ADD  CONSTRAINT [FK_PosSettlementReceipt_PosSettlement] FOREIGN KEY([PosSettlementRef])
REFERENCES [RPA].[PosSettlement] ([PosSettlementID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_PosSettlementReceipt_ReceiptPos')
ALTER TABLE [RPA].[PosSettlementReceipt]  ADD  CONSTRAINT [FK_PosSettlementReceipt_ReceiptPos] FOREIGN KEY([ReceiptPosRef])
REFERENCES [RPA].[ReceiptPos] ([ReceiptPosId])

GO

--<< DROP OBJECTS >>--
