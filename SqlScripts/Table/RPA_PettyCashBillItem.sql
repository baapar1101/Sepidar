--<< TABLE DEFINITION >>--
IF Object_ID('RPA.PettyCashBillItem') IS NULL
CREATE TABLE [RPA].[PettyCashBillItem]
(
    [PettyCashBillItemId]    [int]             NOT NULL,
    [RowNumber]              [int]             NOT NULL,
    [Date]                   [datetime]        NULL,
    [Rate]                   [decimal](26, 16) NOT NULL,
    [Amount]                 [decimal](19, 4)  NOT NULL,
    [AmountInBaseCurrency]   [decimal](19, 4)  NOT NULL,

    [RelatedPeople]          [nvarchar](4000)  NULL,
    [RelatedNumbers]         [nvarchar](4000)  NULL,
    [Description]            [nvarchar](4000)  NULL,
    [Description_En]         [nvarchar](4000)  NULL,

    [PettyCashBillRef]       [int]             NOT NULL,
    [DebitCreditNoteItemRef] [int]             NULL,
    [SLRef]                  [int]             NULL,
    [DLRef]                  [int]             NULL,
    [VendorDLRef]              [int]             NULL,
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('RPA.PettyCashBillItem') AND
				[name] = 'VendorDLRef')
BEGIN
    ALTER TABLE RPA.PettyCashBillItem ADD VendorDLRef [int] NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PettyCashBillItem')
ALTER TABLE [RPA].[PettyCashBillItem] ADD CONSTRAINT [PK_PettyCashBillItem] PRIMARY KEY CLUSTERED
(
	[PettyCashBillItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_PettyCashBillItem_PettyCashBillRef')
ALTER TABLE [RPA].[PettyCashBillItem] ADD CONSTRAINT [FK_PettyCashBillItem_PettyCashBillRef] FOREIGN KEY ([PettyCashBillRef])
REFERENCES [RPA].[PettyCashBill] ([PettyCashBillId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_PettyCashBillItem_DebitCreditNoteItemRef')
ALTER TABLE [RPA].[PettyCashBillItem] ADD CONSTRAINT [FK_PettyCashBillItem_DebitCreditNoteItemRef] FOREIGN KEY ([DebitCreditNoteItemRef])
REFERENCES [GNR].[DebitCreditNoteItem] ([DebitCreditNoteItemID])

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_PettyCashBillItem_SLRef')
ALTER TABLE [RPA].[PettyCashBillItem] ADD CONSTRAINT [FK_PettyCashBillItem_SLRef] FOREIGN KEY ([SLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_PettyCashBillItem_DLRef')
ALTER TABLE [RPA].[PettyCashBillItem] ADD CONSTRAINT [FK_PettyCashBillItem_DLRef] FOREIGN KEY ([DLRef])
REFERENCES [ACC].[DL] ([DlId])

GO

IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_PettyCashBillItem_VendorDLRef')
ALTER TABLE [RPA].[PettyCashBillItem] ADD CONSTRAINT [FK_PettyCashBillItem_VendorDLRef] FOREIGN KEY ([VendorDLRef])
REFERENCES [ACC].[DL] ([DlId])

GO
--<< DROP OBJECTS >>--
