--<<FileName:RPA_AccountType.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.AccountType') Is Null
CREATE TABLE [RPA].[AccountType](
	[AccountTypeId] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[Type] [int] NOT NULL DEFAULT 0,
	[HasChequeBook] [bit] NOT NULL,
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
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('RPA.AccountType') AND
				[name] = 'Type')
BEGIN
    ALTER TABLE RPA.AccountType ADD [Type] [int] NOT NULL DEFAULT 0
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AcocuntType')
ALTER TABLE [RPA].[AccountType] ADD  CONSTRAINT [PK_AcocuntType] PRIMARY KEY CLUSTERED 
(
	[AccountTypeId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_AccountType_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AccountType_Title] ON [RPA].[AccountType] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_AccountType_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AccountType_Title_En] ON [RPA].[AccountType] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
