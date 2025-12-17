--<<FileName:PAY_MonthlyData.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.MonthlyData') Is Null
CREATE TABLE [PAY].[MonthlyData](
	[MonthlyDataId] [int] NOT NULL,
--	[FiscalYearRef] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.MonthlyData') and
				[name] = 'ColumnName')
begin
    Alter table PAY.MonthlyData Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--Delete fiscalYearRef column and related FK
IF EXISTS (select 1 from sys.columns where object_id=object_id('PAY.MonthlyData') and [name] = 'FiscalYearRef')
BEGIN
	If Exists (select 1 from sys.objects where name = 'FK_MonthlyData_FiscalYearRef')
		ALTER TABLE [PAY].[MonthlyData]  DROP CONSTRAINT [FK_MonthlyData_FiscalYearRef] 

    Alter table PAY.MonthlyData DROP COLUMN [FiscalYearRef]
END


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_MonthlyData')
ALTER TABLE [PAY].[MonthlyData] ADD  CONSTRAINT [PK_MonthlyData] PRIMARY KEY CLUSTERED 
(
	[MonthlyDataId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_MonthlyData_Date')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_MonthlyData_Date] ON [PAY].[MonthlyData] 
(
	[Date] ASC
) ON [PRIMARY]


--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
