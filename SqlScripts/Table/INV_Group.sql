--<<FileName:INV_Group.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.Group') Is Null
CREATE TABLE [INV].[Group](
	[GroupID] [int] NOT NULL,
	[Code] [nvarchar](4) NOT NULL,
	[Title] [nvarchar](120) NOT NULL,
	[Title_En] [nvarchar](120) NOT NULL,
	[ParentRef]  [int] NOT NULL,
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

GO
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.Group') and
				[name] = 'ColumnName')
begin
    Alter table INV.Group Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Group')
ALTER TABLE [INV].[Group] ADD  CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_Title')
CREATE NONCLUSTERED INDEX [IX_Title] ON [INV].[Group] 
(
	[Title] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_Title_En')
CREATE NONCLUSTERED INDEX [IX_Title_En] ON [INV].[Group] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_Unique_Code')
CREATE UNIQUE INDEX IX_Unique_Code ON [INV].[Group] 
(
	[Code] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_Unique_Title_ParentRef')
CREATE UNIQUE INDEX IX_Unique_Title_ParentRef ON [INV].[Group] 
(
	[Title] ASC,
	[ParentRef] ASC
) ON [PRIMARY]

GO

If not Exists (select 1 from sys.indexes where name = 'IX_Unique_TitleEN_ParentRef')
CREATE UNIQUE INDEX IX_Unique_TitleEN_ParentRef ON [INV].[Group] 
(
	[Title_En] ASC,
	[ParentRef] ASC
) ON [PRIMARY]

GO


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Group_Group')
ALTER TABLE [INV].[Group]  ADD  CONSTRAINT [FK_Group_Group] FOREIGN KEY([ParentRef])
REFERENCES [INV].[Group] ([GroupId])
--<< DROP OBJECTS >>--
