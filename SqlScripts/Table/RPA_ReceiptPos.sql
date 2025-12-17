--<<FileName:RPA_ReceiptPos.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReceiptPos') Is Null
CREATE TABLE [RPA].[ReceiptPos](
	[ReceiptPosId] [int] NOT NULL,
	[PosRef] [int] NOT NULL,
	[Amount] [decimal](19, 4) NOT NULL,
	[state] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[ReceiptHeaderRef] [int] NOT NULL,
	[HeaderNumber] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[TrackingCode] [NVARCHAR](100) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('RPA.ReceiptPos') AND [name] = 'TrackingCode')
BEGIN
	ALTER TABLE [RPA].[ReceiptPos] ADD [TrackingCode] [NVARCHAR](100) NULL
END
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptPos') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReceiptPos Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
 Alter table RPA.ReceiptPos Alter Column [Rate] [decimal](26, 16) NOT NULL
 Go
 
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReceivePos')
ALTER TABLE [RPA].[ReceiptPos] ADD  CONSTRAINT [PK_ReceivePos] PRIMARY KEY CLUSTERED 
(
	[ReceiptPosId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReceiptPos_CurrencyRef')
ALTER TABLE [RPA].[ReceiptPos]  ADD  CONSTRAINT [FK_ReceiptPos_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceivePos_PosRef')
ALTER TABLE [RPA].[ReceiptPos]  ADD  CONSTRAINT [FK_ReceivePos_PosRef] FOREIGN KEY([PosRef])
REFERENCES [RPA].[Pos] ([PosId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceivePos_ReceiveHeaderRef')
ALTER TABLE [RPA].[ReceiptPos]  ADD  CONSTRAINT [FK_ReceivePos_ReceiveHeaderRef] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
