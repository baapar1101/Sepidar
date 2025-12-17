--<<FileName:GNR_DebitCreditNoteItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.DebitCreditNoteItem') Is Null
CREATE TABLE [GNR].[DebitCreditNoteItem](
	[DebitCreditNoteItemID] [int] NOT NULL,
	[DebitCreditNoteRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[DebitSLRef] [int] NOT NULL,
	[CreditSLRef] [int] NOT NULL,
	[DebitDLRef] [int] NULL,
	[CreditDLRef] [int] NULL,
	[DebitType] [int] NULL,
	[CreditType] [int] NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16) NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.DebitCreditNoteItem') and
				[name] = 'DebitType')
begin
    Alter table GNR.DebitCreditNoteItem Add DebitType INT NULL
end
if not exists (select 1 from sys.columns where object_id=object_id('GNR.DebitCreditNoteItem') and
				[name] = 'CreditType')
begin
    Alter table GNR.DebitCreditNoteItem Add CreditType INT NULL
end

--<< ALTER COLUMNS >>--
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('GNR.DebitCreditNoteItem') AND
				[name] = 'AmountInBaseCurrency' AND is_Computed = 1)
BEGIN
	ALTER TABLE GNR.DebitCreditNoteItem DROP COLUMN AmountInBaseCurrency
	ALTER TABLE GNR.DebitCreditNoteItem ADD AmountInBaseCurrency DECIMAL(19,4)
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DebitCreditNoteItem')
ALTER TABLE [GNR].[DebitCreditNoteItem] ADD  CONSTRAINT [PK_DebitCreditNoteItem] PRIMARY KEY CLUSTERED 
(
	[DebitCreditNoteItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ACCDL_CreditDLRef')
ALTER TABLE [GNR].[DebitCreditNoteItem]  ADD  CONSTRAINT [FK_ACCDL_CreditDLRef] FOREIGN KEY([CreditDLRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ACCDL_DebitDLRef')
ALTER TABLE [GNR].[DebitCreditNoteItem]  ADD  CONSTRAINT [FK_ACCDL_DebitDLRef] FOREIGN KEY([DebitDLRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_DebitCreditNoteItem_CreditSLRef')
ALTER TABLE [GNR].[DebitCreditNoteItem]  ADD  CONSTRAINT [FK_DebitCreditNoteItem_CreditSLRef] FOREIGN KEY([CreditSLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_DebitCreditNoteItem_DebitSLRef')
ALTER TABLE [GNR].[DebitCreditNoteItem]  ADD  CONSTRAINT [FK_DebitCreditNoteItem_DebitSLRef] FOREIGN KEY([DebitSLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLSDebitCreditNote_DebitCreditNoteRef')
ALTER TABLE [GNR].[DebitCreditNoteItem]  ADD  CONSTRAINT [FK_SLSDebitCreditNote_DebitCreditNoteRef] FOREIGN KEY([DebitCreditNoteRef])
REFERENCES [GNR].[DebitCreditNote] ([DebitCreditNoteID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
