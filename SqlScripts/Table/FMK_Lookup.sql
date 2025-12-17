--<<FileName:FMK_Lookup.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.Lookup') Is Null
CREATE TABLE [FMK].[Lookup](
	[LookupID] [int] NOT NULL IDENTITY(1,1),
	[Type] [nchar](50) NOT NULL,
	[Code] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Title_En] [nvarchar](100) NULL,
	[DisplayOrder] [int] NOT NULL,
	[Extra] [nvarchar](100) NULL,
	[System] [char](3) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.Lookup') and
				[name] = 'ColumnName')
begin
    Alter table FMK.Lookup Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('FMK.Lookup') and
				[name] = 'LookupID')
begin
    Alter table FMK.Lookup Add LookupID [int] NOT NULL IDENTITY(1,1)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('FMK.Lookup') and
				[name] = 'Title_En')
begin
    Alter table FMK.Lookup Add [Title_En] [nvarchar](100) NULL -- compatibility issue!
end
GO

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('FMK.Lookup') and
				[name] = 'Title_En' and is_nullable = 0)
begin
    Alter table FMK.Lookup alter column [Title_En] [nvarchar](100) NULL -- compatibility issue!
end
GO

--<< PRIMARYKEY DEFINITION >>--
If not Exists
(
	SELECT 1 FROM sys.indexes i
		JOIN sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id
		JOIN sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
	WHERE i.name  = 'PK_SG_Lookup' and c.name = 'LookupID'
) AND Exists(select 1 from sys.objects where name = 'PK_SG_Lookup')
	ALTER TABLE [FMK].[Lookup] DROP CONSTRAINT PK_SG_Lookup
GO

If not Exists (select 1 from sys.objects where name = 'PK_SG_Lookup')
ALTER TABLE [FMK].[Lookup] ADD  CONSTRAINT [PK_SG_Lookup] PRIMARY KEY CLUSTERED 
(
	[LookupID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_SG_Lookup')
CREATE UNIQUE NONCLUSTERED INDEX [IX_SG_Lookup] ON [FMK].[Lookup] 
(
	[Type] ASC,
	[Code] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
