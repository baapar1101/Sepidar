--<<FileName:GNR_CalculationElement.sql>>--

--<< TABLE DEFINITION >>--
If Object_ID('GNR.CalculationElement') Is Null
CREATE TABLE [GNR].[CalculationElement] (
	[CalculationElementID] [int] NOT NULL,
	[Symbol] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]


--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CalculationElement')
ALTER TABLE GNR.CalculationElement ADD CONSTRAINT [PK_CalculationElement] PRIMARY KEY CLUSTERED
(
	CalculationElementID
) ON [PRIMARY]
 
 GO
 
 --<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
