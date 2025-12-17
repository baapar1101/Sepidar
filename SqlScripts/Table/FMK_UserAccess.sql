--<<FileName:FMK_UserAccess.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.UserAccess') Is Null
CREATE TABLE [FMK].[UserAccess](
	[UserAccessID] [int] NOT NULL,
	[UserRef] [int] NOT NULL,
	[LogicalResource] [nvarchar](500) NULL,
	[HasAccess] [bit] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.UserAccess') and
				[name] = 'ColumnName')
begin
    Alter table FMK.UserAccess Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_UserAccess')
ALTER TABLE [FMK].[UserAccess] ADD  CONSTRAINT [PK_UserAccess] PRIMARY KEY CLUSTERED 
(
	[UserAccessID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_UserAccess_User')
ALTER TABLE [FMK].[UserAccess]  ADD  CONSTRAINT [FK_UserAccess_User] FOREIGN KEY([UserRef])
REFERENCES [FMK].[User] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
