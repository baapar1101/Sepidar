--<<FileName:PAY_PayrollConfigurationElement.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('PAY.PayrollConfigurationElement') Is Null
CREATE TABLE [PAY].[PayrollConfigurationElement](
	[PayrollConfigurationElementId] [int] NOT NULL,
	[ElementRef] [int] NOT NULL,
	[Coefficient] [decimal](19, 4) NULL,
	[Type] [int] NOT NULL,
	[PayrollConfigurationRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('PAY.PayrollConfigurationElement') and
				[name] = 'ColumnName')
begin
    Alter table PAY.PayrollConfigurationElement Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PayrollConfigurationElement')
ALTER TABLE [PAY].[PayrollConfigurationElement] ADD  CONSTRAINT [PK_PayrollConfigurationElement] PRIMARY KEY CLUSTERED 
(
	[PayrollConfigurationElementId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfigurationElement_ElementRef')
ALTER TABLE [PAY].[PayrollConfigurationElement]  ADD  CONSTRAINT [FK_PayrollConfigurationElement_ElementRef] FOREIGN KEY([ElementRef])
REFERENCES [PAY].[Element] ([ElementId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PayrollConfigurationElement_PayrollConfigurationRef')
ALTER TABLE [PAY].[PayrollConfigurationElement]  ADD  CONSTRAINT [FK_PayrollConfigurationElement_PayrollConfigurationRef] FOREIGN KEY([PayrollConfigurationRef])
REFERENCES [PAY].[PayrollConfiguration] ([PayrollConfigurationId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
