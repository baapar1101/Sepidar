--<<FileName:PAY_Leave.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.Leave') Is Null
CREATE TABLE [PAY].[Leave](
	[LeaveId] [int] NOT NULL,
	[PersonnelRef] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[SystemRemainder] [int] NOT NULL,
	[UserRemainder] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Solaryear] [int] NOT NULL,
	[Month] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.Leave') and
				[name] = 'ColumnName')
begin
    Alter table PAY.Leave Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Leave')
ALTER TABLE [PAY].[Leave] ADD  CONSTRAINT [PK_Leave] PRIMARY KEY CLUSTERED 
(
	[LeaveId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Leave_PersonnelRef')
ALTER TABLE [PAY].[Leave]  ADD  CONSTRAINT [FK_Leave_PersonnelRef] FOREIGN KEY([PersonnelRef])
REFERENCES [PAY].[Personnel] ([PersonnelId])

GO

--<< DROP OBJECTS >>--
