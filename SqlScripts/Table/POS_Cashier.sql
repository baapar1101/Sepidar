--<<FileName:POS_Cashier.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POS.Cashier') Is Null
CREATE TABLE [POS].[Cashier](
	[CashierID] [int] NOT NULL,
	[Title] nvarchar(500) NOT NULL,
	[PartyRef] [int] NOT NULL,
	[UserRef] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CanChangeDiscount] [bit] NOT NULL,
	[CanReceiveCash] [bit] NOT NULL,
	[CanReceiveCheque] [bit] NOT NULL,
	[CanReceivePos] [bit] NOT NULL,
	[CanReceiveOther] [bit] NOT NULL,
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
if not exists (select 1 from sys.columns where object_id=object_id('POS.Cashier') and
				[name] = 'Title')
begin
    Alter table POS.Cashier Add Title nvarchar(500) Null
end
GO
if exists (select 1 from sys.columns where object_id=object_id('POS.Cashier') and
				[name] = 'Title' and is_nullable = 1)
begin
    Update POS.Cashier set Title = (Select FullName from GNR.vwParty Where PartyRef = PartyID)
	Alter table POS.Cashier Alter COLUMN Title nvarchar(500) NOT NULL
end
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Cashier')
ALTER TABLE [POS].[Cashier] ADD  CONSTRAINT [PK_Cashier] PRIMARY KEY CLUSTERED 
(
	[CashierID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Cashier_PartyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Cashier_PartyRef] ON [POS].[Cashier] 
(
	[PartyRef] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Cashier_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Cashier_Title] ON [POS].[Cashier] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Cashier_UserRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Cashier_UserRef] ON [POS].[Cashier] 
(
	[UserRef] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Cashier_Party_PartyRef')
ALTER TABLE [POS].[Cashier]  ADD  CONSTRAINT [FK_Cashier_Party_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Cashier_User_UserRef')
ALTER TABLE [POS].[Cashier]  ADD  CONSTRAINT [FK_Cashier_User_UserRef] FOREIGN KEY([UserRef])
REFERENCES [FMK].[User] ([UserID])

GO

--<< DROP OBJECTS >>--
