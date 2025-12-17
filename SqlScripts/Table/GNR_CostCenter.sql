--<<FileName:GNR_CostCenter.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.CostCenter') Is Null
CREATE TABLE [GNR].[CostCenter](
	[CostCenterId] [int] NOT NULL,
	[DLRef] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[Type][int]NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.CostCenter') and
				[name] = 'Type')
begin
    Alter table GNR.CostCenter Add Type int NULL
end

Go

update GNR.CostCenter Set Type = 1 where Type is null
GO

--<< ALTER COLUMNS >>--

Alter table GNR.CostCenter alter column Type int Not NULL
Go
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CostCenter')
ALTER TABLE [GNR].[CostCenter] ADD  CONSTRAINT [PK_CostCenter] PRIMARY KEY CLUSTERED 
(
	[CostCenterId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CostCenter_DL')
ALTER TABLE [GNR].[CostCenter]  ADD  CONSTRAINT [FK_CostCenter_DL] FOREIGN KEY([DLRef])
REFERENCES [ACC].[DL] ([DLId])

GO

--<< DROP OBJECTS >>--
