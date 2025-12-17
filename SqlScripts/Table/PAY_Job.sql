--<<FileName:PAY_Job.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Job') Is Null
CREATE TABLE [PAY].[Job](
	[JobId] [int] NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[HardCode] [nvarchar](40) NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Code] [int] NOT NULL,
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
if not exists (select 1 from sys.columns where object_id=object_id('PAY.Job') and
				[name] = 'GuildType')
begin
    Alter table PAY.Job Add GuildType int
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Job')
ALTER TABLE [PAY].[Job] ADD  CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Job_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Job_Title] ON [PAY].[Job] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Job_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Job_Title_En] ON [PAY].[Job] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
