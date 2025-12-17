--<<FileName:RPA_Pos.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.Pos') Is Null
CREATE TABLE [RPA].[Pos](
	[PosId] [int] NOT NULL,
	[BankAccountRef] [int] NOT NULL,
	[TerminalNo] [nvarchar](40) NOT NULL,
	[DlRef] [int] NOT NULL,
	[FirstAmount] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16) NULL,
	[IsActive] [bit] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
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
if exists (select 1 from sys.columns where object_id=object_id('RPA.Pos') and
				[name] = 'IsActive')
begin
    Alter table RPA.Pos Drop column [IsActive]
end
GO


--<< ALTER COLUMNS >>--

Alter table RPA.Pos Alter column rate decimal(26, 16) 

GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Pos')
ALTER TABLE [RPA].[Pos] ADD  CONSTRAINT [PK_Pos] PRIMARY KEY CLUSTERED 
(
	[PosId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Pos_BankAccountRef_TerminalNo')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Pos_BankAccountRef_TerminalNo] ON [RPA].[Pos] 
(
	[BankAccountRef] ASC,
	[TerminalNo] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Pos_BankAccountRef')
ALTER TABLE [RPA].[Pos]  ADD  CONSTRAINT [FK_Pos_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Pos_Currency')
ALTER TABLE [RPA].[Pos]  ADD  CONSTRAINT [FK_Pos_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Pos_DlRef')
ALTER TABLE [RPA].[Pos]  ADD  CONSTRAINT [FK_Pos_DlRef] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO

--<< DROP OBJECTS >>--
