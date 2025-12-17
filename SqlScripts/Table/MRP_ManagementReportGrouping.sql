--<<FileName:MRP_ManagementReportGrouping.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('MRP.ManagementReportGrouping') Is Null
CREATE TABLE [MRP].[ManagementReportGrouping](
    [ManagementReportGroupingID] INT NOT NULL,
    [ManagementReportStateRef] INT NOT NULL,
    [RowNumber] INT NOT NULL,
    [GroupingName] NVARCHAR(200) NOT NULL,
    [Value] INT NULL
) ON [PRIMARY]

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ManagementReportGrouping')
BEGIN
    ALTER TABLE [MRP].[ManagementReportGrouping] ADD CONSTRAINT [PK_ManagementReportGrouping] PRIMARY KEY CLUSTERED
    (
        [ManagementReportGroupingID] ASC
    ) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_ManagementReportGrouping_ManagementReportStateRef')
    ALTER TABLE [MRP].[ManagementReportGrouping] ADD CONSTRAINT [FK_ManagementReportGrouping_ManagementReportStateRef] FOREIGN KEY([ManagementReportStateRef])
    REFERENCES [MRP].[ManagementReportState] ([ManagementReportStateID])
    ON DELETE CASCADE
GO
