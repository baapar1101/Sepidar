--<<FileName:PAY_PersonnelInitiate.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.PersonnelInitiate') Is Null
CREATE TABLE [PAY].[PersonnelInitiate](
	[PersonnelInitiateId] [int] NOT NULL,
	[PersonnelRef] [int] NOT NULL,
	[Date] [datetime] NULL,
	[SumYearlyWorkingTimeDay] [int] NULL,	
	[SumYearlyTaxableIncome] [decimal](19, 4) NULL,
	[SumYearlyTax] [decimal](19, 4) NULL,
	[WorkHistoryDay] [int] NULL,
	[WorkHistorySaving] [decimal](19, 4) NULL,
	[LeaveRemain] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[PaymentRound] [decimal](19, 4) NULL,
	[BaseDate] [datetime] NULL,
	[NewyearBonusWorkingTime] [int] NULL,
	[NewyearBonusSaving] [decimal](19, 4) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.PersonnelInitiate') and
				[name] = 'ColumnName')
begin
    Alter table PAY.PersonnelInitiate Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PersonnelInitial')
ALTER TABLE [PAY].[PersonnelInitiate] ADD  CONSTRAINT [PK_PersonnelInitial] PRIMARY KEY CLUSTERED 
(
	[PersonnelInitiateId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_PersonnelInitiate_Date')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_PersonnelInitiate_Date] ON [PAY].[PersonnelInitiate] 
(
	[Date] ASC,
	[PersonnelRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PersonnelInitial_PersonnelRef')
ALTER TABLE [PAY].[PersonnelInitiate]  ADD  CONSTRAINT [FK_PersonnelInitial_PersonnelRef] FOREIGN KEY([PersonnelRef])
REFERENCES [PAY].[Personnel] ([PersonnelId])

GO

--<< DROP OBJECTS >>--
