--<<FileName:RPA_Bank.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.Bank') Is Null
CREATE TABLE [RPA].[Bank](
	[BankId] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[TaxFileCode] [nvarchar](50) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.Bank') and
				[name] = 'ColumnName')
begin
    Alter table RPA.Bank Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns where OBJECT_ID = OBJECT_ID('RPA.Bank') AND
				[name] = 'TaxFileCode')
BEGIN
    ALTER TABLE RPA.Bank ADD TaxFileCode [nvarchar](50)
END
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Bank')
ALTER TABLE [RPA].[Bank] ADD  CONSTRAINT [PK_Bank] PRIMARY KEY CLUSTERED 
(
	[BankId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Bank_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Bank_Title] ON [RPA].[Bank] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Bank_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Bank_Title_En] ON [RPA].[Bank] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
