--<<FileName:GNR_TaxPayerCurrency.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerCurrency') IS NULL
BEGIN
CREATE TABLE [GNR].[TaxPayerCurrency](
	[TaxPayerCurrencyID] [int] NOT NULL,
	[Code] [nvarchar](250) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[UniversalCode] [nvarchar](10) NULL
 CONSTRAINT [PK_TaxPayerCurrency] PRIMARY KEY CLUSTERED 
(
	[TaxPayerCurrencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


--<< ALTER COLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerCurrency') and [name] = 'UniversalCode')
BEGIN
    ALTER TABLE [GNR].[TaxPayerCurrency] Add [UniversalCode] Nvarchar(10) NULL
END

GO