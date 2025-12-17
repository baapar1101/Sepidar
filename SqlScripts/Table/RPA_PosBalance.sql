--<<FileName:RPA_PosBalance.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PosBalance') Is Null
CREATE TABLE [RPA].[PosBalance](
	[PosBalanceId] [int] NOT NULL,
	[Balance] [decimal](19, 4) NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[PosRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PosBalance')
ALTER TABLE [RPA].[PosBalance] ADD  CONSTRAINT [PK_PosBalance] PRIMARY KEY CLUSTERED 
(
	[PosBalanceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PosBalance_Pos')
ALTER TABLE [RPA].[PosBalance]  ADD  CONSTRAINT [FK_PosBalance_Pos] FOREIGN KEY([PosRef])
REFERENCES [RPA].[Pos] ([PosId])

Go

If not Exists (select 1 from sys.objects where name = 'FK_PosBalance_FiscalYearRef')
ALTER TABLE [RPA].[PosBalance]  ADD  CONSTRAINT [FK_PosBalance_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

Go
--<< DROP OBJECTS >>--
