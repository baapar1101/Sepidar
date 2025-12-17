--<<FileName:PAY_DailyHourMinute.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.DailyHourMinute') IS NULL
CREATE TABLE [PAY].[DailyHourMinute](
	[DailyHourMinuteId] [int] NOT NULL,
	[PayrollConfigurationRef] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[DailyHourMinute] [int] NOT NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.DailyHourMinute') and
				[name] = 'ColumnName')
begin
    Alter table PAY.DailyHourMinute Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_DailyHourMinute')
ALTER TABLE [PAY].[DailyHourMinute] ADD  CONSTRAINT [PK_DailyHourMinute] PRIMARY KEY CLUSTERED 
(
	[DailyHourMinuteId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'UC_DailyHourMinute_Year')
BEGIN
	ALTER TABLE [PAY].[DailyHourMinute] ADD CONSTRAINT UC_DailyHourMinute_Year UNIQUE ([Year])
END	

--ALTER TABLE [CNT].[Coefficient]  ADD CONSTRAINT UC_Coefficient_Code UNIQUE ([Code])

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_DailyHourMinute_PayrollConfigurationRef')
ALTER TABLE [PAY].[DailyHourMinute]  ADD  CONSTRAINT [FK_DailyHourMinute_PayrollConfigurationRef] FOREIGN KEY([PayrollConfigurationRef])
REFERENCES [PAY].[PayrollConfiguration] ([PayrollConfigurationId])
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
