--<<FileName:DST_CustomerReceiptInfoCheque.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('DST.CustomerReceiptInfoCheque') IS NULL
CREATE TABLE [DST].[CustomerReceiptInfoCheque](
	[CustomerReceiptInfoChequeId]	    [INT]		            NOT NULL,
	[CustomerReceiptInfoRef]            [INT]	                NOT NULL,
	[Amount]				            [decimal](19, 4)  		NOT NULL,
    [BankRef]                           [INT]	                NOT NULL,
    [Date]                              [Datetime]	            NOT NULL,
    [Number]                            [nvarchar](50)          NOT NULL,
	[SayadCode]							[nvarchar](20)				NULL,
    [AccountNo]                         [nvarchar](50)	        NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code

GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('DST.AreaAndPath') and
				[name] = 'ColumnName')
begin
    Alter table DST.AreaAndPath Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.CustomerReceiptInfoCheque') AND
				[name] = 'SayadCode')
BEGIN
    ALTER TABLE DST.CustomerReceiptInfoCheque ADD [SayadCode] [nvarchar](20) NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_CustomerReceiptInfoCheque')
ALTER TABLE [DST].[CustomerReceiptInfoCheque] ADD CONSTRAINT [PK_CustomerReceiptInfoCheque] PRIMARY KEY CLUSTERED
(
	[CustomerReceiptInfoChequeId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'FK_CustomerReceiptInfoCheque_CustomerReceiptInfoRef')
ALTER TABLE [DST].[CustomerReceiptInfoCheque] ADD CONSTRAINT [FK_CustomerReceiptInfoCheque_CustomerReceiptInfoRef] FOREIGN KEY([CustomerReceiptInfoRef])
REFERENCES [DST].[CustomerReceiptInfo] ([CustomerReceiptInfoId])
ON DELETE CASCADE
GO
--<< DROP OBJECTS >>--
