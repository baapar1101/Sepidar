--<<FileName:RPA_PaymentChequeOther.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PaymentChequeOther') Is Null
CREATE TABLE [RPA].[PaymentChequeOther](
	[PaymentChequeOtherId] [int] NOT NULL,
	[ReceiptChequeRef] [int] NOT NULL,
	[PaymentHeaderRef] [int] NOT NULL,
	[HeaderNumber] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentChequeOther') and
				[name] = 'Description')
begin
    Alter table RPA.PaymentChequeOther Add [Description] [nvarchar](4000) NULL;
    
    EXEC('
        UPDATE [PCO]
        SET [PCO].[Description] = [RC].[Description]
        FROM [RPA].[PaymentChequeOther] AS [PCO]
        JOIN [RPA].[ReceiptCheque] AS [RC] ON [PCO].[ReceiptChequeRef] = [RC].[ReceiptChequeId];
    ');
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentChequeOther') and
				[name] = 'Description_En')
begin
    Alter table RPA.PaymentChequeOther Add [Description_En] [nvarchar](4000) NULL;

    EXEC('
        UPDATE [PCO]
        SET [PCO].[Description_En] = [RC].[Description_En]
        FROM [RPA].[PaymentChequeOther] AS [PCO]
        JOIN [RPA].[ReceiptCheque] AS [RC] ON [PCO].[ReceiptChequeRef] = [RC].[ReceiptChequeId];
    ');
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PaymentChequeOther')
ALTER TABLE [RPA].[PaymentChequeOther] ADD  CONSTRAINT [PK_PaymentChequeOther] PRIMARY KEY CLUSTERED 
(
	[PaymentChequeOtherId] ASC
) ON [PRIMARY]
GO


--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeOther_PaymentHeader')
ALTER TABLE [RPA].[PaymentChequeOther]  ADD  CONSTRAINT [FK_PaymentChequeOther_PaymentHeader] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeOther_ReceiptCheque')
ALTER TABLE [RPA].[PaymentChequeOther]  ADD  CONSTRAINT [FK_PaymentChequeOther_ReceiptCheque] FOREIGN KEY([ReceiptChequeRef])
REFERENCES [RPA].[ReceiptCheque] ([ReceiptChequeId])

GO

--<< DROP OBJECTS >>--
