--<<FileName:MSG_PhoneLine.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('MSG.PhoneLine') IS NULL
CREATE TABLE [MSG].[PhoneLine](
	[PhoneLineID] [int] NOT NULL,
	[Number] [varchar] (20) NOT NULL,
	[Credit] [decimal] (19, 4) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_PhoneLine')
ALTER TABLE [MSG].[PhoneLine] ADD  CONSTRAINT [PK_PhoneLine] PRIMARY KEY CLUSTERED 
(
	[PhoneLineID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--