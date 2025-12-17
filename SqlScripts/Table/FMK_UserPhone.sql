--<<FileName:FMK_UserPhone.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('FMK.UserPhone') Is Null
CREATE TABLE [FMK].[UserPhone](
	[UserPhoneId] [int] NOT NULL,
	[UserRef] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Version] [int] NOT NULL,
	[IsMain] [bit] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.UserPhone') and
				[name] = 'ColumnName')
begin
    Alter table FMK.UserPhone Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('FMK.UserPhone') AND
				[name] = 'Version')
BEGIN
    ALTER TABLE FMK.UserPhone DROP COLUMN [Version]
END
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_UserPhone')
ALTER TABLE [FMK].[UserPhone] ADD  CONSTRAINT [PK_UserPhone] PRIMARY KEY CLUSTERED 
(
	[UserPhoneId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_UserPhone_User_UserRef')
ALTER TABLE [FMK].[UserPhone]  ADD  CONSTRAINT [FK_UserPhone_User_UserRef] FOREIGN KEY([UserRef])
REFERENCES [FMK].[User] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
