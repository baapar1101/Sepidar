--<<FileName:PAY_Loan.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Loan') Is Null
CREATE TABLE [PAY].[Loan](
	[LoanID] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.Loan') and
				[name] = 'ColumnName')
begin
    Alter table PAY.Loan Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Loan')
ALTER TABLE [PAY].[Loan] ADD  CONSTRAINT [PK_Loan] PRIMARY KEY CLUSTERED 
(
	[LoanID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_Loan_Title')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Loan_Title] ON [PAY].[Loan] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'IX_Loan_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Loan_Title_En] ON [PAY].[Loan] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
