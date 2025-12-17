--<<FileName:MSG_CustomContactPhone.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('MSG.CustomContactPhone') Is Null
CREATE TABLE [MSG].[CustomContactPhone](
	[CustomContactPhoneId] [int] NOT NULL,
	[CustomContactRef] [int] NOT NULL,
	[Phone] [varchar](11) NOT NULL,
	[IsMain] [bit] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CustomContactPhoneId')
ALTER TABLE [MSG].[CustomContactPhone] ADD  CONSTRAINT [PK_CustomContactPhoneId] PRIMARY KEY CLUSTERED 
(
	[CustomContactPhoneId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CustomContactPhone_CustomContactRef_CustomContact_CustomContactId')
ALTER TABLE [MSG].[CustomContactPhone]  ADD  CONSTRAINT [FK_CustomContactPhone_CustomContactRef_CustomContact_CustomContactId] FOREIGN KEY([CustomContactRef])
REFERENCES [MSG].[CustomContact] ([CustomContactId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
