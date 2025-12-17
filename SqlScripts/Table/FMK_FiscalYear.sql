--<<FileName:FMK_FiscalYear.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.FiscalYear') Is Null
CREATE TABLE [FMK].[FiscalYear](
	[FiscalYearId] [int] NOT NULL,
	[Title] [nvarchar](10) NOT NULL,
	[Title_En] [nvarchar](10) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('FMK.FiscalYear') and
				[name] = 'Title_En')
begin
    Alter table FMK.FiscalYear Add Title_En [nvarchar](10) NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_FiscalYear')
ALTER TABLE [FMK].[FiscalYear] ADD  CONSTRAINT [PK_FiscalYear] PRIMARY KEY CLUSTERED 
(
	[FiscalYearId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_FiscalYear_Title')
ALTER TABLE [FMK].[FiscalYear] ADD  CONSTRAINT [UIX_FiscalYear_Title] UNIQUE NONCLUSTERED 
(
	[Title] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
