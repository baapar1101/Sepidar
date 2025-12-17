--<<FileName:CNT_ContractType.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractType') Is Null
CREATE TABLE [CNT].[ContractType](
	[ContractTypeID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Title_En] [nvarchar](50) NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractType') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractType Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractType')
ALTER TABLE [CNT].[ContractType] ADD  CONSTRAINT [PK_ContractType] PRIMARY KEY CLUSTERED 
(
	[ContractTypeID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
