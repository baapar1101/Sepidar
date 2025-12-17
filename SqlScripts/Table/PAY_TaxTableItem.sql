--<<FileName:PAY_TaxTableItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.TaxTableItem') Is Null
CREATE TABLE [PAY].[TaxTableItem](
	[TaxTableItemId] [int] NOT NULL,
	[FromAmount] [decimal](19, 4) NOT NULL,
	[ToAmount] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](4, 2) NOT NULL,
	[TaxTableRef] [int] NOT NULL,
	[PartialAmount]  AS (round(([ToAmount]-[FromAmount])*([Rate]/(100)),(0))),
	[InLineAmount] [decimal](19, 4) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.TaxTableItem') and
				[name] = 'ColumnName')
begin
    Alter table PAY.TaxTableItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--


if exists (select 1 from sys.columns where object_id=object_id('PAY.TaxTableItem') and
				[name] = 'PartialAmount')
begin
    Alter table PAY.TaxTableItem Drop column [PartialAmount]
end

go
if not exists (select 1 from sys.columns where object_id=object_id('PAY.TaxTableItem') and
				[name] = 'PartialAmount')
begin
    Alter table PAY.TaxTableItem Add  [PartialAmount] AS (round(([ToAmount]-[FromAmount])*([Rate]/(100)),(0))) 
end
GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_TaxTableItem')
ALTER TABLE [PAY].[TaxTableItem] ADD  CONSTRAINT [PK_TaxTableItem] PRIMARY KEY CLUSTERED 
(
	[TaxTableItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_TaxTableItem_TaxTableRef')
ALTER TABLE [PAY].[TaxTableItem]  ADD  CONSTRAINT [FK_TaxTableItem_TaxTableRef] FOREIGN KEY([TaxTableRef])
REFERENCES [PAY].[TaxTable] ([TaxTableId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
