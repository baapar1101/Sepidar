--<<FileName:GNR_CalculationFormula.sql>>--

--<< TABLE DEFINITION >>--
If Object_ID('GNR.CalculationFormula') Is Null
CREATE TABLE [GNR].[CalculationFormula] (
	[CalculationFormulaID] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Text] [nvarchar](4000) NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]


--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CalculationFormula')
ALTER TABLE GNR.CalculationFormula ADD CONSTRAINT [PK_CalculationFormula] PRIMARY KEY CLUSTERED
(
	CalculationFormulaID
) ON [PRIMARY]
 
 GO
 
 --<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
