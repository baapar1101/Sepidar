--<<FileName:PAY_MonthlyDataPersonnelElement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.MonthlyDataPersonnelElement') Is Null
CREATE TABLE [PAY].[MonthlyDataPersonnelElement](
	[MonthlyDataPersonnelElementlId] [int] NOT NULL,
	[MonthlyDataPersonnelRef] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[ElementRef] [int] NULL,
	[Value] [decimal](19, 4) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.MonthlyDataPersonnelElement') and
				[name] = 'ColumnName')
begin
    Alter table PAY.MonthlyDataPersonnelElement Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_MonthlyDataPersonnelElement')
ALTER TABLE [PAY].[MonthlyDataPersonnelElement] ADD  CONSTRAINT [PK_MonthlyDataPersonnelElement] PRIMARY KEY CLUSTERED 
(
	[MonthlyDataPersonnelElementlId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_MonthlyDataPersonnelElement_MonthlyDataPersonnel')
ALTER TABLE [PAY].[MonthlyDataPersonnelElement]  ADD  CONSTRAINT [FK_MonthlyDataPersonnelElement_MonthlyDataPersonnel] FOREIGN KEY([MonthlyDataPersonnelRef])
REFERENCES [PAY].[MonthlyDataPersonnel] ([MonthlyDataPersonnelId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_MonthlyDataPersonnelElementl_ElementRef')
ALTER TABLE [PAY].[MonthlyDataPersonnelElement]  ADD  CONSTRAINT [FK_MonthlyDataPersonnelElementl_ElementRef] FOREIGN KEY([ElementRef])
REFERENCES [PAY].[Element] ([ElementId])

GO

--<< DROP OBJECTS >>--
