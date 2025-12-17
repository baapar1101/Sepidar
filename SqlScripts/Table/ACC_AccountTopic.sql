--<<FileName:ACC_AccountTopic.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.AccountTopic') Is Null
CREATE TABLE [ACC].[AccountTopic](
	[AccountTopicId] [int] NOT NULL,
	[AccountSLRef] [int] NOT NULL,
	[TopicRef] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('ACC.AccountTopic') and
				[name] = 'ColumnName')
begin
    Alter table ACC.AccountTopic Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AccountTopic')
ALTER TABLE [ACC].[AccountTopic] ADD  CONSTRAINT [PK_AccountTopic] PRIMARY KEY CLUSTERED 
(
	[AccountTopicId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_AccountTopic_AccountRef_TopicRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AccountTopic_AccountRef_TopicRef] ON [ACC].[AccountTopic] 
(
	[AccountSLRef] ASC,
	[TopicRef] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--

If Exists (select 1 from sys.objects where name = 'FK_AccountTopic_AccountRef')
	ALTER TABLE [ACC].[AccountTopic]  DROP CONSTRAINT [FK_AccountTopic_AccountRef] 
GO
If not Exists (select 1 from sys.objects where name = 'FK_AccountTopic_AccountRef')
ALTER TABLE [ACC].[AccountTopic]  ADD  CONSTRAINT [FK_AccountTopic_AccountRef] FOREIGN KEY([AccountSLRef])
REFERENCES [ACC].[Account] ([AccountId]) 
ON UPDATE  CASCADE  ON DELETE  CASCADE --newly added


GO
If not Exists (select 1 from sys.objects where name = 'FK_AccountTopic_TopicRef')
ALTER TABLE [ACC].[AccountTopic]  ADD  CONSTRAINT [FK_AccountTopic_TopicRef] FOREIGN KEY([TopicRef])
REFERENCES [ACC].[Topic] ([TopicId])

GO

--<< DROP OBJECTS >>--
