--<<FileName:ACC_Account.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.Account') Is Null
CREATE TABLE [ACC].[Account](
	[AccountId] [int] NOT NULL,
	[ParentAccountRef] [int] NULL,
	[Type] [int] NOT NULL,
	[Code] [varchar](40) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CashFlowCategory] [int] NULL,
	[OpeningBalance] [decimal](19, 4) NULL,
	[BalanceType] [int] NOT NULL,
	[HasBalanceTypeCheck] [bit] NOT NULL,
	[HasDL] [bit] NOT NULL,
	[HasCurrency] [bit] NOT NULL,
	[HasCurrencyConversion] [bit] NOT NULL,
	[HasTracking] [bit] NOT NULL,
	[HasTrackingCheck] [bit] NOT NULL,
	[ShowInCompanyDashboard] [bit] NOT NULL DEFAULT 0,
	[ShowInAccountAnalysisReport] [bit] NOT NULL DEFAULT 0,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('ACC.Account') and
				[name] = 'ColumnName')
begin
    Alter table ACC.Account Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('ACC.Account') and
				[name] = 'ShowInCompanyDashboard')
BEGIN
    ALTER TABLE ACC.Account ADD ShowInCompanyDashboard BIT NOT NULL DEFAULT 0 
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('ACC.Account') and
				[name] = 'ShowInAccountAnalysisReport')
BEGIN
    ALTER TABLE ACC.Account ADD ShowInAccountAnalysisReport BIT NOT NULL DEFAULT 0 
END
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Account')
ALTER TABLE [ACC].[Account] ADD  CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Account_Code_ParentAccountRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Account_Code_ParentAccountRef] ON [ACC].[Account] 
(
	[Code] ASC,
	[ParentAccountRef] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Account_Title_ParentAccountRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Account_Title_ParentAccountRef] ON [ACC].[Account] 
(
	[Title] ASC,
	[ParentAccountRef] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Account_TitleEn_ParentAccountRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Account_TitleEn_ParentAccountRef] ON [ACC].[Account] 
(
	[Title_En] ASC,
	[ParentAccountRef] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Account_ParentAccountRef')
ALTER TABLE [ACC].[Account]  ADD  CONSTRAINT [FK_Account_ParentAccountRef] FOREIGN KEY([ParentAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

--<< DROP OBJECTS >>--
