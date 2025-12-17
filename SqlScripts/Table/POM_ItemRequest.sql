--<<FileName:POM_ItemRequest.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.ItemRequest') Is Null
CREATE  TABLE [POM].[ItemRequest](
	[ItemRequestID] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,

	[StockRef] [int] NULL,
	[ProductOrderRef] [int] NULL,
	[RequesterDepartmentDLRef] [int] NULL,
	[RequesterStockRef] [int] NULL,
	[RequesterDLRef] [int] NULL,

	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[State] [int] NOT NULL,
	[RequestType] [int] NOT NULL,
	[Description] [nvarchar](4000)  NULL,

	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[LastAcceptor] [int] NULL,
	[LastAcceptDate] [datetime] NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.ItemRequest') and
				[name] = 'ColumnName')
begin
    Alter table POM.ItemRequest Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('POM.ItemRequest') and 
				[name] = 'ProductOrderRef')
begin
    Alter table POM.ItemRequest ADD [ProductOrderRef] INT NULL
end
GO

--<< ALTER COLUMNS >>--
if  exists (select 1 from sys.columns where object_id=object_id('POM.ItemRequest') and    ----TODO: Delete Alter
				[name] = 'StockRef')
begin
    Alter table POM.ItemRequest ALTER COLUMN [StockRef] INT NULL
end
GO
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ItemRequest')
BEGIN
ALTER TABLE [POM].[ItemRequest] ADD CONSTRAINT [PK_ItemRequest] PRIMARY KEY CLUSTERED 
(
	[ItemRequestID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--


If not Exists (select 1 from sys.objects where name = 'FK_ItemRequest_RequesterDepartmentDLRef')
ALTER TABLE [POM].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequest_RequesterDepartmentDLRef] FOREIGN KEY([RequesterDepartmentDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemRequest_RequesterDLRef')
ALTER TABLE [POM].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequest_RequesterDLRef] FOREIGN KEY([RequesterDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemRequest_RequesterStockRef')
ALTER TABLE [POM].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequest_RequesterStockRef] FOREIGN KEY([RequesterStockRef])
REFERENCES [INV].[Stock] ([StockId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemRequest_StockRef')
ALTER TABLE [POM].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequest_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemRequest_FiscalYearRef')
ALTER TABLE [POM].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequest_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [Fmk].[FiscalYear] ([FiscalYearId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemRequest_ProductOrderRef')
ALTER TABLE [POM].[ItemRequest]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequest_ProductOrderRef] FOREIGN KEY([ProductOrderRef])
REFERENCES [WKO].[ProductOrder] ([ProductOrderId])
GO