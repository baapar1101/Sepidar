--<<FileName:AST_Repair.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('AST.Repair') IS NULL
    CREATE TABLE [AST].[Repair]
    (
    	[RepairId]                 [INT] NOT NULL,
    	[Number]                   [INT] NOT NULL,
    	[Date]                     [Datetime] NOT NULL,
    	[DLRef]                    [INT] NULL,
    	[AccountSlRef]             [INT] NULL,
    	[Description]              NVARCHAR(4000) NULL,
    	[Description_En]           NVARCHAR(4000) NULL,
    	[VoucherRef]               [INT] NULL,
    	[FiscalYearRef]            [INT] NOT NULL,
    	[Version]                  [INT] NOT NULL,
    	[Creator]                  [INT] NOT NULL,
    	[CreationDate]             [DATETIME] NOT NULL,
    	[LastModifier]             [INT] NOT NULL,
    	[LastModificationDate]     [DATETIME] NOT NULL,
    ) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF COL_LENGTH('AST.Repair', 'VoucherRef') IS NULL
BEGIN
    ALTER TABLE AST.Repair
    ADD [VoucherRef] INT NULL
END
--<<Sample>>--
--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (
       SELECT 1
       FROM   sys.objects
       WHERE  NAME = 'PK_RepairId'
   )
    ALTER TABLE [AST].[Repair] ADD CONSTRAINT [PK_RepairId] PRIMARY KEY 
    CLUSTERED([RepairId] ASC) ON [PRIMARY]
GO



--<< DEFAULTS CHECKS DEFINITION >>--
--<< RULES DEFINITION >>--
--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (
       SELECT 1
       FROM   sys.objects
       WHERE  NAME = 'FK_Repair_DLRef'
   )
    ALTER TABLE [AST].[Repair] ADD CONSTRAINT [FK_Repair_DLRef] FOREIGN KEY([DLRef])
    REFERENCES [ACC].[DL] ([DLId])

GO
IF NOT EXISTS (
       SELECT 1
       FROM   sys.objects
       WHERE  NAME = 'FK_Repair_AccountSlRef'
   )
    ALTER TABLE [AST].[Repair] ADD CONSTRAINT [FK_Repair_AccountSlRef] FOREIGN 
    KEY([AccountSlRef])
    REFERENCES [ACC].[Account] ([AccountId])

GO
IF NOT EXISTS (
       SELECT 1
       FROM   sys.objects
       WHERE  NAME = 'FK_Repair_FiscalYearRef'
   )
    ALTER TABLE [AST].[Repair] ADD CONSTRAINT [FK_Repair_FiscalYearRef] FOREIGN 
    KEY([FiscalYearRef])
    REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO


--<< DROP OBJECTS >>--

 
