--<<FileName:POM_PurchaseRequest.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.PurchaseRequest') Is Null
CREATE  TABLE [POM].[PurchaseRequest](
	[PurchaseRequestID] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[StockRef] [int] NULL,
	[RequesterDepartmentDLRef] [int] NULL,
	[RequesterDLRef] [int] NULL,
	[ItemRequestRef] [int] NULL,
	[PurchasingAgentPartyRef] [int] null,
	[PurchasingProcedure] [int] null,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[State] [int] NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseRequest') and
				[name] = 'ColumnName')
begin
    Alter table POM.PurchaseRequest Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseRequest') and
		[name] = 'PurchasingAgentPartyRef')
begin
    Alter table POM.PurchaseRequest Add PurchasingAgentPartyRef INT NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PurchaseRequest')
BEGIN
ALTER TABLE [POM].[PurchaseRequest] ADD CONSTRAINT [PK_PurchaseRequest] PRIMARY KEY CLUSTERED 
(
	[PurchaseRequestID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--


If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequest_RequesterDepartmentDLRef')
ALTER TABLE [POM].[PurchaseRequest]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRequest_RequesterDepartmentDLRef] FOREIGN KEY([RequesterDepartmentDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequest_RequesterDLRef')
ALTER TABLE [POM].[PurchaseRequest]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRequest_RequesterDLRef] FOREIGN KEY([RequesterDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequest_StockRef')
ALTER TABLE [POM].[PurchaseRequest]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRequest_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequest_FiscalYearRef')
ALTER TABLE [POM].[PurchaseRequest]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRequest_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [Fmk].[FiscalYear] ([FiscalYearId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequest_ItemRequestRef')
ALTER TABLE [POM].[PurchaseRequest]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRequest_ItemRequestRef] FOREIGN KEY([ItemRequestRef])
REFERENCES [POM].[ItemRequest] ([ItemRequestId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequest_PurchasingAgentPartyRef')
ALTER TABLE [POM].[PurchaseRequest]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRequest_PurchasingAgentPartyRef] FOREIGN KEY([PurchasingAgentPartyRef])
REFERENCES [GNR].[Party] ([PartyId])
GO
