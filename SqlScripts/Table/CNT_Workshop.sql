--<<FileName:CNT_Workshop.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.Workshop') Is Null
CREATE TABLE [CNT].[Workshop](
	[WorkshopID] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Title_En] [nvarchar](50) NOT NULL,
	[SupervisorRef] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
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
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Workshop') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Workshop Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Workshop')
ALTER TABLE [CNT].[Workshop] ADD  CONSTRAINT [PK_Workshop] PRIMARY KEY CLUSTERED 
(
	[WorkshopID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Workshop_Party')
ALTER TABLE [CNT].[Workshop]  ADD  CONSTRAINT [FK_Workshop_Party] FOREIGN KEY([SupervisorRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
