--<<FileName:RPA_ChequeBook.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ChequeBook') Is Null
CREATE TABLE [RPA].[ChequeBook](
	[ChequeBookId] [int] NOT NULL,
	[BankAccountRef] [int] NOT NULL,
	[beginNumber] [nvarchar](30) NOT NULL,
	[Count] [int] NOT NULL,
	[PrintFormat] [nvarchar](4000) NULL,
	[Series] [nvarchar](50) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ChequeBook') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ChequeBook Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
Alter table RPA.ChequeBook  Alter column [PrintFormat] [nvarchar](4000) NULL
Go

if Exists (select * from sys.indexes where name = 'UIX_ChequeBook_BeginNumber')
	DROP INDEX UIX_ChequeBook_BeginNumber ON [RPA].[ChequeBook] 
GO
ALTER TABLE RPA.ChequeBook	ALTER COLUMN [BeginNumber] [NVARCHAR](30) NULL
Go
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ChequeBook_BeginNumber] ON [RPA].[ChequeBook] 
(
	[BankAccountRef] ASC,
	[beginNumber] ASC,
	[Series] ASC	
) ON [PRIMARY]
Go
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ChequeBook')
ALTER TABLE [RPA].[ChequeBook] ADD  CONSTRAINT [PK_ChequeBook] PRIMARY KEY CLUSTERED 
(
	[ChequeBookId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF Exists (select 1 from sys.indexes where name = 'UIX_ChequeBook_BeginNumber')
DROP INDEX [UIX_ChequeBook_BeginNumber] ON [RPA].[ChequeBook] 
GO
If not Exists (select 1 from sys.indexes where name = 'UIX_ChequeBook_BeginNumber')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ChequeBook_BeginNumber] ON [RPA].[ChequeBook] 
(
	[BankAccountRef] ASC,
	[beginNumber] ASC,
	[Series] ASC	
) ON [PRIMARY]

GO
--GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ChequeBook_BankAccountRef')
ALTER TABLE [RPA].[ChequeBook]  ADD  CONSTRAINT [FK_ChequeBook_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO



--<< DROP OBJECTS >>--
