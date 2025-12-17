--<<FileName:INV_PropertyDetail.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.PropertyDetail') Is Null
CREATE TABLE [INV].[PropertyDetail](
	 [PropertyDetailID]            [int]           NOT NULL,
	 [Title]                 [nvarchar](256) NOT NULL,
	 [PropertyRef]           [int]           NOT NULL,
 	 [Version]               [int]           NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code

--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.PropertyDetail') and
				[name] = 'ColumnName')
begin
    Alter table INV.PropertyDetail Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PropertyDetail')
ALTER TABLE [INV].[PropertyDetail] ADD  CONSTRAINT [PK_PropertyDetail] PRIMARY KEY CLUSTERED 
(
	[PropertyDetailID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If Exists (select 1 from sys.objects where name = 'IX_Title_REF')
BEGIN
		ALTER TABLE [INV].[PropertyDetail] DROP  CONSTRAINT [IX_Title_REF] 
END 

--If not Exists (select 1 from sys.indexes where name = 'IX_ColumnName')
--CREATE NONCLUSTERED INDEX [IX_ColumnName] ON [INV].[PropertyDetail] 
--(
--	[ColumnName] ASC
--) ON [PRIMARY]

--GO


--<< FOREIGNKEYS DEFINITION >>--

GO
If not Exists (select 1 from sys.objects where name = 'FK_PropertyDetail_Property')
ALTER TABLE [INV].[PropertyDetail]  ADD  CONSTRAINT [FK_PropertyDetail_Property] FOREIGN KEY([PropertyRef])
REFERENCES [INV].[Property] ([PropertyID])


GO

--<< DROP OBJECTS >>--
