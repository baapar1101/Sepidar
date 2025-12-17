--<<FileName:GNR_Location.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Location') Is Null
CREATE TABLE [GNR].[Location](
	[LocationId] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NULL,
	[Code] [nvarchar](50) NULL,
	[Parent] [int] NULL,
	[Type] [nchar](10) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[MinistryofFinanceCode] [nvarchar](50) NULL,
	[TaxFileCode] [nvarchar](50) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.Location') and
				[name] = 'MinistryofFinanceCode')
begin
    Alter table GNR.Location Add MinistryofFinanceCode [nvarchar](50)
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where OBJECT_ID = OBJECT_ID('GNR.Location') AND
				[name] = 'TaxFileCode')
BEGIN
    ALTER TABLE GNR.Location ADD TaxFileCode [nvarchar](50)
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Location')
ALTER TABLE [GNR].[Location] ADD  CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Location_Parent')
ALTER TABLE [GNR].[Location]  ADD  CONSTRAINT [FK_Location_Parent] FOREIGN KEY([Parent])
REFERENCES [GNR].[Location] ([LocationId])

GO

--<< DROP OBJECTS >>--

if exists (select 1 from sys.columns where object_id=object_id('GNR.Location') and
				[name] = 'MinistryofFinanceCodeOfTownship')
begin
    Alter table GNR.Location drop column MinistryofFinanceCodeOfTownship
end
GO