--<<FileName:MRP_ManagementReportFilter.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('MRP.ManagementReportFilter') Is Null
CREATE TABLE [MRP].[ManagementReportFilter](
    [ManagementReportFilterID] INT NOT NULL,
    [ManagementReportStateRef] INT NOT NULL,
    [LogicalOperator] INT NOT NULL,
    [ColumnName] NVARCHAR(200) NOT NULL,
    [Operator] INT NOT NULL,
    [PlaceHolder] NVARCHAR(200) NOT NULL
) ON [PRIMARY]

--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ManagementReportFilter')
BEGIN
    ALTER TABLE [MRP].[ManagementReportFilter] ADD CONSTRAINT [PK_ManagementReportFilter] PRIMARY KEY CLUSTERED
    (
        [ManagementReportFilterID] ASC
    ) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_ManagementReportFilter_ManagementReportStateRef')
    ALTER TABLE [MRP].[ManagementReportFilter] ADD CONSTRAINT [FK_ManagementReportFilter_ManagementReportStateRef] FOREIGN KEY([ManagementReportStateRef])
    REFERENCES [MRP].[ManagementReportState] ([ManagementReportStateID])
    ON DELETE CASCADE
GO
