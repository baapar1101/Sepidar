
--<<FileName:CNT_Cost.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.Cost') Is Null
CREATE TABLE [CNT].[Cost](
	[CostID] [int] NOT NULL,
	[Number] int NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Title_En] [nvarchar](250) NULL,
	[SLRef] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Contract') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Contract Add ColumnName DataType Nullable
end
GO*/
if exists (select 1 from sys.columns where object_id=object_id('CNT.Cost') and
				[name] = 'SLRef')
begin
    Alter table CNT.Cost Alter Column SLRef int Null
end
GO

GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_Cost_1')
ALTER TABLE [CNT].[Cost] ADD  CONSTRAINT [PK_Cost_1] PRIMARY KEY CLUSTERED 
(
	[CostID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Cost_Account')
ALTER TABLE [CNT].[Cost]  ADD  CONSTRAINT [FK_Cost_Account] FOREIGN KEY([SLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

--<< DROP OBJECTS >>--
