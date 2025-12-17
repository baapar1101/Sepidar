--<<FileName:FMK_CheckDataParityItem.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('FMK.CheckDataParityItem') IS NULL
CREATE TABLE [FMK].[CheckDataParityItem]
(
	[Column1] [varbinary](100) NOT NULL,
	[Column2] [varbinary](100) NOT NULL,
	[Column3] [varbinary](MAX) NOT NULL,
	[Column4] [varbinary](100) NOT NULL,
	[Column5] [varbinary](100) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_CheckDataParityItem')
ALTER TABLE [FMK].[CheckDataParityItem] ADD  CONSTRAINT [PK_CheckDataParityItem] PRIMARY KEY CLUSTERED 
(
	[Column1] ASC,
	[Column2] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_CheckDataParity_CheckDataParityItem')
ALTER TABLE [FMK].[CheckDataParityItem]  ADD  CONSTRAINT [FK_CheckDataParity_CheckDataParityItem] FOREIGN KEY([Column1])
REFERENCES [FMK].[CheckDataParity] ([Column1])
ON DELETE CASCADE

GO
--<< DROP OBJECTS >>--