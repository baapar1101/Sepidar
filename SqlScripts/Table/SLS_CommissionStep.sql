--<<FileName:SLS_CommissionStep.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('SLS.CommissionStep') IS NULL
CREATE TABLE [SLS].[CommissionStep](
	[CommissionStepId] [int] NOT NULL,
	[CommissionRef] [int] NOT NULL,
	[FromValue] [decimal](19,4) NOT NULL,
	[ToValue] [decimal](19,4) NOT NULL,
	[Amount] [decimal](19,4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.CommissionStep') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.CommissionStep Add ColumnName DataType Nullable
END
GO*/

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CommissionStep')
ALTER TABLE [SLS].[CommissionStep] ADD  CONSTRAINT [PK_CommissionStep] PRIMARY KEY CLUSTERED 
(
	[CommissionStepId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_CommissionStep_CommissionRef')
	ALTER TABLE [SLS].[CommissionStep] ADD CONSTRAINT [FK_CommissionStep_CommissionRef] FOREIGN KEY([CommissionRef])
	REFERENCES [SLS].[Commission] ([CommissionId])
	ON UPDATE CASCADE
	ON DELETE CASCADE
	
--<< DROP OBJECTS >>--
