If Object_ID('FMK.StandardDescription') Is Null
CREATE TABLE [FMK].[StandardDescription](
	[StandardDescriptionId] [int] NOT NULL,
	[EntityTypeName] [nvarchar](250) NULL,
	[Key] [int] NOT NULL,
	[Value] [nvarchar](250) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

GO

If Not Exists (select 1 from sys.objects where name = 'PK_StandardDescription')
ALTER TABLE [FMK].[StandardDescription] ADD  CONSTRAINT [PK_StandardDescription] PRIMARY KEY CLUSTERED 
(
	[StandardDescriptionId] ASC
) ON [PRIMARY]
GO

if not exists (select * from dbo.sysIndexes where name = 'IX_StandardDescription_EntityTypeName') 
  CREATE INDEX [IX_StandardDescription_EntityTypeName] ON [FMK].[StandardDescription](
	[EntityTypeName] ASC
	) ON [PRIMARY]
