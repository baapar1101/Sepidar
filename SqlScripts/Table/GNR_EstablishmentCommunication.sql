--<<FileName:GNR_EstablishmentCommunication.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.EstablishmentCommunication') Is Null
CREATE TABLE [GNR].[EstablishmentCommunication](
	[EstablishmentCommunicationId] [int] NOT NULL,
	[EntityName] [nvarchar] (60) NOT NULL,
	[EntityCode] [int] NOT NULL,
	[IsSynchronized] [bit] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Invoice Add ColumnName DataType Nullable
end
GO*/


--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_EstablishmentCommunication')
ALTER TABLE [GNR].[EstablishmentCommunication] ADD  CONSTRAINT [PK_EstablishmentCommunication] PRIMARY KEY CLUSTERED 
(
	[EstablishmentCommunicationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--

