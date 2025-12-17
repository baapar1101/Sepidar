--<<FileName:SLS_CommissionCalculationXMLResult.sql>>--
--<< TABLE DEFINITION >>--
if OBJECT_ID('SLS.CommissionCalculationXMLResult') IS NULL
	Create Table SLS.CommissionCalculationXMLResult(
        CommissionCalculationXMLResultID int not null,
        CommissionCalculationRef int not null,
        [Content] [ntext] NULL,
	) ON [PRIMARY]
--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF OBJECT_ID('SLS.PK_CommissionCalculationXMLResultID') IS NULL
	ALTER TABLE SLS.CommissionCalculationXMLResult ADD CONSTRAINT [PK_CommissionCalculationXMLResultID] PRIMARY KEY CLUSTERED
	(
		CommissionCalculationXMLResultID ASC
	) ON [PRIMARY]
GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
IF OBJECT_ID('SLS.FK_CommissionCalculationXMLResult_CommissionCalculationRef') IS NULL
	ALTER TABLE SLS.CommissionCalculationXMLResult 
	  ADD CONSTRAINT [FK_CommissionCalculationXMLResult_CommissionCalculationRef] 
		  FOREIGN KEY ([CommissionCalculationRef]) 
		  REFERENCES [SLS].[CommissionCalculation] ([CommissionCalculationID])
      ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
