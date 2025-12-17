--<<FileName:PAY_Personnel.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Personnel') Is Null
CREATE TABLE [PAY].[Personnel](
	[PersonnelId] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[BirthIdentity] [nvarchar](250) NULL,
	[BirthSerial] [nvarchar](250) NULL,
	[BirthLocationRef] [int] NULL,
	[FatherName] [nvarchar](250) NULL,
	[Nationality] [int] NOT NULL,
	[MarriageStatus] [int] NOT NULL,
	[StatusDate] [datetime] NULL,
	[Children] [int] NULL,
	[FamilyCount] [int] NULL,
	[EducationDegree] [int] NOT NULL,
	[EducationField] [nvarchar](250) NULL,
	[InsuranceNumber] [varchar](50) NULL,
	[SupportInsuranceNumber] [varchar](50) NULL,
	[InsuranceDay] [int] NULL,
	[MilitaryStatus] [int] NOT NULL,
	[BankRef] [int]  NULL,
	[BankBranchRef] [int] NULL,
	[AccountTypeRef] [int] NULL,
	[AccountNo] [nvarchar](250) NULL,
	[Sex] [int] NOT NULL ,
	[EmployeeStatus] [int] NOT NULL DEFAULT(1) /*EmployeeStatus.Normal ÚÇÏí*/,	
	[ReferenceNumber] [nvarchar](250) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
--<< ALTER COLUMNS >>--

Alter Table [PAY].[Personnel] Alter Column [InsuranceNumber] [varchar](50) null
go
Alter Table [PAY].[Personnel] Alter Column [SupportInsuranceNumber] [varchar](50) null
go
Alter Table [PAY].[Personnel] Alter Column [BankRef] [int] NULL
go
Alter Table [PAY].[Personnel] Alter Column [BankBranchRef] [int] NULL
go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('PAY.Personnel') AND
				[name] = 'EmployeeStatus')
BEGIN
    ALTER TABLE [PAY].[Personnel] Add [EmployeeStatus] [int] NOT NULL DEFAULT(1) /*EmployeeStatus.Normal ÚÇÏí*/ WITH VALUES
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('PAY.Personnel') AND
				[name] = 'ReferenceNumber')
BEGIN
    ALTER TABLE [PAY].[Personnel] Add [ReferenceNumber] [nvarchar](250) NULL
end
GO
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Personnel')
ALTER TABLE [PAY].[Personnel] ADD  CONSTRAINT [PK_Personnel] PRIMARY KEY CLUSTERED 
(
	[PersonnelId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Personnel_AccountTypeRef')
ALTER TABLE [PAY].[Personnel]  ADD  CONSTRAINT [FK_Personnel_AccountTypeRef] FOREIGN KEY([AccountTypeRef])
REFERENCES [RPA].[AccountType] ([AccountTypeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Personnel_BankBranchRef')
ALTER TABLE [PAY].[Personnel]  ADD  CONSTRAINT [FK_Personnel_BankBranchRef] FOREIGN KEY([BankBranchRef])
REFERENCES [RPA].[BankBranch] ([BankBranchId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Personnel_BankRef')
ALTER TABLE [PAY].[Personnel]  ADD  CONSTRAINT [FK_Personnel_BankRef] FOREIGN KEY([BankRef])
REFERENCES [RPA].[Bank] ([BankId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Personnel_LocationRef')
ALTER TABLE [PAY].[Personnel]  ADD  CONSTRAINT [FK_Personnel_LocationRef] FOREIGN KEY([BirthLocationRef])
REFERENCES [GNR].[Location] ([LocationId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Personnel_PartyRef')
ALTER TABLE [PAY].[Personnel]  ADD  CONSTRAINT [FK_Personnel_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--