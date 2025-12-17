--<<FileName:PAY_Calculation.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Calculation') Is Null
CREATE TABLE [PAY].[Calculation](
	[CalculationId] [int] NOT NULL,
	[ElementRef] [int] NOT NULL,
	[BranchRef] [int] NULL,
	[PersonnelRef] [int] NULL,
	[Date] [datetime] NOT NULL,
	[Value] [decimal](24, 4) NOT NULL,
	[Type] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL, 
    [ContractRef] [int]  NULL,
    [VoucherRef] [int]  NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('PAY.Calculation') and
				[name] = 'VoucherRef')
begin
    Alter table PAY.Calculation Add [VoucherRef] [int]  NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
If Exists (select 1 from sys.objects where name = 'PK_CalcResult')
ALTER TABLE [PAY].[Calculation] DROP  CONSTRAINT [PK_CalcResult] 

Go

If not Exists (select 1 from sys.objects where name = 'PK_Calculation')
ALTER TABLE [PAY].[Calculation] ADD  CONSTRAINT [PK_Calculation] PRIMARY KEY CLUSTERED 
(
	[CalculationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (select 1 from sys.indexes where name = 'IX_Calculation_Composite')
CREATE NONCLUSTERED INDEX [IX_Calculation_Composite] ON [PAY].[Calculation] 
(
	Date, PersonnelRef, Type, ElementRef
) 
INCLUDE (Value, Year, Month, ContractRef, VoucherRef)
ON [PRIMARY]
GO

IF NOT EXISTS (select 1 from sys.indexes where name = 'UIX_Calculation_Fields')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Calculation_Fields] ON [PAY].[Calculation] 
(
	Date, BranchRef, PersonnelRef, Type, ElementRef
) 
ON [PRIMARY]


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CalcResult_ElementRef')
ALTER TABLE [PAY].[Calculation]  ADD  CONSTRAINT [FK_CalcResult_ElementRef] FOREIGN KEY([ElementRef])
REFERENCES [PAY].[Element] ([ElementId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_CalcResult_PersonnelRef')
ALTER TABLE [PAY].[Calculation]  ADD  CONSTRAINT [FK_CalcResult_PersonnelRef] FOREIGN KEY([PersonnelRef])
REFERENCES [PAY].[Personnel] ([PersonnelId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_CalcResult_ContractRef')
ALTER TABLE [PAY].[Calculation]  ADD  CONSTRAINT [FK_CalcResult_ContractRef] FOREIGN KEY([ContractRef])
REFERENCES [PAY].[Contract] ([ContractId])

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Name]='FK_CalcResult_VoucherRef')
	ALTER TABLE [PAY].[Calculation] ADD CONSTRAINT [FK_CalcResult_VoucherRef] FOREIGN KEY([VoucherRef])
	REFERENCES [ACC].[Voucher] ([VoucherId])

GO

--<< DROP OBJECTS >>--
