--<<FileName:SLS_AdditionFactor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.AdditionFactor') Is Null
CREATE TABLE [SLS].[AdditionFactor](
	[AdditionFactorID] [int] NOT NULL,
	[Number] [INT] NOT NULL,
	[Title] [NVARCHAR](250) NOT NULL,
	[Title_En] [NVARCHAR](250) NOT NULL,
	[SaleVolumeType] [INT] NOT NULL,
	[Basis] [INT] NOT NULL,
	[IsActive] [BIT] NOT NULL,
	[IsEffectiveOnVat] [BIT] NOT NULL,
	[StartDate] [datetime] NULL, 
	[EndDate] [datetime] NULL, 
	[SaleTypeRef] [INT] NULL,  
	[CurrencyRef] [INT] NULL, 
	[CustomerGroupingRef] [INT] NULL,
	[SLRef] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.AdditionFactor') and
				[name] = 'ColumnName')
begin
    Alter table SLS.AdditionFactor Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AdditionFactor')
ALTER TABLE [SLS].[AdditionFactor] ADD  CONSTRAINT [PK_AdditionFactor] PRIMARY KEY CLUSTERED 
(
	[AdditionFactorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_AdditionFactor_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_AdditionFactor_Title] ON [SLS].[AdditionFactor] 
(
	[Title] ASC
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_AdditionFactor_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_AdditionFactor_Title_En] ON [SLS].[AdditionFactor] 
(
	[Title_En] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_SLS_AdditionFactor_CustomerGroupingRef')
ALTER TABLE [SLS].[AdditionFactor] ADD  CONSTRAINT [FK_SLS_AdditionFactor_CustomerGroupingRef] FOREIGN KEY([CustomerGroupingRef])
REFERENCES [GNR].[Grouping] ([GroupingID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_SLS_AdditionFactor_SaleTypeRef')
ALTER TABLE [SLS].[AdditionFactor]  ADD  CONSTRAINT [FK_SLS_AdditionFactor_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_SLS_AdditionFactor_CurrencyRef')
ALTER TABLE [SLS].[AdditionFactor]  ADD  CONSTRAINT [FK_SLS_AdditionFactor_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_SLS_AdditionFactor_SLRef')
ALTER TABLE [SLS].[AdditionFactor]  ADD  CONSTRAINT [FK_SLS_AdditionFactor_SLRef] FOREIGN KEY([SLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

--<< DROP OBJECTS >>--
