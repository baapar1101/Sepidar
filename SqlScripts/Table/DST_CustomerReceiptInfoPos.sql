IF Object_ID('DST.CustomerReceiptInfoPos') IS NULL
CREATE TABLE [DST].[CustomerReceiptInfoPos] (
    [CustomerReceiptInfoPosId]	        [INT]		            NOT NULL,
    [CustomerReceiptInfoRef]            [INT]	                NOT NULL,
    [Amount]				            [decimal](19, 4)  		NOT NULL,
    [TrackingCode]	                    [NVARCHAR](100)		    NULL,
) ON [PRIMARY]
GO

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_CustomerReceiptInfoPos')
ALTER TABLE [DST].[CustomerReceiptInfoPos] ADD CONSTRAINT [PK_CustomerReceiptInfoPos] PRIMARY KEY CLUSTERED
(
	[CustomerReceiptInfoPosId] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_CustomerReceiptInfoPos_CustomerReceiptInfoRef')
ALTER TABLE [DST].[CustomerReceiptInfoPos] ADD CONSTRAINT [FK_CustomerReceiptInfoPos_CustomerReceiptInfoRef] FOREIGN KEY([CustomerReceiptInfoRef])
REFERENCES [DST].[CustomerReceiptInfo] ([CustomerReceiptInfoId])
ON DELETE CASCADE
GO
