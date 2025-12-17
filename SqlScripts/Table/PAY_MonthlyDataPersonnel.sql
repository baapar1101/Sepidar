--<<FileName:PAY_MonthlyDataPersonnel.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.MonthlyDataPersonnel') Is Null
CREATE TABLE [PAY].[MonthlyDataPersonnel](
	[MonthlyDataPersonnelId] [int] NOT NULL,
	[MonthlyDataRef] [int] NOT NULL,
	[PersonnelRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.MonthlyDataPersonnel') and
				[name] = 'ColumnName')
begin
    Alter table PAY.MonthlyDataPersonnel Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_MonthlyDataPersonnel')
ALTER TABLE [PAY].[MonthlyDataPersonnel] ADD  CONSTRAINT [PK_MonthlyDataPersonnel] PRIMARY KEY CLUSTERED 
(
	[MonthlyDataPersonnelId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_MonthlyDataPersonnel_MonthlyDataRef_PersonnelRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_MonthlyDataPersonnel_MonthlyDataRef_PersonnelRef] ON [PAY].[MonthlyDataPersonnel] 
(
	[MonthlyDataRef] ASC,
	[PersonnelRef] ASC

) ON [PRIMARY]


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_MonthlyDataPersonnel_MonthlyDataRef')
ALTER TABLE [PAY].[MonthlyDataPersonnel]  ADD  CONSTRAINT [FK_MonthlyDataPersonnel_MonthlyDataRef] FOREIGN KEY([MonthlyDataRef])
REFERENCES [PAY].[MonthlyData] ([MonthlyDataId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_MonthlyDataPersonnel_PersonnelRef')
ALTER TABLE [PAY].[MonthlyDataPersonnel]  ADD  CONSTRAINT [FK_MonthlyDataPersonnel_PersonnelRef] FOREIGN KEY([PersonnelRef])
REFERENCES [PAY].[Personnel] ([PersonnelId])

GO

--<< DROP OBJECTS >>--
