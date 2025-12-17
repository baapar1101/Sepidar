--<<FileName:INV_Stock.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.Stock') Is Null
CREATE TABLE [INV].[Stock](
	[StockID] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[StockClerk] [nvarchar](250) NULL,
	[Phone] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[Address_En] [nvarchar](250) NULL,
	[AccountSLRef] [int] NULL,
	[IsActive] [bit] NOT NULL DEFAULT 1,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.Stock') and
				[name] = 'ColumnName')
begin
    Alter table INV.Stock Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.Stock') AND [Name]='IsActive')
	ALTER TABLE INV.Stock ADD [IsActive] [bit] NOT NULL DEFAULT 1
	
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Stock')
ALTER TABLE [INV].[Stock] ADD  CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_Stock_Title')
ALTER TABLE INV.Stock ADD CONSTRAINT
	IX_Stock_Title UNIQUE NONCLUSTERED 
	(
	Title
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_Stock_Title_En')
ALTER TABLE INV.Stock ADD CONSTRAINT
	IX_Stock_Title_En UNIQUE NONCLUSTERED 
	(
	Title_En
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO


IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_Stock_Code')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Stock_Code] ON [INV].[Stock]
( [Code] ASC )
GO


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Stock_Account')
ALTER TABLE [INV].[Stock]  ADD  CONSTRAINT [FK_Stock_Account] FOREIGN KEY([AccountSLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

--<< DROP OBJECTS >>--
