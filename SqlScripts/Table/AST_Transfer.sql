--<<FileName:AST_Transfer.sql>>--
--<< TABLE DEFINITION >>--

IF (Object_ID('AST.Transfer') Is Null)
BEGIN

CREATE TABLE [AST].[Transfer](
	[TransferID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Description_En] [nvarchar](255) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [DateTime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [DateTime] NOT NULL,
) ON [PRIMARY]
END


--<< ADD CLOLUMNS >>--

--<<Sample>>--


--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_Transfer')
ALTER TABLE [AST].[Transfer] ADD  CONSTRAINT [PK_Transfer] PRIMARY KEY CLUSTERED 
(
	[TransferId] ASC
) ON [PRIMARY]
GO

--<< ALTER COLUMNS >>--

if NOT exists (select 1 from sys.objects where name =N'FK_AST_Transfer_FiscalYearRef')
BEGIN        
    ALTER TABLE [AST].[Transfer]
    ADD CONSTRAINT [FK_AST_Transfer_FiscalYearRef] 
    FOREIGN KEY (FiscalYearRef) REFERENCES [FMK].[FiscalYear](FiscalYearId);
    
END	
Go


--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
