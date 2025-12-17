--<<FileName:POM_Customs.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.Customs') Is Null
CREATE  TABLE [POM].[Customs](
	[CustomsID] [int] NOT NULL,
	[Code] [varchar](40) NOT NULL,
	[Title] [varchar](1000) NOT NULL,
	[Title_En] [varchar](100) NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.Customs') and
				[name] = 'ColumnName')
begin
    Alter table POM.Customs Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
if  exists (select 1 from sys.columns where object_id=object_id('POM.Customs') and
				[name] = 'Code')
begin
    Alter table POM.Customs ALTER COLUMN [Code] [varchar](40) NOT NULL
end
GO
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_Customs')
BEGIN
ALTER TABLE [POM].[Customs] ADD CONSTRAINT [PK_Customs] PRIMARY KEY CLUSTERED 
(
	[CustomsID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--


--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--


