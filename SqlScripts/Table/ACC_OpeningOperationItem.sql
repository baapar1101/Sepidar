--<<FileName:ACC_OpeningOperationItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.OpeningOperationItem') Is Null
CREATE TABLE [ACC].[OpeningOperationItem](
	[OpeningOperationItemId] [int] NOT NULL,
	[OpeningOperationRef] [int] NOT NULL,
	[RecordType] [varchar](400) NOT NULL,
	[RecordId] [int] NOT NULL,
	[Checked] [bit] NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('ACC.OpeningOperationItem') and
				[name] = 'ColumnName')
begin
    Alter table ACC.OpeningOperationItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_OpeningOperationItem')
ALTER TABLE [ACC].[OpeningOperationItem] ADD  CONSTRAINT [PK_OpeningOperationItem] PRIMARY KEY CLUSTERED 
(
	[OpeningOperationItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_OpeningOperationItem')
CREATE UNIQUE NONCLUSTERED INDEX [IX_OpeningOperationItem] ON [ACC].[OpeningOperationItem] 
(
	[RecordType] ASC,
	[RecordId] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_OpeningOperationItem_OpeningOperationRef')
ALTER TABLE [ACC].[OpeningOperationItem]  ADD  CONSTRAINT [FK_OpeningOperationItem_OpeningOperationRef] FOREIGN KEY([OpeningOperationRef])
REFERENCES [ACC].[OpeningOperation] ([OpeningOperationId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
