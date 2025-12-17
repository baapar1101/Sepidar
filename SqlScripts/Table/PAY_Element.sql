--<<FileName:PAY_Element.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Element') Is Null
CREATE TABLE [PAY].[Element](
	[ElementId] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Title_En] [nvarchar](255) NOT NULL,
	[Class] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[NormalType] [int] NOT NULL,
	[AccountRef] [int] NULL,
	[DlType] [int] NOT NULL,
	[InsuranceCoverage] [bit] NULL,
	[Taxable] [bit] NULL,
	[UnrelatedToWorkingTime] [bit] NULL,
	[CalculateForMinWorkingTime] [bit] NULL,
	[CalculateForMinBase] [int] NULL,
	[Coefficient] [decimal](19, 4) NULL,
	[FixPoint] [decimal](19, 4) NULL,
	[DenominatorsType] [int] NULL,
	[Denominators] [decimal](19, 4) NULL,
	[SavingRemainder] [bit] NULL,
	[IsActive] [bit] NULL,
	[DisplayOrder] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[PaymentAccountRef] [int] NULL,
	[PaymentDlType] [int] NULL,
	[ElementTaxType] [int] NOT NULL,

) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('PAY.Element') and
				[name] = 'PaymentAccountRef')
begin
    Alter table PAY.Element Add [PaymentAccountRef] [int] NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('PAY.Element') and
				[name] = 'ElementTaxType')
begin
    Alter table PAY.Element Add [ElementTaxType] [int] NOT NULL DEFAULT 0
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('PAY.Element') and
				[name] = 'PaymentDlType')
begin
    Alter table PAY.Element Add [PaymentDlType] [int] NULL
end
GO

--<< ALTER COLUMNS >>--

 Alter table PAY.Element ALTER Column [PaymentDlType] [int] NULL
 
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Element')
ALTER TABLE [PAY].[Element] ADD  CONSTRAINT [PK_Element] PRIMARY KEY CLUSTERED 
(
	[ElementId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If Exists (select 1 from sys.indexes where name = 'UIX_Element_Title')
	DROP INDEX Pay.ELement.[UIX_Element_Title]
GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Element_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Element_Title] ON [PAY].[Element] 
(
	[Title] ASC
) INCLUDE (ElementId) ON [PRIMARY] 
GO

If Exists (select 1 from sys.indexes where name = 'UIX_Element_Title_En')
	DROP INDEX Pay.ELement.[UIX_Element_Title_En]
GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Element_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Element_Title_En] ON [PAY].[Element] 
(
	[Title_En] ASC
) INCLUDE (ElementId) ON [PRIMARY] 
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Element_AccountRef')
ALTER TABLE [PAY].[Element]  ADD  CONSTRAINT [FK_Element_AccountRef] FOREIGN KEY([AccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Element_PaymentAccountRef')
ALTER TABLE [PAY].[Element]  ADD  CONSTRAINT [FK_Element_PaymentAccountRef] FOREIGN KEY([PaymentAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
--<< DROP OBJECTS >>--
