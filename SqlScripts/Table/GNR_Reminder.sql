--<<FileName:GNR_Reminder.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Reminder') Is Null
CREATE TABLE [GNR].[Reminder](
	[ReminderID]    	[INT]           NOT NULL,
    [EntityRef]     	[NVARCHAR](100)	NOT NULL,
    [Type]          	[INT]           NOT NULL,
	[Title]         	[NVARCHAR](255) NOT NULL,
	[Title_En]      	[NVARCHAR](255) NULL,
	[Description]   	[nvarchar](255) NULL,
	[Description_En]	[nvarchar](255) NULL,
    [DueDate]       	[DATETIME]      NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Reminder')
ALTER TABLE [GNR].[Reminder] ADD  CONSTRAINT [PK_Reminder] PRIMARY KEY CLUSTERED 
(
	[ReminderId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
