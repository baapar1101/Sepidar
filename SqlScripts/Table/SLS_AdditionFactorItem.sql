--<<FileName:SLS_AdditionFactorItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.AdditionFactorItem') Is Null
CREATE TABLE [SLS].[AdditionFactorItem](
	[AdditionFactorItemID] [int] NOT NULL,
	[AdditionFactorRef] [int] NOT NULL,
	[FromValue] [DECIMAL](19,4) NOT NULL,
	[ToValue] [DECIMAL](19,4) NOT NULL,
	[AdditionType] [int] NOT NULL,
	[Amount] [decimal](19,4) NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.AdditionFactorItem') and
				[name] = 'ColumnName')
begin
    Alter table SLS.AdditionFactorItem Add ColumnName DataType Nullable
end
GO*/
--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AdditionFactorItem')
ALTER TABLE [SLS].[AdditionFactorItem] ADD  CONSTRAINT [PK_AdditionFactorItem] PRIMARY KEY CLUSTERED 
(
	[AdditionFactorItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_AdditionFactorItem_AdditionFactor')
ALTER TABLE [SLS].[AdditionFactorItem]  ADD  CONSTRAINT [FK_AdditionFactorItem_AdditionFactor] FOREIGN KEY([AdditionFactorRef])
REFERENCES [SLS].[AdditionFactor] ([AdditionFactorId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
