--<<FileName:PAY_PersonnelInitiateElement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.PersonnelInitiateElement') Is Null
CREATE TABLE [PAY].[PersonnelInitiateElement](
	[PersonnelInitiateElementId] [int] NOT NULL,
	[ElementRef] [int] NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[PersonnelInitiateRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.PersonnelInitiateElement') and
				[name] = 'ColumnName')
begin
    Alter table PAY.PersonnelInitiateElement Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PersonnelInitiateElement')
ALTER TABLE [PAY].[PersonnelInitiateElement] ADD  CONSTRAINT [PK_PersonnelInitiateElement] PRIMARY KEY CLUSTERED 
(
	[PersonnelInitiateElementId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PersonnelInitiateElement_Element')
ALTER TABLE [PAY].[PersonnelInitiateElement]  ADD  CONSTRAINT [FK_PersonnelInitiateElement_Element] FOREIGN KEY([ElementRef])
REFERENCES [PAY].[Element] ([ElementId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PersonnelInitiateElement_PersonnelInitiateRef')
ALTER TABLE [PAY].[PersonnelInitiateElement]  ADD  CONSTRAINT [FK_PersonnelInitiateElement_PersonnelInitiateRef] FOREIGN KEY([PersonnelInitiateRef])
REFERENCES [PAY].[PersonnelInitiate] ([PersonnelInitiateId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
