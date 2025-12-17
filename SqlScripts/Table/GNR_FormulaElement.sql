--<<FileName:GNR_FormulaElement.sql>>--

--<< TABLE DEFINITION >>--
If Object_ID('GNR.FormulaElement') Is Null
CREATE TABLE [GNR].[FormulaElement] (
	[FormulaElementID] [int] NOT NULL,
	[CalculationFormulaRef] [int] NOT NULL,
	[CalculationElementRef] [int] NOT NULL
) ON [PRIMARY]


--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_FormulaElement')
ALTER TABLE GNR.FormulaElement ADD CONSTRAINT [PK_FormulaElement] PRIMARY KEY CLUSTERED
(
	FormulaElementID
) ON [PRIMARY]
 
 GO
 
 --<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--remove invalid foriegn keys
IF EXISTS(SELECT * FROM sys.foreign_keys WHERE name = 'FK_FormulaElement_CalculationFormulaRef' AND delete_referential_action=0)
	ALTER TABLE GNR.FormulaElement
		DROP CONSTRAINT FK_FormulaElement_CalculationFormulaRef

---
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_FormulaElement_CalculationFormulaRef')
	ALTER TABLE GNR.FormulaElement
		ADD CONSTRAINT [FK_FormulaElement_CalculationFormulaRef] FOREIGN KEY
			([CalculationFormulaRef]) REFERENCES [GNR].[CalculationFormula]([CalculationFormulaID])
			ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_FormulaElement_CalculationElementRef')
	ALTER TABLE GNR.FormulaElement
		ADD CONSTRAINT [FK_FormulaElement_CalculationElementRef] FOREIGN KEY
			([CalculationElementRef]) REFERENCES [GNR].[CalculationElement]([CalculationElementID])

GO


--<< DROP OBJECTS >>--
