--<<FileName:CNT_ContractSupportingInsurance.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractSupportingInsurance') Is Null
CREATE TABLE [CNT].[ContractSupportingInsurance](
	[ContractSupportingInsuranceID] [int] NOT NULL,
	[ContractRef] [int] NOT NULL,
	[RowNumber] [int] Not NULL,
	[BranchCode] [int] NOT NULL,
	[BranchTitle] [nvarchar](50) NOT NULL,
	[BranchTitle_En] [nvarchar](50) NOT NULL,
	[WorkshopCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractSupportingInsurance') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractSupportingInsurance Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractSupportingInsurance')
ALTER TABLE [CNT].[ContractSupportingInsurance] ADD  CONSTRAINT [PK_ContractSupportingInsurance] PRIMARY KEY CLUSTERED 
(
	[ContractSupportingInsuranceID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_ContractSupportingInsurance_Contract')
ALTER TABLE [CNT].[ContractSupportingInsurance]  ADD  CONSTRAINT [FK_ContractSupportingInsurance_Contract] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
