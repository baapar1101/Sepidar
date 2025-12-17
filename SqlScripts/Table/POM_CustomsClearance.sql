--<<FileName:POM_CustomsClearance.sql>>--  
--<< TABLE DEFINITION >>--
If Object_ID('POM.CustomsClearance') Is Null
CREATE  TABLE [POM].[CustomsClearance](
	[CustomsClearanceID] [int] NOT NULL,		
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	
	[DLRef] [int] NOT NULL,
	[SLRef] [int]  NULL,
		
	[InCustomsRef]  [int] NULL,
	[AssessCustomsRef]  [int] NULL,
	[OriginCountryRef] [int] NULL,
	
	[CurrencyRef] [int] not null,
	[Currencyrate] [Decimal](19,4) not null,

	[Description] [nvarchar](4000)  NULL,

	[Amount]   [Decimal](19,4) not null,
	[AmountInBaseCurrency]   [Decimal](19,4) not null,

	[CustomsCost]  [Decimal](19,4) not null,
	[Tax]   [Decimal](19,4) not null,
	[Duty]  [Decimal](19,4) not null,

	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL, 
	[PaymentHeaderRef] [int] NULL, 
	[NetPrice]  AS CONVERT([decimal](19,4), ([CustomsCost]+[Tax]+ [Duty])) PERSISTED,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearance') and
				[name] = 'ColumnName')
begin
    Alter table POM.CustomsClearance Add ColumnName DataType Nullable
end
GO*/
--<< ALTER COLUMNS >>--
if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearance') and
				[name] = 'InCustomsRef')
begin
    Alter table POM.CustomsClearance Add  [InCustomsRef]  [int] NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearance') and
				[name] = 'AssessCustomsRef')
begin
    Alter table POM.CustomsClearance Add  [AssessCustomsRef]  [int] NULL
end
GO
if  exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearance') and
				[name] = 'SlRef')
begin
    Alter table POM.CustomsClearance Alter Column [SlRef]  [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearance') and
				[name] = 'NetPrice')
begin
    Alter table POM.CustomsClearance Add  [NetPrice]  AS CONVERT([decimal](19,4), ([CustomsCost]+[Tax]+ [Duty])) PERSISTED
end
GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_CustomsClearance')
BEGIN
ALTER TABLE [POM].[CustomsClearance] ADD CONSTRAINT [PK_CustomsClearance] PRIMARY KEY CLUSTERED 
(
	[CustomsClearanceID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--


--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If  Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_InCustoms')
ALTER TABLE [POM].[CustomsClearance]  drop  [FK_CustomsClearance_InCustoms] 
GO
If Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_AssessCustoms')
ALTER TABLE [POM].[CustomsClearance]  drop [FK_CustomsClearance_AssessCustoms] 
GO

if exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearance') and
				[name] = 'InCustomsDLRef')
begin
    Alter table POM.CustomsClearance drop column InCustomsDLRef
end
GO
if exists (select 1 from sys.columns where object_id=object_id('POM.CustomsClearance') and
				[name] = 'AssessCustomsDlRef')
begin
    Alter table POM.CustomsClearance drop column [AssessCustomsDlRef]
end
GO
--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_InCustomsRef')
ALTER TABLE [POM].[CustomsClearance]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearance_InCustomsRef] FOREIGN KEY([InCustomsRef])
REFERENCES [POM].[Customs] ([CustomsId])
GO
If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_AssessCustomsRef')
ALTER TABLE [POM].[CustomsClearance]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearance_AssessCustomsRef] FOREIGN KEY([AssessCustomsRef])
REFERENCES [POM].[Customs] ([CustomsId])
GO



If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_VoucherRef')
ALTER TABLE [POM].[CustomsClearance]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearance_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherID])
GO
If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_PaymentHeader')
ALTER TABLE [POM].[CustomsClearance]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearance_PaymentHeader] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
GO





If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_OriginCountry')
ALTER TABLE [POM].[CustomsClearance]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearance_OriginCountry] FOREIGN KEY([OriginCountryRef])
REFERENCES [GNR].[Location] ([LocationID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearance_SL')
ALTER TABLE [POM].[CustomsClearance]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearance_SL] FOREIGN KEY([SLRef])
REFERENCES [Acc].[Account] ([AccountId])
GO


If not Exists (select 1 from sys.objects where name = 'FK_CustomsClearancer_FiscalYearRef')
ALTER TABLE [POM].[CustomsClearance]  WITH CHECK ADD  CONSTRAINT [FK_CustomsClearancer_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [Fmk].[FiscalYear] ([FiscalYearId])
GO
