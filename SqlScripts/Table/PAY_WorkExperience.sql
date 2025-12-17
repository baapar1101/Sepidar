--<<FileName:PAY_WorkExperience.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.WorkExperience') Is Null
CREATE TABLE [PAY].[WorkExperience](
	[WorkExperienceId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Duration] [int] NOT NULL,
	[Company] [nvarchar](250) NOT NULL,
	[Career] [nvarchar](250) NOT NULL,
	[QuitReason] [nvarchar](4000) NOT NULL,
	[PersonnelRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.WorkExperience') and
				[name] = 'ColumnName')
begin
    Alter table PAY.WorkExperience Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_WorkExperience')
ALTER TABLE [PAY].[WorkExperience] ADD  CONSTRAINT [PK_WorkExperience] PRIMARY KEY CLUSTERED 
(
	[WorkExperienceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If Exists (select 1 from sys.objects where name = 'FK_WorkExperience_PersonnelRef')
ALTER TABLE [PAY].[WorkExperience] DROP [FK_WorkExperience_PersonnelRef]
Go

ALTER TABLE [PAY].[WorkExperience]  ADD  CONSTRAINT [FK_WorkExperience_PersonnelRef] FOREIGN KEY([PersonnelRef])
REFERENCES [PAY].[Personnel] ([PersonnelId])
ON DELETE CASCADE
GO
--If not Exists (select 1 from sys.objects where name = 'FK_WorkExperience_PersonnelRef')
--ALTER TABLE [PAY].[WorkExperience]  ADD  CONSTRAINT [FK_WorkExperience_PersonnelRef] FOREIGN KEY([PersonnelRef])
--REFERENCES [PAY].[Personnel] ([PersonnelId])
--ON DELETE CASCADE
--GO

--<< DROP OBJECTS >>--
