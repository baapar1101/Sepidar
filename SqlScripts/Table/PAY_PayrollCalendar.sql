--<<FileName:PAY_PayrollCalendar.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.PayrollCalendar') Is Null
CREATE TABLE [PAY].[PayrollCalendar](
	[PayrollCalendarId] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Day] [int] NULL,
	[HourMinute] [int] NULL,
	[TotalHourMinute]  AS ([Day]*[HourMinute]),
	[PayrollConfigurationRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('PAY.PayrollCalendar') AND
--				[name] = 'Column')
--BEGIN
--    ALTER TABLE PAY.PayrollCalendar ADD Column Type NULL
--END
--GO

--<< ALTER COLUMNS >>--

IF (NOT EXISTS (SELECT 1 FROM SYS.columns WHERE OBJECT_ID = OBJECT_ID('Pay.PayrollCalendar') AND
												[NAME] = 'Year'))
BEGIN
	ALTER TABLE Pay.PayrollCalendar ADD [Year] [int] NULL
END

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PayrollCalendar')
ALTER TABLE [PAY].[PayrollCalendar] ADD  CONSTRAINT [PK_PayrollCalendar] PRIMARY KEY CLUSTERED 
(
	[PayrollCalendarId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PayrollCalendar_PayrollConfigurationRef')
ALTER TABLE [PAY].[PayrollCalendar]  ADD  CONSTRAINT [FK_PayrollCalendar_PayrollConfigurationRef] FOREIGN KEY([PayrollConfigurationRef])
REFERENCES [PAY].[PayrollConfiguration] ([PayrollConfigurationId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
