--<<FileName:GNR_ElementSavedValue.sql>>--

--<< TABLE DEFINITION >>--
IF object_id('GNR.ElementSavedValue') IS NULL
CREATE TABLE [GNR].[ElementSavedValue] (
	[ElementSavedValueID] [int] not null,
	[CalculationFormulaRef] [int] not null,
	[Key] [nvarchar](250) not null,
	[Values] [nvarchar] (4000) not null
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ElementSavedValue')
ALTER TABLE GNR.ElementSavedValue ADD CONSTRAINT [PK_ElementSavedValue] PRIMARY KEY CLUSTERED
(
	ElementSavedValueID
) ON [PRIMARY]
 
 GO
 
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ElementSavedValue_CalculationFormulaRef')
	ALTER TABLE GNR.ElementSavedValue
	ADD CONSTRAINT [FK_ElementSavedValue_CalculationFormulaRef]
	FOREIGN KEY (CalculationFormulaRef) REFERENCES GNR.CalculationFormula (CalculationFormulaID) ON DELETE CASCADE


--<< DROP OBJECTS >>--
