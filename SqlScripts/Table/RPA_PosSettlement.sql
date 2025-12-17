--<<FileName:RPA_PosSettlement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PosSettlement') Is Null
CREATE TABLE [RPA].[PosSettlement](
	[PosSettlementID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[SettleReceiptsTo] [datetime] NOT NULL,
	[PosRef] [int] NOT NULL,
	[SettlementReceiptRef] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('RPA.PosSettlement') and
				[name] = 'FiscalYearRef')
begin
    Alter table RPA.PosSettlement Add [FiscalYearRef] [int] null
end
Go
Update P
Set FiscalYearRef = FiscalYear.FiscalyearId
From Fmk.FiscalYear FiscalYear
inner join RPA.PosSettlement P
On P.Date >= FiscalYear.StartDate And P.Date <= FiscalYear.endDate
Where FiscalYearRef is null
GO
Alter table RPA.PosSettlement Alter Column [FiscalYearRef] [int] not null
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PosSettlement')
ALTER TABLE [RPA].[PosSettlement] ADD  CONSTRAINT [PK_PosSettlement] PRIMARY KEY CLUSTERED 
(
	[PosSettlementID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PosSettlement_Pos')
ALTER TABLE [RPA].[PosSettlement]  ADD  CONSTRAINT [FK_PosSettlement_Pos] FOREIGN KEY([PosRef])
REFERENCES [RPA].[Pos] ([PosId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PosSettlement_ReceiptHeader')
ALTER TABLE [RPA].[PosSettlement]  ADD  CONSTRAINT [FK_PosSettlement_ReceiptHeader] FOREIGN KEY([SettlementReceiptRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PosSettlement_FiscalYearRef')
ALTER TABLE [RPA].[PosSettlement]  ADD  CONSTRAINT [FK_PosSettlement_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [Fmk].[FiscalYear] ([FiscalYearId])

Go
--<< DROP OBJECTS >>--
