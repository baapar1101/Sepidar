--<<FileName:CNT_Coefficient.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.Coefficient') Is Null
CREATE TABLE [CNT].[Coefficient](
	[CoefficientID]           [int]          NOT NULL,
	[Nature]				  [int]          NOT NULL,
	[Code]                    [int]          NOT NULL,
	[Title]                   [nvarchar](50) NOT NULL,
	[Title_En]                [nvarchar](50) NOT NULL,
	[Percent]                 [real]         NOT NULL,
	[Type]                    [int]          NOT NULL,
	[SLRef]                   [int]              NULL,
	[Version]                 [int]          NOT NULL,
	[Creator]                 [int]          NOT NULL,
	[CreationDate]            [datetime]     NOT NULL,
	[LastModifier]            [int]          NOT NULL,
	[LastModificationDate]    [datetime]     NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Coefficient') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Coefficient Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('CNT.Coefficient') and
				[name] = 'SLRef')
begin
    Alter table CNT.Coefficient Add SLRef int Null
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Coefficient') AND
				[name] = 'Nature')
BEGIN
    ALTER TABLE CNT.Coefficient ADD [Nature] [INT]  NOT NULL DEFAULT(1)
END
GO

--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Coefficient')
ALTER TABLE [CNT].[Coefficient] ADD  CONSTRAINT [PK_Coefficient] PRIMARY KEY CLUSTERED 
(
	[CoefficientID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'UC_Coefficient_Code')
ALTER TABLE [CNT].[Coefficient]  ADD CONSTRAINT UC_Coefficient_Code UNIQUE ([Code])
go
If  Exists (select 1 from sys.objects where name = 'UC_Coefficient_Title')
ALTER TABLE [CNT].[Coefficient]  drop CONSTRAINT UC_Coefficient_Title 
go
--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_Coefficient_Account')
ALTER TABLE [CNT].[Coefficient]  ADD  CONSTRAINT [FK_Coefficient_Account] FOREIGN KEY([SLRef])
REFERENCES [ACC].[Account] ([AccountID])


GO


--<< DROP OBJECTS >>--
IF EXISTS (SELECT 1 FROM sys.objects WHERE name = 'UC_Coefficient')
BEGIN
	ALTER TABLE [CNT].[Coefficient]  DROP CONSTRAINT UC_Coefficient
END
