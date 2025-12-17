--<<FileName:INV_Property.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.Property') Is Null
CREATE TABLE [INV].[Property](
	[PropertyID]            [int]           NOT NULL,
	[Title]                 [nvarchar](120) NOT NULL,
	[Title_En]              [nvarchar](120) NOT NULL,
	[IsSelectable]			[bit]			NOT NULL,	
	[IsActive]              [bit]           NOT NULL,
	[Number]                [int]           NOT NULL,
	[Creator]               [int]           NOT NULL,
	[CreationDate]          [datetime]      NOT NULL,
	[LastModifier]          [int]           NOT NULL,
	[LastModificationDate]  [datetime]      NOT NULL,
	[Version]               [int]           NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code

--<< ADD CLOLUMNS >>--


Go
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.Property') and
				[name] = 'ColumnName')
begin
    Alter table INV.Property Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('INV.Property') and
				[name] = 'IsReadOnly')
begin
	EXEC sp_RENAME 'INV.Property.IsReadOnly' , 'IsSelectable', 'COLUMN'
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('INV.Property') and
				[name] = 'IsSelectable')
begin
    Alter table INV.Property Add IsSelectable bit NOT NULL DEFAULT 0
end
Go

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Property')
ALTER TABLE [INV].[Property] ADD  CONSTRAINT [PK_Property] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--If not Exists (select 1 from sys.indexes where name = 'IX_ColumnName')
--CREATE NONCLUSTERED INDEX [IX_ColumnName] ON [INV].[Property] 
--(
--	[ColumnName] ASC
--) ON [PRIMARY]

--GO


--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
