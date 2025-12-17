--<<FileName:PAY_Contract.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Contract') Is Null
CREATE TABLE [PAY].[Contract](
	[ContractId] [int] NOT NULL,
	[PersonnelRef] [int] NOT NULL,
	[WorkSiteRef] [int] NOT NULL,
	[CostCenterRef] [int] NOT NULL,
	[CostCenterDlRef] [int]  NULL,
	[JobRef] [int] NOT NULL,
	[TaxGroupRef] [int] NOT NULL,
	[TaxBranchRef] [int] NOT NULL,
	[InsuranceBranchRef] [int] NULL,
	[SupportingInsuranceBranchRef] [int] NULL,
	[ContractType] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[IssueDate] [datetime] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[EmploymentDate] [datetime] NOT NULL,
	[EmploymentType] [int] NOT NULL,
	[NonTaxableAmount] [decimal](19, 4) NULL,
	[HasInsurance] [bit] NOT NULL,
	[HasSupportingInsurance] [bit] NOT NULL,
	[HasHardJob] [bit] NOT NULL,
	[Description] nvarchar(4000) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[HasUnemploymentException] bit NOT NULL,
    [HasUnemployeeException] bit NOT NULL,
	[EmployerInsuranceExceptionPercent] INT NOT NULL DEFAULT 100,
	[TaxDiscountType] INT NULL,
	[SupportingInsuranceName] nvarchar(500) NULL,
	[PiofyEmploymentType] INT NULL,
	[IsEmployer] bit NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('PAY.CONTRACT') AND
				[NAME] = 'TaxDiscountType')
BEGIN
    ALTER TABLE PAY.[CONTRACT] ADD [TaxDiscountType] INT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('PAY.CONTRACT') AND
				[NAME] = 'EmployerInsuranceExceptionPercent')
BEGIN
    ALTER TABLE PAY.[CONTRACT] ADD [EmployerInsuranceExceptionPercent] INT NOT NULL DEFAULT 100 WITH VALUES
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('PAY.CONTRACT') AND
				[NAME] = 'CostCenterDlRef')
BEGIN
    ALTER TABLE PAY.[CONTRACT] ADD [CostCenterDlRef] INT 
END
GO
IF  EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('PAY.CONTRACT') AND
				[NAME] = 'CostCenterRef')
BEGIN
    ALTER TABLE PAY.[CONTRACT] ALTER COLUMN [CostCenterRef] INT  Null
END
GO
IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('PAY.CONTRACT') AND
				[NAME] = 'PiofyEmploymentType')
BEGIN
    ALTER TABLE PAY.[CONTRACT] ADD [PiofyEmploymentType] INT NULL 
END
GO

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('PAY.CONTRACT') AND
				[NAME] = 'IsEmployer')
BEGIN
    ALTER TABLE PAY.[CONTRACT] ADD [IsEmployer] bit NOT NULL DEFAULT(0)
END
GO
--<<Sample>>--


--Description
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Pay.Contract') AND [name]='Description')
BEGIN
	ALTER TABLE PAY.Contract ADD [Description] nvarchar(4000) NULL
END
Go
--HasEmployerInsuranceException
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Pay.Contract') AND [name]='HasEmployerInsuranceException')
BEGIN
	ALTER TABLE PAY.Contract ADD [HasEmployerInsuranceException] bit NULL
END
GO

--HasUnemploymentException
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Pay.Contract') AND [name]='HasUnemploymentException')
BEGIN
	ALTER TABLE PAY.Contract ADD [HasUnemploymentException] bit NULL
END
GO

--HasUnemployeeException
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Pay.Contract') AND [name]='HasUnemployeeException')
BEGIN
	ALTER TABLE PAY.Contract ADD [HasUnemployeeException] bit NOT NULL DEFAULT 0
END
GO

--SupportingInsuranceName
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('Pay.Contract') AND [name]='SupportingInsuranceName')
BEGIN
	ALTER TABLE PAY.[Contract] ADD [SupportingInsuranceName] NVARCHAR(500) NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Pay.Contract') AND [name]='HasEmployerInsuranceException')
BEGIN
	UPDATE PAY.Contract SET [HasEmployerInsuranceException] = 0 WHERE HasEmployerInsuranceException IS NULL
	ALTER TABLE PAY.Contract ALTER COLUMN [HasEmployerInsuranceException] bit NOT NULL
END
Go
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('Pay.Contract') AND [name]='HasUnemploymentException')
BEGIN
	UPDATE PAY.Contract SET [HasUnemploymentException] = 0 WHERE HasUnemploymentException IS NULL
	ALTER TABLE PAY.Contract ALTER COLUMN [HasUnemploymentException] bit NOT NULL
END
Go
--<< ALTER COLUMNS >>--

IF exists (select 1 from sys.columns where object_id=object_id('PAY.Contract') and [name]='NonTaxableAmount' and is_nullable=0)
BEGIN
	ALTER TABLE PAY.Contract ALTER COLUMN NonTaxableAmount [decimal](19, 4) NULL
END
Go
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Contract')
ALTER TABLE [PAY].[Contract] ADD  CONSTRAINT [PK_Contract] PRIMARY KEY CLUSTERED 
(
	[ContractId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (select 1 from sys.indexes where name = 'IX_Contract_EndDate_PersonnelRef')
CREATE NONCLUSTERED INDEX [IX_Contract_EndDate_PersonnelRef] ON [PAY].[Contract] 
(
	EndDate
) 
INCLUDE (PersonnelRef)
ON [PRIMARY]
GO
IF NOT EXISTS (select 1 from sys.indexes where name = 'IX_Contract_IssueDate_PersonnelRef')
CREATE NONCLUSTERED INDEX [IX_Contract_IssueDate_PersonnelRef] ON [PAY].[Contract] 
(
	IssueDate
) 
INCLUDE (PersonnelRef)
ON [PRIMARY]
GO
IF NOT EXISTS (select 1 from sys.indexes where name = 'IX_Contract_PersonnelRef')
CREATE NONCLUSTERED INDEX [IX_Contract_PersonnelRef] ON [PAY].[Contract] 
(
	PersonnelRef
) 
ON [PRIMARY]
GO
IF NOT EXISTS (select 1 from sys.indexes where name = 'IX_Contract_TaxBranchRef')
CREATE NONCLUSTERED INDEX [IX_Contract_TaxBranchRef] ON [PAY].[Contract] 
(
	TaxBranchRef
) 
ON [PRIMARY]
Go
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Contract_CostCenterDlRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_CostCenterDlRef] FOREIGN KEY([CostCenterDlRef])
REFERENCES [ACC].[DL]([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_InsuranceBranchRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_InsuranceBranchRef] FOREIGN KEY([InsuranceBranchRef])
REFERENCES [PAY].[Branch] ([BranchId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_JobRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_JobRef] FOREIGN KEY([JobRef])
REFERENCES [PAY].[Job] ([JobId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_PersonnelRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_PersonnelRef] FOREIGN KEY([PersonnelRef])
REFERENCES [PAY].[Personnel] ([PersonnelId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_SupportingInsuranceBranchRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_SupportingInsuranceBranchRef] FOREIGN KEY([SupportingInsuranceBranchRef])
REFERENCES [PAY].[Branch] ([BranchId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_TaxBranchRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_TaxBranchRef] FOREIGN KEY([TaxBranchRef])
REFERENCES [PAY].[Branch] ([BranchId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_TaxGroupRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_TaxGroupRef] FOREIGN KEY([TaxGroupRef])
REFERENCES [PAY].[TaxGroup] ([TaxGroupId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Contract_WorksiteRef')
ALTER TABLE [PAY].[Contract]  ADD  CONSTRAINT [FK_Contract_WorksiteRef] FOREIGN KEY([WorkSiteRef])
REFERENCES [PAY].[Worksite] ([WorksiteId])

GO

--<< DROP OBJECTS >>--
