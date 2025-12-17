--<<FileName:SLS_Discount.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.Discount') Is Null
CREATE TABLE [SLS].[Discount](
	[DiscountID] [int] NOT NULL,
	[Number] [INT] NOT NULL,
	[Title] [NVARCHAR](250) NOT NULL,
	[Title_En] [NVARCHAR](250) NOT NULL,
	[SaleVolumeType] [INT] NOT NULL,
	[DiscountCalcType] [INT] NOT NULL,
	[DiscountCalculationBasis] [INT] NOT NULL,
	[IsActive] [BIT] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	StartDate [datetime] NULL, 
	EndDate [datetime] NULL, 
	SaleTypeRef [INT] NULL,  
	CurrencyRef [INT] NULL, 
	CustomerGroupingRef [INT] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Discount') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Discount Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Discount') and
				[name] = 'StartDate')
begin
    Alter table SLS.Discount Add StartDate [datetime] NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Discount') and
				[name] = 'EndDate')
begin
    Alter table SLS.Discount Add EndDate [datetime] NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Discount') and
				[name] = 'SaleTypeRef')
begin
    Alter table SLS.Discount Add SaleTypeRef [INT] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Discount') and
				[name] = 'DiscountCalculationBasis')
begin
    Alter table SLS.Discount Add DiscountCalculationBasis [INT] not NULL default(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Discount') and
				[name] = 'CurrencyRef')
begin
    Alter table SLS.Discount Add CurrencyRef [INT] NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Discount') and
				[name] = 'CustomerGroupingRef')
begin
    Alter table SLS.Discount Add CustomerGroupingRef [INT] NULL
end
GO	

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Discount')
ALTER TABLE [SLS].[Discount] ADD  CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_Discount_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_Discount_Title] ON [SLS].[Discount] 
(
	[Title] ASC
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_Discount_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_Discount_Title_En] ON [SLS].[Discount] 
(
	[Title_En] ASC
) ON [PRIMARY]
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_SLS_Discount_CustomerGroupingRef')
ALTER TABLE [SLS].[Discount] ADD  CONSTRAINT [FK_SLS_Discount_CustomerGroupingRef] FOREIGN KEY([CustomerGroupingRef])
REFERENCES [GNR].[Grouping] ([GroupingID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_SLS_Discount_SaleTypeRef')
ALTER TABLE [SLS].[Discount]  ADD  CONSTRAINT [FK_SLS_Discount_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_SLS_Discount_CurrencyRef')
ALTER TABLE [SLS].[Discount]  ADD  CONSTRAINT [FK_SLS_Discount_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
--<< DROP OBJECTS >>--
