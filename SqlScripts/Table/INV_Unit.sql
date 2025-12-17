--<<FileName:INV_Unit.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.Unit') Is Null
CREATE TABLE [INV].[Unit](
	[UnitID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Title_En] [nvarchar](50) NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.Unit') and
				[name] = 'ColumnName')
begin
    Alter table INV.Unit Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Unit')
ALTER TABLE [INV].[Unit] ADD  CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Unit_Title')
ALTER TABLE [INV].[Unit] ADD  CONSTRAINT [UIX_Unit_Title] UNIQUE NONCLUSTERED 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Unit_Title_En')
ALTER TABLE [INV].[Unit] ADD  CONSTRAINT [UIX_Unit_Title_En] UNIQUE NONCLUSTERED 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
