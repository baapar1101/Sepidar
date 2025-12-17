--<<FileName:GNR_PartyRelated.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.PartyRelated') Is Null
CREATE TABLE [GNR].[PartyRelated](
	[PartyRelatedId] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[IsMain] [bit] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Post] [nvarchar](250) NULL,
	[Name_En] [nvarchar](250) NOT NULL,
	[Post_En] [nvarchar](250) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.PartyRelated') and
				[name] = 'ColumnName')
begin
    Alter table GNR.PartyRelated Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PartyRelated_1')
ALTER TABLE [GNR].[PartyRelated] ADD  CONSTRAINT [PK_PartyRelated_1] PRIMARY KEY CLUSTERED 
(
	[PartyRelatedId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PartyRelated_Partyref_2_PartyRelated_PartyId')
ALTER TABLE [GNR].[PartyRelated]  ADD  CONSTRAINT [FK_PartyRelated_Partyref_2_PartyRelated_PartyId] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
