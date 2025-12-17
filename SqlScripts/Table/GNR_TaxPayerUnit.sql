--<<FileName:GNR_TaxPayerUnit.sql>>--

--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerUnit') IS NULL
BEGIN
CREATE TABLE [GNR].[TaxPayerUnit](
	[TaxPayerUnitID] [int] NOT NULL,
	[Code] [nvarchar](250) NOT NULL,
	[Ttile] [nvarchar](500) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TaxPayerUnit] PRIMARY KEY CLUSTERED 
(
	[TaxPayerUnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
