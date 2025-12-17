--<<FileName:GNR_Signature.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Signature') Is Null
CREATE TABLE [GNR].[Signature](
	[SignatureId] [int] NOT NULL,
    [SignatureBlob] [varbinary](max) NULL,
    [Version] [int] NOT NULL,
    [Creator] [int] NULL,
    [CreationDate] [datetime] NULL,
    [LastModifier] [int] NULL,
    [LastModificationDate] [datetime] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
IF NOT EXISTS (select 1 from sys.objects where name = 'PK_Signature')
ALTER TABLE [GNR].[Signature] ADD  CONSTRAINT [PK_Signature] PRIMARY KEY CLUSTERED 
(
	[SignatureId] ASC
) ON [PRIMARY]
GO



--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >