--<<FileName:PAY_ContractElement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.ContractElement') Is Null
CREATE TABLE [PAY].[ContractElement](
	[ContractElementId] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[ElementRef] [int] NOT NULL,
	[Value] [decimal](19, 4) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.ContractElement') and
				[name] = 'ColumnName')
begin
    Alter table PAY.ContractElement Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractElement')
ALTER TABLE [PAY].[ContractElement] ADD  CONSTRAINT [PK_ContractElement] PRIMARY KEY CLUSTERED 
(
	[ContractElementId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractElement_ContractRef')
ALTER TABLE [PAY].[ContractElement]  ADD  CONSTRAINT [FK_ContractElement_ContractRef] FOREIGN KEY([ContractRef])
REFERENCES [PAY].[Contract] ([ContractId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ContractElement_ElementRef')
ALTER TABLE [PAY].[ContractElement]  ADD  CONSTRAINT [FK_ContractElement_ElementRef] FOREIGN KEY([ElementRef])
REFERENCES [PAY].[Element] ([ElementId])

GO

--<< DROP OBJECTS >>--
