--<<FileName:GNR_UserReport.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.UserReportsInvisible') Is Null
CREATE TABLE FMK.UserReportsInvisible(
	[UserReportsInvisibleID] int NOT NULL,
	[Name] [nvarchar](255) NULL,
	[VisibleInApp] BIT NOT NULL DEFAULT(0),
	[VisibleInMobile] BIT NOT NULL DEFAULT(0)
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--if not exists (select 1 from sys.columns where object_id=object_id('GNR.UserReport') and
--				[name] = 'PersianTitle')
--begin
--    Alter table GNR.UserReport Add PersianTitle [nvarchar](255) NULL
--end
--GO
IF NOT EXISTS (SELECT 1 FROM sys.Columns WHERE object_id=object_id('FMK.UserReportsInvisible') AND
	[name] = 'VisibleInApp')
BEGIN
   ALTER TABLE FMK.UserReportsInvisible ADD [VisibleInApp] BIT NOT NULL DEFAULT(0)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.Columns WHERE object_id=object_id('FMK.UserReportsInvisible') AND
	[name] = 'VisibleInMobile')
BEGIN
   ALTER TABLE FMK.UserReportsInvisible ADD [VisibleInMobile] BIT NOT NULL DEFAULT(0)
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_UserReportsInvisible')
ALTER TABLE FMK.UserReportsInvisible ADD  CONSTRAINT [PK_UserReportsInvisible] PRIMARY KEY CLUSTERED 
(
	[UserReportsInvisibleID] ASC
) ON [PRIMARY]
GO
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
