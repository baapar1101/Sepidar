--<<FileName:ACC_Topic.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('ACC.Topic') Is Null
CREATE TABLE [ACC].[Topic](
	[TopicId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Topic] [nvarchar](100) NOT NULL,
	[Topic_En] [nvarchar](100) NOT NULL,
	[Category] [INT] NOT NULL,
	[Priority] [INT] NOT NULL ,
	[IsSystemTopic] [BIT] NOT NULL ,
	[Version] [INT] NOT NULL ,
    [Creator] [INT] NOT NULL ,
    [CreationDate] [DATETIME] NOT NULL ,
    [LastModifier] [INT] NOT NULL ,
    [LastModificationDate] [DATETIME] NOT NULL 
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('ACC.Topic') and
				[name] = 'Priority')
begin
    Alter table ACC.Topic Add Priority INT NOT NULL DEFAULT 10
end

if not exists (select 1 from sys.columns where object_id=object_id('ACC.Topic') and
				[name] = 'IsSystemTopic')
begin
    Alter table ACC.Topic Add IsSystemTopic BIT NOT NULL DEFAULT 1
end

if not exists (select 1 from sys.columns where object_id=object_id('ACC.Topic') and
				[name] = 'Version')
begin
    Alter table ACC.Topic Add Version INT NOT NULL DEFAULT 0
end

if not exists (select 1 from sys.columns where object_id=object_id('ACC.Topic') and
				[name] = 'Creator')
begin
    Alter table ACC.Topic Add Creator INT NOT NULL DEFAULT 1
end

if not exists (select 1 from sys.columns where object_id=object_id('ACC.Topic') and
				[name] = 'CreationDate')
begin
    Alter table ACC.Topic Add [CreationDate] [DATETIME] NOT NULL DEFAULT GETDATE()
end


if not exists (select 1 from sys.columns where object_id=object_id('ACC.Topic') and
				[name] = 'LastModifier')
begin
    Alter table ACC.Topic Add [LastModifier] INT NOT NULL DEFAULT 1
end


if not exists (select 1 from sys.columns where object_id=object_id('ACC.Topic') and
				[name] = 'LastModificationDate')
begin
    Alter table ACC.Topic Add [LastModificationDate] [DATETIME] NOT NULL DEFAULT GETDATE()
end
GO

--<< ALTER COLUMNS >>--
IF EXISTS (SELECT * FROM sys.columns c WHERE object_id = object_id('ACC.Topic')
	AND c.name = 'Category' AND c.system_type_id = (SELECT system_type_id FROM SYS.types WHERE [name]='nvarchar'))

BEGIN
BEGIN TRAN
UPDATE ACC.Topic SET 
Category= 2
WHERE TopicId BETWEEN 5 AND 30

UPDATE ACC.Topic SET 
Category= 1
WHERE TopicId BETWEEN 35 AND 50

UPDATE ACC.Topic SET 
Category= 5
WHERE TopicId BETWEEN 55 AND 80

UPDATE ACC.Topic SET 
Category= 4
WHERE TopicId BETWEEN 85 AND 95

UPDATE ACC.Topic SET 
Category= 3
WHERE TopicId BETWEEN 100 AND 120

UPDATE ACC.Topic SET 
Category= 6
WHERE TopicId BETWEEN 125 AND 125

UPDATE ACC.Topic SET 
Category= 7
WHERE TopicId BETWEEN 130 AND 130

UPDATE ACC.Topic SET 
Category= 8
WHERE TopicId BETWEEN 135 AND 135

UPDATE ACC.Topic SET 
Category= 9
WHERE TopicId BETWEEN 140 AND 160

UPDATE ACC.Topic SET 
Category= 10
WHERE TopicId BETWEEN 165 AND 175

UPDATE ACC.Topic SET 
Category= 11
WHERE TopicId BETWEEN 180 AND 180


ALTER TABLE ACC.Topic ALTER COLUMN [Category] [INT] NOT NULL
ALTER TABLE ACC.TOPIC DROP COLUMN [Category_En]

 COMMIT;
 END;

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Topic')
ALTER TABLE [ACC].[Topic] ADD  CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED 
(
	[TopicId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_Topic_Category')
ALTER TABLE [ACC].[Topic] ADD  CONSTRAINT [UIX_Topic_Category] UNIQUE NONCLUSTERED 
(
	[TopicId] ASC
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'UIX_Topic_Title')
ALTER TABLE [ACC].[Topic] ADD  CONSTRAINT [UIX_Topic_Title] UNIQUE NONCLUSTERED 
(
	[Topic] ASC
) ON [PRIMARY]

If not Exists (select 1 from sys.indexes where name = 'UIX_Topic_Priority')
BEGIN
BEGIN TRAN
UPDATE ACC.Topic SET [Priority]= (SELECT number from (SELECT
   ROW_NUMBER() OVER(PARTITION BY Category ORDER BY Topic ASC) as number,TopicId as id FROM ACC.Topic) as T where T.id=TopicId)+1000
ALTER TABLE [ACC].[Topic] ADD  CONSTRAINT [UIX_Topic_Priority] UNIQUE NONCLUSTERED 
(
	[Category] ASC,
	[Priority] ASC
) ON [PRIMARY]
COMMIT TRAN
END
GO
If not Exists (select 1 from sys.indexes where name = 'UIX_Topic_TitleEn')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Topic_TitleEn] ON [ACC].[Topic] 
(
	[Topic_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--

