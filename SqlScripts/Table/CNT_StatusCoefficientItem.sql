--<<FileName:CNT_StatusCoefficientItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.StatusCoefficientItem') Is Null
CREATE TABLE [CNT].[StatusCoefficientItem](
    [StatusCoefficientItemID]    [int] NOT NULL,
    [StatusRef]                  [int] NOT NULL,
    [ContractCoefficientItemRef] [int]     NULL,
    [CoefficientRef]             [int]     NULL,
    [Price]                      [decimal](19, 4) NOT NULL,
    [DefaultPercent]             [real] NOT NULL
    ) ON [PRIMARY]



--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.StatusCoefficientItem') and
                [name] = 'ColumnName')
begin
    Alter table CNT.StatusCoefficientItem Add ColumnName DataType Nullable
end
GO*/
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('CNT.StatusCoefficientItem') AND [name] = 'DefaultPercent')
begin
    ALTER TABLE CNT.StatusCoefficientItem ADD [DefaultPercent] [real] NULL
end;
GO

IF (SELECT is_nullable FROM sys.columns WHERE object_id = object_id('CNT.StatusCoefficientItem') AND [name] = 'DefaultPercent') = 1
BEGIN
    UPDATE SCI SET DefaultPercent = CASE WHEN SCI.ContractCoefficientItemRef IS NOT NULL THEN CCI.[Percent] ELSE C.[Percent] END
    FROM CNT.StatusCoefficientItem SCI
    LEFT JOIN CNT.ContractCoefficientItem CCI ON SCI.ContractCoefficientItemRef = CCI.ContractCoefficientID
    LEFT JOIN CNT.Coefficient AS C2 ON C2.CoefficientID = CCI.CoefficientRef
    LEFT JOIN CNT.Coefficient AS C ON SCI.CoefficientRef = C.CoefficientID

    ALTER TABLE CNT.StatusCoefficientItem ALTER COLUMN [DefaultPercent] [real] NOT NULL;
END
GO
--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_StatusCoefficientItem')
ALTER TABLE [CNT].[StatusCoefficientItem] ADD  CONSTRAINT [PK_StatusCoefficientItem] PRIMARY KEY CLUSTERED 
(
    [StatusCoefficientItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

IF OBJECT_ID('CNT.[CHK_CoefficientRef_ContractCoefficientRef]', 'C') IS NULL 
    ALTER TABLE [CNT].[StatusCoefficientItem] ADD CONSTRAINT 
    CHK_CoefficientRef_ContractCoefficientRef 
    CHECK ((CoefficientRef IS NULL AND ContractCoefficientItemRef IS NOT NULL) OR (ContractCoefficientItemRef IS NULL AND CoefficientRef IS NOT NULL));



GO

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_StatusCoefficientItem_Status')
ALTER TABLE [CNT].[StatusCoefficientItem]  Add  CONSTRAINT [FK_StatusCoefficientItem_Status] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_StatusCoefficientItem_ContractCoefficientItem')
ALTER TABLE [CNT].[StatusCoefficientItem]  ADD  CONSTRAINT [FK_StatusCoefficientItem_ContractCoefficientItem] FOREIGN KEY([ContractCoefficientItemRef])
REFERENCES [CNT].[ContractCoefficientItem] ([ContractCoefficientID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_StatusCoefficientItem_CoefficientRef')
ALTER TABLE [CNT].[StatusCoefficientItem]  ADD  CONSTRAINT [FK_StatusCoefficientItem_CoefficientRef] FOREIGN KEY([CoefficientRef])
REFERENCES [CNT].[Coefficient] ([CoefficientID])

GO

--<< DROP OBJECTS >>--


    