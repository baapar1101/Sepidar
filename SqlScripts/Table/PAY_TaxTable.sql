--<<FileName:PAY_TaxTable.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.TaxTable') Is Null
CREATE TABLE [PAY].[TaxTable](
	[TaxTableId] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[TaxGroupRef] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[TaxType] INT NOT NULL DEFAULT(1) ,
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
if not exists (select 1 from sys.columns where object_id=object_id('PAY.TaxTable') and
				[name] = 'TaxType')
begin
    Alter table PAY.TaxTable Add TaxType INT NOT NULL  DEFAULT(1)
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_TaxTable')
ALTER TABLE [PAY].[TaxTable] ADD  CONSTRAINT [PK_TaxTable] PRIMARY KEY CLUSTERED 
(
	[TaxTableId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_TaxTable_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TaxTable_Title] ON [PAY].[TaxTable] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_TaxTable_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TaxTable_Title_En] ON [PAY].[TaxTable] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Tax_TaxGroupRef')
ALTER TABLE [PAY].[TaxTable]  ADD  CONSTRAINT [FK_Tax_TaxGroupRef] FOREIGN KEY([TaxGroupRef])
REFERENCES [PAY].[TaxGroup] ([TaxGroupId])

GO

--<< DROP OBJECTS >>--
