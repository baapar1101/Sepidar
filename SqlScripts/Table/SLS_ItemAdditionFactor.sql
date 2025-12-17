--<<FileName:SLS_ItemAdditionFactor.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ItemAdditionFactor') Is Null
CREATE TABLE [SLS].[ItemAdditionFactor](
	[ItemAdditionFactorID] [int] NOT NULL,
	[AdditionFactorRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [INT] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ItemAdditionFactor') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ItemAdditionFactor Add ColumnName DataType Nullable
end
GO*/
--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ItemAdditionFactor')
ALTER TABLE [SLS].[ItemAdditionFactor] ADD  CONSTRAINT [PK_ItemAdditionFactor] PRIMARY KEY CLUSTERED 
(
	[ItemAdditionFactorID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_ItemAdditionFactor_Item')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_SLS_ItemAdditionFactor_Item] ON [SLS].[ItemAdditionFactor]
(
	AdditionFactorRef, ItemRef, TracingRef
) ON [PRIMARY]
go
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ItemAdditionFactor_AdditionFactor')
ALTER TABLE [SLS].[ItemAdditionFactor]  ADD  CONSTRAINT [FK_ItemAdditionFactor_AdditionFactor] FOREIGN KEY([AdditionFactorRef])
REFERENCES [SLS].[AdditionFactor] ([AdditionFactorID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ItemAdditionFactor_Item')
ALTER TABLE [SLS].[ItemAdditionFactor]  ADD  CONSTRAINT [FK_ItemAdditionFactor_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemAdditionFactor_Tracing')
ALTER TABLE [SLS].[ItemAdditionFactor]  ADD  CONSTRAINT [FK_ItemAdditionFactor_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])
GO

--<< DROP OBJECTS >>--
