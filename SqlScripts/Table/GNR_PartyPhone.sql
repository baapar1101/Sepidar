--<<FileName:GNR_PartyPhone.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('GNR.PartyPhone') Is Null
CREATE TABLE [GNR].[PartyPhone](
	[PartyPhoneId] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[IsMain] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.PartyPhone') and
				[name] = 'IsMain')
begin
       Alter table GNR.PartyPhone Add IsMain int NULL 
end
GO
IF  EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.PartyPhone') AND [name]='IsMain')
BEGIN
	UPDATE GNR.PartyPhone SET [IsMain] = 0 WHERE IsMain IS NULL
	ALTER TABLE GNR.PartyPhone ALTER COLUMN [IsMain] int NOT NULL
END
GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PartyPhone')
ALTER TABLE [GNR].[PartyPhone] ADD  CONSTRAINT [PK_PartyPhone] PRIMARY KEY CLUSTERED 
(
	[PartyPhoneId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PartyPhone_IsMain')
CREATE NONCLUSTERED INDEX [IX_PartyPhone_IsMain] ON [GNR].[PartyPhone] 
(
	[IsMain]
) 
ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PartyPhone_PartyRef_IsMain')
CREATE NONCLUSTERED INDEX [IX_PartyPhone_PartyRef_IsMain] ON [GNR].[PartyPhone] 
(
	[PartyRef],
	[IsMain]
) 
ON [PRIMARY]

GO


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PartyPhone_PartyRef_2__Party_PartyId')
ALTER TABLE [GNR].[PartyPhone]  ADD  CONSTRAINT [FK_PartyPhone_PartyRef_2__Party_PartyId] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
