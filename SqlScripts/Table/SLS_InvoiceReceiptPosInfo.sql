IF Object_ID('SLS.InvoiceReceiptPosInfo') IS NULL
CREATE TABLE [SLS].[InvoiceReceiptPosInfo] (
    [InvoiceReceiptPosInfoId]	        [INT]		            NOT NULL,
    [InvoiceRef]                        [INT]	                NOT NULL,
    [Amount]				            [decimal](19, 4)  		NOT NULL,
    [TrackingCode]	                    [NVARCHAR](100)		    NULL,
    [PartyAccountSettlementItemRef]     [INT]                   NULL
) ON [PRIMARY]
GO

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_InvoiceReceiptPosInfo')
ALTER TABLE [SLS].[InvoiceReceiptPosInfo] ADD CONSTRAINT [PK_InvoiceReceiptPosInfo] PRIMARY KEY CLUSTERED
(
	[InvoiceReceiptPosInfoId] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_InvoiceReceiptPosInfo_InvoiceRef')
    ALTER TABLE [SLS].[InvoiceReceiptPosInfo] ADD CONSTRAINT [FK_InvoiceReceiptPosInfo_InvoiceRef] FOREIGN KEY([InvoiceRef])
    REFERENCES [SLS].[Invoice] ([InvoiceId])
    ON UPDATE CASCADE
    ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_InvoiceReceiptPosInfo_PartyAccountSettlementItemRef')
	ALTER TABLE [SLS].[InvoiceReceiptPosInfo] ADD CONSTRAINT [FK_InvoiceReceiptPosInfo_PartyAccountSettlementItemRef] FOREIGN KEY ([PartyAccountSettlementItemRef])
	REFERENCES [RPA].[PartyAccountSettlementItem] ([PartyAccountSettlementItemID])
	ON UPDATE CASCADE
	ON DELETE SET NULL
GO
