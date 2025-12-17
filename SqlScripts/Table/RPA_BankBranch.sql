--<<FileName:RPA_BankBranch.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.BankBranch') Is Null
CREATE TABLE [RPA].[BankBranch](
	[BankBranchId] [int] NOT NULL,
	[BankRef] [int] NOT NULL,
	[Code] [nvarchar](250) NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[LocationRef] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankBranch') and
				[name] = 'ColumnName')
begin
    Alter table RPA.BankBranch Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('RPA.BankBranch') and
				[name] = 'LocationRef' and is_Nullable = 0)
begin
    Alter table RPA.BankBranch Alter Column LocationRef int Null
end
GO

UPDATE Rpa.BankBranch SET Title_En = Title WHERE Title_En IS NULL

GO

ALTER TABLE Rpa.BankBranch ALTER COLUMN [Title_En] [nvarchar](250) NOT NULL 
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_BankBranch')
ALTER TABLE [RPA].[BankBranch] ADD  CONSTRAINT [PK_BankBranch] PRIMARY KEY CLUSTERED 
(
	[BankBranchId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If Exists (select 1 from sys.indexes where name = 'UIX_BankBranch_BankRef_Code')
BEGIN
	DROP INDEX [UIX_BankBranch_BankRef_Code] ON [RPA].[BankBranch];
END

ALTER TABLE RPA.BankBranch ALTER COLUMN Code [nvarchar](250) Null

If not Exists (select 1 from sys.indexes where name = 'UIX_BankBranch_BankRef_Code')
BEGIN
	CREATE UNIQUE NONCLUSTERED INDEX [UIX_BankBranch_BankRef_Code] ON [RPA].[BankBranch] 
	(
		[BankRef] ASC,
		[Code] ASC
	) ON [PRIMARY]

END

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BankBranch_BankRef')
ALTER TABLE [RPA].[BankBranch]  ADD  CONSTRAINT [FK_BankBranch_BankRef] FOREIGN KEY([BankRef])
REFERENCES [RPA].[Bank] ([BankId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_BankBranch_LocationRef')
ALTER TABLE [RPA].[BankBranch]  ADD  CONSTRAINT [FK_BankBranch_LocationRef] FOREIGN KEY([LocationRef])
REFERENCES [GNR].[Location] ([LocationId])

GO

--<< DROP OBJECTS >>--

If  Exists (select 1 from sys.indexes where name = 'UIX_BankBranch_BankRef_Title')
DROP  INDEX [RPA].[BankBranch].[UIX_BankBranch_BankRef_Title] 

GO

If  Exists (select 1 from sys.indexes where name = 'UIX_BankBranch_BankRef_Title_En')
DROP  INDEX [RPA].[BankBranch].[UIX_BankBranch_BankRef_Title_En] 

GO


