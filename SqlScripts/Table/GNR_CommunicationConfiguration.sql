--<<FileName:GNR_CommunicationConfiguration.sql>>--
--<< TABLE DEFINITION >>--
IF OBJECT_ID('GNR.CommunicationConfiguration') IS NULL
CREATE TABLE [GNR].[CommunicationConfiguration](
	[CommunicationConfigurationID] INT NOT NULL,
	[System] INT NOT NULL,
	[Key] NCHAR(50) NOT NULL,
	[Value] NVARCHAR(MAX) NULL,
	[Version] INT NOT NULL
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
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CommunicationConfiguration')
ALTER TABLE [GNR].[CommunicationConfiguration] ADD CONSTRAINT [PK_CommunicationConfiguration] PRIMARY KEY CLUSTERED 
(
	[CommunicationConfigurationID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_CommunicationConfiguration_System_Key')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_CommunicationConfiguration_System_Key] ON [GNR].[CommunicationConfiguration]
(
	[System] ASC,
	[Key] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
