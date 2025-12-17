	--<<FileName:SLS_SaleType.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.SaleType') Is Null
CREATE TABLE [SLS].[SaleType](
	[SaleTypeId] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Title_En] [varchar](50) NOT NULL,
	[SaleTypeMarket] INT  NOT NULL,
	PartSalesSLRef [int] NULL,
	ServiceSalesSLRef [int] NULL,
	PartSalesReturnSLRef [int] NULL,
	ServiceSalesReturnSLRef [int] NULL,
	PartSalesDiscountSLRef [int] NULL,
	ServiceSalesDiscountSLRef [int] NULL,
	SalesAdditionSLRef [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'Number')
begin
    Alter table SLS.SaleType Add Number int null
end
Go
if exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'Number' and Is_Nullable = 1)
begin
	Update SLS.SaleType set Number = SaleTypeId where Number is null
    Alter table SLS.SaleType Alter column Number int not null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'SaleTypeMarket')
begin
    Alter table SLS.SaleType Add SaleTypeMarket int
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'PartSalesSLRef')
begin
    Alter table SLS.SaleType Add PartSalesSLRef int
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'ServiceSalesSLRef')
begin
    Alter table SLS.SaleType Add ServiceSalesSLRef int
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'PartSalesReturnSLRef')
begin
    Alter table SLS.SaleType Add PartSalesReturnSLRef int
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'ServiceSalesReturnSLRef')
begin
    Alter table SLS.SaleType Add ServiceSalesReturnSLRef int
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'PartSalesDiscountSLRef')
begin
    Alter table SLS.SaleType Add PartSalesDiscountSLRef int
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'ServiceSalesDiscountSLRef')
begin
    Alter table SLS.SaleType Add ServiceSalesDiscountSLRef int
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.SaleType') and
				[name] = 'SalesAdditionSLRef')
begin
    Alter table SLS.SaleType Add SalesAdditionSLRef int
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_SaleType')
ALTER TABLE [SLS].[SaleType] ADD  CONSTRAINT [PK_SaleType] PRIMARY KEY CLUSTERED 
(
	[SaleTypeId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_SaleType_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_SaleType_Title] ON [SLS].[SaleType] 
(
	[Title] ASC
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_SaleType_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_SaleType_Title_En] ON [SLS].[SaleType] 
(
	[Title_En] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_SaleType_PartSalesSLRef')
ALTER TABLE [SLS].[SaleType]  ADD  CONSTRAINT [FK_SaleType_PartSalesSLRef] FOREIGN KEY([PartSalesSLRef])
REFERENCES [ACC].[Account] ([AccountId])

If not Exists (select 1 from sys.objects where name = 'FK_SaleType_ServiceSalesSLRef')
ALTER TABLE [SLS].[SaleType]  ADD  CONSTRAINT [FK_SaleType_ServiceSalesSLRef] FOREIGN KEY([ServiceSalesSLRef])
REFERENCES [ACC].[Account] ([AccountId])

If not Exists (select 1 from sys.objects where name = 'FK_SaleType_PartSalesReturnSLRef')
ALTER TABLE [SLS].[SaleType]  ADD  CONSTRAINT [FK_SaleType_PartSalesReturnSLRef] FOREIGN KEY([PartSalesReturnSLRef])
REFERENCES [ACC].[Account] ([AccountId])

If not Exists (select 1 from sys.objects where name = 'FK_SaleType_ServiceSalesReturnSLRef')
ALTER TABLE [SLS].[SaleType]  ADD  CONSTRAINT [FK_SaleType_ServiceSalesReturnSLRef] FOREIGN KEY([ServiceSalesReturnSLRef])
REFERENCES [ACC].[Account] ([AccountId])

If not Exists (select 1 from sys.objects where name = 'FK_SaleType_PartSalesDiscountSLRef')
ALTER TABLE [SLS].[SaleType]  ADD  CONSTRAINT [FK_SaleType_PartSalesDiscountSLRef] FOREIGN KEY([PartSalesDiscountSLRef])
REFERENCES [ACC].[Account] ([AccountId])

If not Exists (select 1 from sys.objects where name = 'FK_SaleType_ServiceSalesDiscountSLRef')
ALTER TABLE [SLS].[SaleType]  ADD  CONSTRAINT [FK_SaleType_ServiceSalesDiscountSLRef] FOREIGN KEY([ServiceSalesDiscountSLRef])
REFERENCES [ACC].[Account] ([AccountId])

If not Exists (select 1 from sys.objects where name = 'FK_SaleType_SalesAdditionSLRef')
ALTER TABLE [SLS].[SaleType]  ADD  CONSTRAINT [FK_SaleType_SalesAdditionSLRef] FOREIGN KEY([SalesAdditionSLRef])
REFERENCES [ACC].[Account] ([AccountId])

--<< DROP OBJECTS >>--

