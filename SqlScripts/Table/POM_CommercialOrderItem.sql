--<<FileName:INV_CommercialOrderItem.sql>>--  drop TABLE [POM].[CommercialOrderItem] 
--<< TABLE DEFINITION >>--
If Object_ID('POM.CommercialOrderItem') Is Null
CREATE  TABLE [POM].[CommercialOrderItem](
	[CommercialOrderItemID] [int] NOT NULL,	
	[CommercialOrderRef] [int] NOT NULL,	
	[PurchaseOrderItemRef] [int] NOT NULL,	
	[RegisterFee] [decimal](19, 4) NULL,
	[RowNumber] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrderItem') and
				[name] = 'ColumnName')
begin
    Alter table POM.CommercialOrderItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrderItem') and
				[name] = 'RowNumber')
begin
    Alter table POM.CommercialOrderItem Add RowNumber  [int]  NULL
end
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_CommercialOrderItem')
BEGIN
ALTER TABLE [POM].[CommercialOrderItem] ADD CONSTRAINT [PK_CommercialOrderItem] PRIMARY KEY CLUSTERED 
(
	[CommercialOrderItemID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--


--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--

If  Exists (select 1 from sys.objects where name = 'FK_CommercialOrderItem_CommercialOrder')
ALTER TABLE [POM].[CommercialOrderItem]  
 Drop   CONSTRAINT [FK_CommercialOrderItem_CommercialOrder] 
GO
If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrderItem_CommercialOrderRef')
ALTER TABLE  [POM].[CommercialOrderItem]   ADD CONSTRAINT FK_CommercialOrderItem_CommercialOrderRef FOREIGN KEY
	( CommercialOrderRef ) REFERENCES [POM].CommercialOrder ( CommercialOrderID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
GO


If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrderItem_PurchaseOrderItem')
ALTER TABLE [POM].[CommercialOrderItem]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrderItem_PurchaseOrderItem] FOREIGN KEY([PurchaseOrderItemRef])
REFERENCES [POM].PurchaseOrderItem
GO