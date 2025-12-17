--<<FileName:FMK_UserConfiguration.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.UserConfiguration') Is Null
CREATE TABLE [FMK].[UserConfiguration](
	[UserConfigurationID] [int] NOT NULL,
	[Key] [nchar](50) NOT NULL,
	[UserRef] [int] NOT NULL,
	[Value] [nvarchar](max) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.UserConfiguration') and
				[name] = 'ColumnName')
begin
    Alter table FMK.UserConfiguration Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_UserConfiguration')
ALTER TABLE [FMK].[UserConfiguration] ADD  CONSTRAINT [PK_UserConfiguration] PRIMARY KEY CLUSTERED 
(
	[UserConfigurationID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_FMK_UserConfiguration_UserRef')
ALTER TABLE [FMK].[UserConfiguration]  ADD  CONSTRAINT [FK_FMK_UserConfiguration_UserRef] FOREIGN KEY([UserRef])
REFERENCES [FMK].[User] ([UserID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
