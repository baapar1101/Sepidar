--<<FileName:MRP_ManagementReportState.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('MRP.ManagementReportState') Is Null
CREATE TABLE [MRP].[ManagementReportState](
    [ManagementReportStateID] INT NOT NULL,
    [Title] NVARCHAR(200) NULL,
    [ReportGuid] VARCHAR(40) NOT NULL,
    [IsDefault] BIT NOT NULL,
    [FromDate] DATETIME NULL,
    [ToDate] DATETIME NULL,
    [RowCountLimit] INT NULL,
    [CalculationBasis] INT NULL,
    [ChartType] INT NULL,
    [Creator] INT NOT NULL,
    [CreationDate] DATETIME NOT NULL,
    [LastModifier] INT NOT NULL,
    [LastModificationDate] DATETIME NOT NULL,
    [Version] INT NOT NULL
) ON [PRIMARY]

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ManagementReportState')
BEGIN
    ALTER TABLE [MRP].[ManagementReportState] ADD CONSTRAINT [PK_ManagementReportState] PRIMARY KEY CLUSTERED
    (
        [ManagementReportStateID] ASC
    ) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ManagementReportState_Title')
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UIX_ManagementReportState_Title] ON [MRP].[ManagementReportState] (Title) WHERE Title IS NOT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'UIX_ManagementReportState_ReportGuid_IsDefault')
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UIX_ManagementReportState_ReportGuid_IsDefault] ON [MRP].[ManagementReportState] (ReportGuid, IsDefault) WHERE IsDefault = 1
END
GO

--<< FOREIGNKEYS DEFINITION >>--
