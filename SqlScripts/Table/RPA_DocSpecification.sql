--<<FileName:RPA_DocSpecification.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.DocSpecification') Is Null
CREATE TABLE [RPA].[DocSpecification](
	[DocSpecificationId] [int] NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Description_En] [nvarchar](100) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.DocSpecification') and
				[name] = 'ColumnName')
begin
    Alter table RPA.DocSpecification Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DocSpecification')
ALTER TABLE [RPA].[DocSpecification] ADD  CONSTRAINT [PK_DocSpecification] PRIMARY KEY CLUSTERED 
(
	[DocSpecificationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
