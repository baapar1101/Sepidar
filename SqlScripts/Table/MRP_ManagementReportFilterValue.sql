--<<FileName:MRP_ManagementReportFilterValue.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('MRP.ManagementReportFilterValue') Is Null
CREATE TABLE [MRP].[ManagementReportFilterValue](
    [ManagementReportFilterValueID] INT NOT NULL,
    [ManagementReportFilterRef] INT NOT NULL,
    [StringValue] NVARCHAR(200) NULL,
    [IntValue] INT NULL,
    [DecimalValue] DECIMAL(19, 4) NULL,
    [BitValue] BIT NULL,
    [DatetimeValue] DATETIME NULL,
) ON [PRIMARY]

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ManagementReportFilterValue')
BEGIN
    ALTER TABLE [MRP].[ManagementReportFilterValue] ADD CONSTRAINT [PK_ManagementReportFilterValue] PRIMARY KEY CLUSTERED
    (
        [ManagementReportFilterValueID] ASC
    ) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_ManagementReportFilterValue_ManagementReportFilterRef')
    ALTER TABLE [MRP].[ManagementReportFilterValue] ADD CONSTRAINT [FK_ManagementReportFilterValue_ManagementReportFilterRef] FOREIGN KEY([ManagementReportFilterRef])
    REFERENCES [MRP].[ManagementReportFilter] ([ManagementReportFilterID])
    ON DELETE CASCADE
GO
