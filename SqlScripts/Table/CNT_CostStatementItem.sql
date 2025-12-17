--<<FileName:CNT_CostStatementItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.CostStatementItem') Is Null
CREATE TABLE [CNT].[CostStatementItem](
	[CostStatementItemID] [int] NOT NULL,
	[CostStatementRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[ItemRef] [int] NULL,
	[CostTypeRef] [int] NOT NULL,
	[Quantity] [decimal](19,4) NULL,
	[Fee] AS (CAST( (CASE WHEN [Quantity]=(0) THEN (0) ELSE [Price]/[Quantity] END) AS decimal(19,4))) PERSISTED,
	[Price] [decimal](19, 4) NOT NULL,
	[InvoiceNumber] [int] NULL,
	[InvoiceDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
	[SlRef] [int] NULL,
	[PartyRef] [int] NULL,
	[InitialSettledValue] decimal(19,4) NULL,
	[CostSLRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatementItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.CostStatementItem Add ColumnName DataType Nullable
end
GO*/



if not exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatementItem') and
				[name] = 'CostTypeRef')
begin
    Alter table CNT.CostStatementItem Add CostTypeRef int NOT Null
end
GO

--<< ALTER COLUMNS >>--

IF EXISTS (select 1 from sys.columns where object_id=object_id('CNT.CostStatementItem') and
				[name] = 'SLRef' and is_nullable=0)
	ALTER TABLE CNT.CostStatementItem ALTER COLUMN SLRef INT NULL

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.CostStatementItem')
	AND [name]='ItemRef' AND is_nullable=0)
BEGIN
	ALTER TABLE CNT.CostStatementItem ALTER COLUMN ItemRef int NULL
END

GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.CostStatementItem') AND
				[Name] = 'Quantity' AND (is_nullable=0 OR system_type_id=62 /* float */))
BEGIN
	-- Column Fee is dependant on Quantity column. Drop it first.
	IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.CostStatementItem') AND [Name] = 'Fee')
		ALTER TABLE CNT.CostStatementItem DROP COLUMN Fee
				
	ALTER TABLE CNT.CostStatementItem ALTER COLUMN Quantity [decimal](19,4) NULL
END

GO


IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.CostStatementItem') AND
				[Name] = 'Fee' AND is_computed=0)
BEGIN
	ALTER TABLE CNT.CostStatementItem
		DROP COLUMN Fee
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.CostStatementItem') AND
				[Name] = 'Fee')
BEGIN
	ALTER TABLE CNT.CostStatementItem ADD [Fee] AS (CAST( (CASE WHEN [Quantity]=(0) THEN (0) ELSE [Price]/[Quantity] END) AS decimal(19,4))) PERSISTED
END

GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id=object_id('CNT.CostStatementItem') AND [name]='InitialSettledValue')
	ALTER TABLE CNT.CostStatementItem ADD [InitialSettledValue] decimal(19,4) NULL

GO
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id=object_id('CNT.CostStatementItem') AND [name]='CostSLRef')
	ALTER TABLE CNT.CostStatementItem ADD [CostSLRef] int NULL
	
GO


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CostStatementItem')
ALTER TABLE [CNT].[CostStatementItem] ADD  CONSTRAINT [PK_CostStatementItem] PRIMARY KEY CLUSTERED 
(
	[CostStatementItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CostStatementItem_Item')
ALTER TABLE [CNT].[CostStatementItem]  ADD  CONSTRAINT [FK_CostStatementItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_CostStatementItem_Party')
ALTER TABLE [CNT].[CostStatementItem]  ADD  CONSTRAINT [FK_CostStatementItem_Party] FOREIGN KEY([partyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_CostStatementItem_Account')
ALTER TABLE [CNT].[CostStatementItem]  ADD  CONSTRAINT [FK_CostStatementItem_Account] FOREIGN KEY([SlRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_CostStatementItem_CostStatement')
ALTER TABLE [CNT].[CostStatementItem]  ADD  CONSTRAINT [FK_CostStatementItem_CostStatement] FOREIGN KEY([CostStatementRef])
REFERENCES [CNT].[CostStatement] ([CostStatementId])
ON DELETE CASCADE

GO


If not Exists (select 1 from sys.objects where name = 'FK_CostStatementItem_Cost')
ALTER TABLE [CNT].[CostStatementItem]  ADD  CONSTRAINT [FK_CostStatementItem_Cost] FOREIGN KEY([CostTypeRef])
REFERENCES [CNT].[Cost] ([CostId])

GO

--<< DROP OBJECTS >>--
If  Exists (select 1 from sys.objects where name = 'FK_CostStatementItem_Voucher')
ALTER TABLE [CNT].[CostStatementItem]  DROP  CONSTRAINT [FK_CostStatementItem_Voucher] 

GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatementItem') and
				[name] = 'VoucherRef')
begin
    ALTER TABLE CNT.CostStatementItem Drop COLUMN VoucherRef
end
GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatementItem') and
				[name] = 'Type')
begin
    ALTER TABLE CNT.CostStatementItem DROP COLUMN [Type]
end
GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatementItem') and
				[name] = 'StockRef')
begin
    ALTER TABLE CNT.CostStatementItem DROP COLUMN [StockRef]
end
GO