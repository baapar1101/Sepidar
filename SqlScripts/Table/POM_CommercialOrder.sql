--<<FileName:POM_CommercialOrder.sql>>--  drop TABLE [POM].[CommercialOrder] 
--<< TABLE DEFINITION >>--
If Object_ID('POM.CommercialOrder') Is Null
CREATE  TABLE [POM].[CommercialOrder](
	[CommercialOrderID] [int] NOT NULL,	
	[PurchaseOrderRef] [int] NOT NULL,	
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ValidityDate] [datetime] NULL,
	[DLRef] [int] NOT NULL,
	[SLRef] [int]  NULL,
	[RegisterFee] [decimal](19, 4) NULL,
	
	[SharingMethod] [int]  NULL,
	
	[LoadingPlace] [nvarchar](100)  NULL,	
	[InCustomsRef]  [int] NULL,
	[OutCustomsRef]  [int] NULL,
	[OriginCountryRef] [int] NULL,
	
	[Description] [nvarchar](4000)  NULL,

	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL, 
	[PaymentHeaderRef] [int] NULL, 

	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'ColumnName')
begin
    Alter table POM.CommercialOrder Add ColumnName DataType Nullable
end
GO*/


if  not exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'InCustomsRef')
begin
    Alter table POM.CommercialOrder add [InCustomsRef]  [int] NULL
end
GO	
if  not  exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'OutCustomsRef')
begin
    Alter table POM.CommercialOrder add [OutCustomsRef]  [int] NULL
end
GO
	

if not exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'SharingMethod')
begin
    Alter table POM.CommercialOrder Add [SharingMethod] [int]  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'PaymentHeaderRef')
begin
    Alter table POM.CommercialOrder Add [PaymentHeaderRef] [int]  NULL
end
GO




--<< ALTER COLUMNS >>--
if  exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'SLRef')
begin
    Alter table POM.CommercialOrder alter column  [SLRef] [int]  NULL
end
GO


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_CommercialOrder')
BEGIN
ALTER TABLE [POM].[CommercialOrder] ADD CONSTRAINT [PK_CommercialOrder] PRIMARY KEY CLUSTERED 
(
	[CommercialOrderID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--


--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--
If  Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_InCustomsDL')
	ALTER TABLE [POM].[CommercialOrder]  DROP  CONSTRAINT [FK_CommercialOrder_InCustomsDL] 
GO

If  Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_OutCustomsDL')
ALTER TABLE [POM].[CommercialOrder]  Drop  CONSTRAINT [FK_CommercialOrder_OutCustomsDL] 
GO

if  exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'InCustomsDLRef')
begin
    Alter table POM.CommercialOrder drop column  [InCustomsDLRef]
end
GO

if  exists (select 1 from sys.columns where object_id=object_id('POM.CommercialOrder') and
				[name] = 'OutCustomsDLRef')
begin
    Alter table POM.CommercialOrder drop column  [OutCustomsDLRef]
end
GO

If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_OutCustomsRef')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_OutCustomsRef] FOREIGN KEY([OutCustomsRef])
REFERENCES [POM].[Customs] ([CustomsId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_InCustomsRef')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_InCustomsRef] FOREIGN KEY([InCustomsRef])
REFERENCES [POM].[Customs] ([CustomsId])
GO




If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_VoucherRef')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherID])
GO
If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_PaymentHeader')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_PaymentHeader] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
GO



If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_OriginCountry')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_OriginCountry] FOREIGN KEY([OriginCountryRef])
REFERENCES [GNR].[Location] ([LocationID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_SL')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_SL] FOREIGN KEY([SLRef])
REFERENCES [Acc].[Account] ([AccountId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_PurchaseOrder')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_PurchaseOrder] FOREIGN KEY([PurchaseOrderRef])
REFERENCES [POM].[PurchaseOrder] ([PurchaseOrderId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_CommercialOrder_FiscalYearRef')
ALTER TABLE [POM].[CommercialOrder]  WITH CHECK ADD  CONSTRAINT [FK_CommercialOrder_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [Fmk].[FiscalYear] ([FiscalYearId])
GO

