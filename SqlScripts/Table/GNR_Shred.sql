--<<FileName:GNR_Shred.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Shred') Is Null
CREATE TABLE [GNR].[Shred](
	[ShredID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Key] [int] NOT NULL,
	[TargetRef] [int] NOT NULL,
	[DLRef] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[InterestAmount] [decimal](19, 4) NULL,
	[TotalAmount] [decimal](19, 4) NOT NULL,
	[RemainedAmount] [decimal](19, 4) NOT NULL,
	[PenaltyRate] [decimal](19, 4) NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[InterestAccountSLRef] [int] NULL,
	[PenaltyAccountSLRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.Shred') and
				[name] = 'ColumnName')
begin
    Alter table GNR.Shred Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('GNR.Shred') 
	and [name] = 'Target')
		Alter table GNR.Shred DROP Column [Target]
Go

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Shred') 
	and [name] = 'CurrencyRef')
		Alter table GNR.Shred Add [CurrencyRef] [int] NULL
Go

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Shred') 
	and [name] = 'RPType')
		Alter table GNR.Shred Add [RPType] [int] NULL
Go

if exists (select 1 from sys.columns where object_id=object_id('GNR.Shred') 
	and [name] = 'CurrencyRef')		
	Begin
		UPDATE GNR.Shred
		SET CurrencyRef = 1
		WHERE CurrencyRef IS NULL
			
		ALTER TABLE GNR.Shred ALTER COLUMN [CurrencyRef] [int] NOT NULL
	End
Go

if exists (select 1 from sys.columns where object_id=object_id('GNR.Shred') 
	and [name] = 'RPType')		
	Begin
		UPDATE GNR.Shred
		SET RPType = 
			CASE WHEN [Key] = 1 Then 0
				 WHEN [Key] = 2 Then 1
				 WHEN [Key] = 3 Then 1
				 WHEN [Key] = 4 Then 0
				 WHEN [Key] = 5 Then 1
			END
		WHERE RPType IS NULL
			
		ALTER TABLE GNR.Shred ALTER COLUMN [RPType] [int] NOT NULL
	End
Go

IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Shred') 
				AND [name] = 'InterestAccountSLRef')
		ALTER TABLE GNR.Shred ADD [InterestAccountSLRef] [int] NULL
Go

IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Shred') 
				AND [name] = 'PenaltyAccountSLRef')
		ALTER TABLE GNR.Shred ADD [PenaltyAccountSLRef] [int] NULL
Go

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Shredable')
ALTER TABLE [GNR].[Shred] ADD  CONSTRAINT [PK_Shredable] PRIMARY KEY CLUSTERED 
(
	[ShredID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Shred_DLRef')
ALTER TABLE [GNR].[Shred]  ADD  CONSTRAINT [FK_Shred_DLRef] FOREIGN KEY([DLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Shred_Currency')
ALTER TABLE [GNR].[Shred]  WITH CHECK ADD  CONSTRAINT [FK_Shred_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])
GO

--<< DROP OBJECTS >>--
