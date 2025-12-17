--<<FileName:CNT_CostStatement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.CostStatement') Is Null
CREATE TABLE [CNT].[CostStatement](
	[CostStatementID] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[WorkshopRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[VoucherType] int NOT NULL,
	[VoucherRef] [int] NULL,
	[FundResponderDLRef] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[Established] bit NOT NULL, 
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatement') and
				[name] = 'ColumnName')
begin
    Alter table CNT.CostStatement Add ColumnName DataType Nullable
end
GO*/


if not exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatement') and
				[name] = 'FundResponderDLRef')
begin
    Alter table CNT.CostStatement Add FundResponderDLRef INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatement') and
				[name] = 'VoucherRef')
begin
    ALTER TABLE CNT.CostStatement Add VoucherRef int Null
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatement') and
				[name] = 'FiscalYearRef')
begin
    ALTER TABLE CNT.CostStatement Add FiscalYearRef [int] NOT NULL DEFAULT 1
end
GO

--<< ALTER COLUMNS >>--
if not exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatement') and
				[name] = 'Established')
begin
    Alter table CNT.CostStatement Add Established bit NOT NULL DEFAULT 0
end

GO




--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CostStatement')
ALTER TABLE [CNT].[CostStatement] ADD  CONSTRAINT [PK_CostStatement] PRIMARY KEY CLUSTERED 
(
	[CostStatementID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CostStatement_Contract')
ALTER TABLE [CNT].[CostStatement]  ADD  CONSTRAINT [FK_CostStatement_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_CostStatement_Workshop')
ALTER TABLE [CNT].[CostStatement]  ADD  CONSTRAINT [FK_CostStatement_Workshop] FOREIGN KEY([WorkshopRef])
REFERENCES [CNT].[Workshop] ([WorkshopID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_CostStatement_FiscalYear')
ALTER TABLE [CNT].[CostStatement]  ADD  CONSTRAINT [FK_CostStatement_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_CostStatement_DL')
ALTER TABLE [CNT].[CostStatement]  ADD  CONSTRAINT [FK_CostStatement_DL] FOREIGN KEY([FundResponderDLRef])
REFERENCES [ACC].[DL] ([DLID])

GO

--<< DROP OBJECTS >>--

If Exists (select 1 from sys.objects where name = 'FK_CostStatement_Party')
ALTER TABLE [CNT].[CostStatement]  DROP CONSTRAINT [FK_CostStatement_Party]

GO


if exists (select 1 from sys.columns where object_id=object_id('CNT.CostStatement') and
				[name] = 'FundResponderRef')
Alter table CNT.CostStatement DROP COLUMN FundResponderRef

GO