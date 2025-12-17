
--<<FileName:PAY_PersonnelTaxFileInfoChangeLog.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('PAY.PersonnelTaxFileInfoChangeLog') IS NULL
CREATE TABLE [PAY].[PersonnelTaxFileInfoChangeLog](
	[PersonnelTaxFileInfoChangeLogId] [int] NOT NULL,
	[PersonnelRef] [INT] NOT NULL,
	[ChangeInfoDate] [DATETIME] NOT NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PersonnelTaxFileInfoChangeLog')
ALTER TABLE [PAY].[PersonnelTaxFileInfoChangeLog] ADD  CONSTRAINT [PK_PersonnelTaxFileInfoChangeLog] PRIMARY KEY CLUSTERED 
(
	[PersonnelTaxFileInfoChangeLogId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PersonnelTaxFileInfoChangeLog_PersonnelRef')
ALTER TABLE [PAY].[PersonnelTaxFileInfoChangeLog]  ADD  CONSTRAINT [FK_PersonnelTaxFileInfoChangeLog_PersonnelRef] FOREIGN KEY([PersonnelRef])
REFERENCES [PAY].[Personnel] ([PersonnelId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--