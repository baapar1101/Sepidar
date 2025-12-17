--<<FileName:SCD_Scheduling.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SCD.Scheduling') Is Null
CREATE TABLE [SCD].[Scheduling](
	[SchedulingId] [int] NOT NULL,	
	[Title] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL DEFAULT(1),
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,	
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
/*if not exists (select 1 from sys.columns where object_id=object_id('SCD.Scheduling') and
				[name] = 'ColumnName')
begin
    Alter table SCD.Scheduling Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Scheduling')
ALTER TABLE [SCD].[Scheduling] ADD  CONSTRAINT [PK_Scheduling] PRIMARY KEY CLUSTERED 
(
	[SchedulingId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_Scheduling_Title')
BEGIN
	ALTER TABLE [SCD].[Scheduling]
	ADD CONSTRAINT [UQ_Scheduling_Title] UNIQUE NONCLUSTERED
		(
			[Title]
		)
END
GO

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
