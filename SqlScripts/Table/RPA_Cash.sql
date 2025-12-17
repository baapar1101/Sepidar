--<<FileName:RPA_Cash.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.Cash') Is Null
CREATE TABLE [RPA].[Cash](
	[CashId] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[DlRef] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[FirstAmount] [decimal](19, 4) NOT NULL,
	[FirstDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[Balance] [decimal](19, 4) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--remove IsActive
if exists (select 1 from sys.columns where object_id=object_id('RPA.Cash') and
				[name] = 'IsActive')
begin
    Alter table RPA.Cash Drop column [IsActive]
end
GO

--<< ALTER COLUMNS >>--

Alter table RPA.Cash Alter column Rate decimal(26, 16) not null
GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Cash')
ALTER TABLE [RPA].[Cash] ADD  CONSTRAINT [PK_Cash] PRIMARY KEY CLUSTERED 
(
	[CashId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Cash_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Cash_Title] ON [RPA].[Cash] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Cash_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Cash_Title_En] ON [RPA].[Cash] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Cash_CurrencyRef')
ALTER TABLE [RPA].[Cash]  ADD  CONSTRAINT [FK_Cash_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Cash_DlRef')
ALTER TABLE [RPA].[Cash]  ADD  CONSTRAINT [FK_Cash_DlRef] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO

--<< DROP OBJECTS >>--
