--<<FileName:POS_QuickBar.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POS.QuickBar') Is Null
CREATE TABLE [POS].[QuickBar](
	[QuickBarID] [int] NOT NULL,
	[Version] [int] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POS.QuickBar') and
				[name] = 'ColumnName')
begin
    Alter table POS.QuickBar Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_QuickBar')
ALTER TABLE [POS].[QuickBar] ADD  CONSTRAINT [PK_QuickBar] PRIMARY KEY CLUSTERED 
(
	[QuickBarID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

GO

--<< DROP OBJECTS >>--
