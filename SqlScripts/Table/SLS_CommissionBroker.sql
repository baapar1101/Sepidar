--<<FileName:SLS_CommissionBroker.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('SLS.CommissionBroker') IS NULL
CREATE TABLE [SLS].[CommissionBroker](
	[CommissionBrokerId] [int] NOT NULL,
	[CommissionRef] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('SLS.CommissionBroker') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.CommissionBroker ADD ColumnName DataType Nullable
END
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CommissionBroker')
ALTER TABLE [SLS].[CommissionBroker] ADD CONSTRAINT [PK_CommissionBroker] PRIMARY KEY CLUSTERED 
(
	[CommissionBrokerId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_CommissionBroker_CommissionRef_PartyRef')
CREATE UNIQUE NONCLUSTERED INDEX [UX_CommissionBroker_CommissionRef_PartyRef] ON [SLS].[CommissionBroker] 
(
	[CommissionRef] ASC,
	[PartyRef] ASC
) ON [PRIMARY]

GO


--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_CommissionBroker_CommissionRef')
	ALTER TABLE [SLS].[CommissionBroker] ADD CONSTRAINT [FK_CommissionBroker_CommissionRef] FOREIGN KEY([CommissionRef])
	REFERENCES [SLS].[Commission] ([CommissionId])
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_CommissionBroker_PartyRef')
BEGIN
	ALTER TABLE [SLS].[CommissionBroker] ADD CONSTRAINT [FK_CommissionBroker_PartyRef] FOREIGN KEY([PartyRef])
	REFERENCES [GNR].[Party] ([PartyId])
END
GO

--<< DROP OBJECTS >>--
