--<<FileName:CNT_ContractCoefficientItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractCoefficientItem') Is Null
CREATE TABLE [CNT].[ContractCoefficientItem](
	[ContractCoefficientID] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[CoefficientRef] [int] NOT NULL,
	[ContractRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractCoefficientItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractCoefficientItem Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractCoefficientItem') and
				[name] = 'Percent')
begin
    Alter table CNT.ContractCoefficientItem Add [Percent] Real  null
end
GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.ContractCoefficientItem') and
				[name] = 'Percent')
begin
    Update CNT.ContractCoefficientItem set [Percent] = 0 WHERE   [Percent] is null
end
GO

if exists (select 1 from sys.columns where object_id=object_id('CNT.ContractCoefficientItem') and
				[name] = 'Percent')
begin
    ALTER TABLE CNT.ContractCoefficientItem ALTER COLUMN [Percent] Real not null
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractCoefficient')
ALTER TABLE [CNT].[ContractCoefficientItem] ADD  CONSTRAINT [PK_ContractCoefficient] PRIMARY KEY CLUSTERED 
(
	[ContractCoefficientID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractCoefficient_Contract')
ALTER TABLE [CNT].[ContractCoefficientItem]  ADD  CONSTRAINT [FK_ContractCoefficient_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractCoefficientItem_Coefficient')
ALTER TABLE [CNT].[ContractCoefficientItem]  ADD  CONSTRAINT [FK_ContractCoefficientItem_Coefficient] FOREIGN KEY([CoefficientRef])
REFERENCES [CNT].[Coefficient] ([CoefficientID])

GO

--<< DROP OBJECTS >>--
