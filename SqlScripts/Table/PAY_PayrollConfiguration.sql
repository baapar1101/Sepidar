--<<FileName:PAY_PayrollConfiguration.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.PayrollConfiguration') Is Null
CREATE TABLE [PAY].[PayrollConfiguration](
	[PayrollConfigurationId] [int] NOT NULL,
	[TopDailyInsurance] [decimal](19, 4) NULL,
	[EmployeeInsurancePercent] [decimal](19, 4) NULL,
	[EmployerInsurancePercent] [decimal](19, 4) NULL,
	[UnemploymentInsurancePercent] [decimal](19, 4) NULL,
	[HardWorkInsurance] [decimal](19, 4) NULL,
	[SocialSecurityAccountRef] [int] NULL,
	[UnemploymentAccountRef] [int] NULL,
	[PaymentSocialSecurityAccountRef] [int] NULL,
	[NonTaxableSocialSecurityPercent] [decimal](19, 4) NULL,
	[SupportingInsurancePercent] [decimal](19, 4) NULL,
	[PaymentInsuranceAccountRef] [int] NULL,
	[SupportingInsuranceEmployeeElementRef] [int] NULL,
	[SupportingInsuranceEmployerElementRef] [int] NULL,
	[SupportingInsuranceCostAccountRef] [int] NULL,
	[PaymentSupportingInsuranceAccountRef] [int] NULL,
	[TopMonthlyLeave] [int] NULL,
	[TransferYearlyLeave] [int] NULL,
	[LeaveCostAccountRef] [int] NULL,
	[LeaveSavingAccountRef] [int] NULL,
	[TopNewYearBonus] [decimal](19, 4) NULL,
	[NewYearBonusBaseFactor] [decimal](18, 2) NULL,
	[NonTaxableNewYearBonus] [decimal](19, 4) NULL,
	[NonTaxbleBonusRelatedToWorkTime] [bit] NULL,
	[NewYearBonuCostAccountRef] [int] NULL,
	[WorkingHistoryYearlyDay] [int] NULL,
	[WorkingHistorySavingAccountRef] [int] NULL,
	[WorkingHistoryCostAccountRef] [int] NULL,	
	[PaymentRound] [int] NULL,
	[PaymentAccountRef] [int] NULL,
	[PaymentRoundAccountRef] [int] NULL,
    [EmployeesCurrentAccountRef] [int] NULL,
    [CalculateNegativeTax] [Bit] Not Null DEFAULT 0,
    [ShowAvailableLeaveInFish] [Bit] Not Null DEFAULT 1,
	[HealthInsurancePercent] [decimal](19, 4) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.PayrollConfiguration') and
				[name] = 'ColumnName')
begin
    Alter table PAY.PayrollConfiguration Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('PAY.PayrollConfiguration') and
				[name] = 'EmployeesCurrentAccountRef')
BEGIN
	ALTER TABLE PAY.PayrollConfiguration ADD [EmployeesCurrentAccountRef] [int] NULL
END
Go
if not exists (select 1 from sys.columns where object_id=object_id('PAY.PayrollConfiguration') and
				[name] = 'LoanAccountRef')
BEGIN
	ALTER TABLE PAY.PayrollConfiguration ADD [LoanAccountRef] [int] NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('PAY.PayrollConfiguration') AND
				[NAME] = 'ShowAvailableLeaveInPayFish')
BEGIN
	ALTER TABLE PAY.PayrollConfiguration ADD [ShowAvailableLeaveInPayFish] [Bit] Not Null DEFAULT 1 With Values
END
Go
-------------------------
if not exists (select 1 from sys.columns where object_id=object_id('PAY.PayrollConfiguration') and
				[name] = 'CalculateNegativeTax')
BEGIN
	ALTER TABLE PAY.PayrollConfiguration ADD [CalculateNegativeTax] [Bit] NULL	
END
Go

if not exists (select 1 from  [PAY].[PayrollConfiguration] where [CalculateNegativeTax] is null)
BEGIN
	Update PAY.PayrollConfiguration SET [CalculateNegativeTax] = 0	
	ALTER TABLE PAY.PayrollConfiguration ALTER COLUMN [CalculateNegativeTax] bit NOT NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('PAY.PayrollConfiguration') AND
				[name] = 'UnemploymentAccountRef')
BEGIN
	ALTER TABLE PAY.PayrollConfiguration ADD [UnemploymentAccountRef] [int] NULL	
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('PAY.PayrollConfiguration') and
				[name] = 'HealthInsurancePercent')
BEGIN
	ALTER TABLE PAY.PayrollConfiguration ADD [HealthInsurancePercent] [decimal](19, 4) NULL
END
Go

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PayrollConfiguration')
ALTER TABLE [PAY].[PayrollConfiguration] ADD  CONSTRAINT [PK_PayrollConfiguration] PRIMARY KEY CLUSTERED 
(
	[PayrollConfigurationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_LeaveCostAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_LeaveCostAccountRef] FOREIGN KEY([LeaveCostAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_LeaveSavingAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_LeaveSavingAccountRef] FOREIGN KEY([LeaveSavingAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_NewYearBonusCostAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_NewYearBonusCostAccountRef] FOREIGN KEY([NewYearBonuCostAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_PaymentAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_PaymentAccountRef] FOREIGN KEY([PaymentAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_PaymentInsuraneAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_PaymentInsuraneAccountRef] FOREIGN KEY([PaymentInsuranceAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_PaymentRoundAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_PaymentRoundAccountRef] FOREIGN KEY([PaymentRoundAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_PaymentSocialSecurityAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_PaymentSocialSecurityAccountRef] FOREIGN KEY([PaymentSocialSecurityAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_PaymentSuppotingInAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_PaymentSuppotingInAccountRef] FOREIGN KEY([PaymentSupportingInsuranceAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_SocialSecurityAccount')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_SocialSecurityAccount] FOREIGN KEY([SocialSecurityAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_WorkingCostAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_WorkingCostAccountRef] FOREIGN KEY([WorkingHistoryCostAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_WorkingSavingAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_WorkingSavingAccountRef] FOREIGN KEY([WorkingHistorySavingAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_EmployeesCurrentAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_EmployeesCurrentAccountRef] FOREIGN KEY([EmployeesCurrentAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfiguration_LoanAccountRef')
ALTER TABLE [PAY].[PayrollConfiguration]  ADD  CONSTRAINT [FK_PayrollConfiguration_LoanAccountRef] FOREIGN KEY([LoanAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

--<< DROP OBJECTS >>--