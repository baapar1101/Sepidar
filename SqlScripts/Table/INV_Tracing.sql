--<<FileName:INV_Tracing.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.Tracing') Is Null
CREATE TABLE [INV].[Tracing](
	[TracingID] [int] NOT NULL,
	[TracingCategoryRef] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.Tracing') and
				[name] = 'ColumnName')
begin
    Alter table INV.Tracing Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Tracing')
ALTER TABLE [INV].[Tracing] ADD  CONSTRAINT [PK_Tracing] PRIMARY KEY CLUSTERED 
(
	[TracingID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_INV_Tracing_Title')
If not Exists (select 1 from [INV].[Tracing] group by [Title] having count(*) > 1)
CREATE UNIQUE NONCLUSTERED INDEX [UIX_INV_Tracing_Title] ON [INV].[Tracing] 
(
	[Title] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Tracing_TracingCategory')
ALTER TABLE [INV].[Tracing]  ADD  CONSTRAINT [FK_Tracing_TracingCategory] FOREIGN KEY([TracingCategoryRef])
REFERENCES [INV].[TracingCategory] ([TracingCategoryID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
