--<<FileName:FMK_CheckDataParity.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('FMK.CheckDataParity') IS NULL
CREATE TABLE [FMK].[CheckDataParity]
(
	[Column1] [varbinary](100) NOT NULL,
	[Column2] [varbinary](100) NOT NULL,
	[Column3] [varbinary](100) NOT NULL,
	[Column4] [varbinary](100) NOT NULL,
	[Column5] [varbinary](100) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'PK_CheckDataParity')
ALTER TABLE [FMK].[CheckDataParity] ADD  CONSTRAINT [PK_CheckDataParity] PRIMARY KEY CLUSTERED 
(
	[Column1] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--