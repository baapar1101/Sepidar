--<<FileName:AST_TransferITEM.sql>>--
--<< TABLE DEFINITION >>--

IF (Object_ID('AST.TransferItem') Is Null)
BEGIN
CREATE TABLE [AST].[TransferItem](
	[TransferItemID]		[INT]			NOT NULL,
	[AssetRef]				[INT]			NOT NULL,
	[TransferRef]			[INT]			NOT NULL,	
	[AssetTransactionRef]	[INT]			NOT NULL,
	[PreCostCenterDlRef]		[INT] 			 NULL,
	[PreEmplacementRef]		[INT] 				NULL,
	[PreReceiverPartyRef]	[INT] 			    NULL,
	[CostCenterDlRef]			[INT] 			NOT NULL,
	[EmplacementRef]		[INT] 				NULL,
	[ReceiverPartyRef]		[INT] 			    NULL

) ON [PRIMARY]

END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'CostCenterDlRef')
BEGIN
    ALTER TABLE AST.TransferItem ADD [CostCenterDlRef] [Int] NULL
END	

Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'PreCostCenterDlRef')
BEGIN
    ALTER TABLE AST.TransferItem ADD [PreCostCenterDlRef] [Int] NULL
END	

Go

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_TransferItem')
ALTER TABLE [AST].[TransferItem] ADD  CONSTRAINT [PK_TransferItem] PRIMARY KEY CLUSTERED 
(
	[TransferItemId] ASC
) ON [PRIMARY]
GO



--<< ALTER COLUMNS >>--
if NOT exists (select 1 from sys.objects where name =N'FK_AST_TransferItem_TransferRef')
BEGIN
    ALTER TABLE [AST].[TransferItem] ADD CONSTRAINT [FK_AST_TransferItem_TransferRef]     
		FOREIGN KEY (TransferRef) 
		REFERENCES [AST].[Transfer](TransferID)
			ON UPDATE CASCADE
			ON DELETE CASCADE 
END
GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_TransferItem_AssetRef')
	ALTER TABLE [AST].[TransferItem]  ADD  CONSTRAINT [FK_AST_TransferItem_AssetRef] 
		FOREIGN KEY(AssetRef) REFERENCES [AST].[Asset](AssetId)


If not Exists (select 1 from sys.objects where name = 'FK_AST_TransferItem_CostCenterDlRef')
	ALTER TABLE [AST].[TransferItem]  ADD  CONSTRAINT [FK_AST_TransferItem_CostCenterDlRef] FOREIGN KEY([CostCenterDlRef])
		REFERENCES [ACC].[DL] ([DLId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_TransferItem_EmplacementRef')
	ALTER TABLE [AST].[TransferItem]  ADD  CONSTRAINT [FK_AST_TransferItem_EmplacementRef] FOREIGN KEY([EmplacementRef])
		REFERENCES [AST].[Emplacement] ([EmplacementId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_AST_TransferItem_ReceiverPartyRef')
	ALTER TABLE [AST].[TransferItem]  ADD  CONSTRAINT [FK_AST_TransferItem_ReceiverPartyRef] FOREIGN KEY(ReceiverPartyRef)
		REFERENCES [GNR].[Party] ([PartyId])

GO		


IF  EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'CostCenterRef')
BEGIN
    ALTER TABLE AST.TransferItem ALTER COLUMN [CostCenterRef] [Int] NULL
END	

Go
IF  EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'PreCostCenterRef')
BEGIN
    ALTER TABLE AST.TransferItem ALTER COLUMN [PreCostCenterRef] [Int] NULL
END	

Go
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
