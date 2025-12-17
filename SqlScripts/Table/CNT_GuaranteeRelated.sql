--<<FileName:GuaranteeRelated.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('CNT.GuaranteeRelated') Is Null
CREATE TABLE [CNT].[GuaranteeRelated](
	[GuaranteeRelatedID] [int] NOT NULL,	
	[ParentGuaranteeRef] [int] NOT NULL, 
	[ChildGuaranteeRef] [int] NOT NULL, 
	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.Guarantee') and
				[name] = 'ColumnName')
begin
    Alter table CNT.Guarantee Add ColumnName DataType Nullable
end
GO*/


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_GuaranteeRelated_ID')
ALTER TABLE [CNT].[GuaranteeRelated] ADD  CONSTRAINT [PK_GuaranteeRelated_ID] PRIMARY KEY CLUSTERED 
(
	[GuaranteeRelatedID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_GuaranteeRelated_ParentGuaranteeRef')
ALTER TABLE [CNT].[GuaranteeRelated]  ADD  CONSTRAINT [FK_GuaranteeRelated_ParentGuaranteeRef] FOREIGN KEY([ParentGuaranteeRef])
REFERENCES [CNT].[Guarantee] ([GuaranteeId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_GuaranteeRelated_ChildGuaranteeRef')
ALTER TABLE [CNT].[GuaranteeRelated]  ADD  CONSTRAINT [FK_GuaranteeRelated_ChildGuaranteeRef] FOREIGN KEY([ChildGuaranteeRef])
REFERENCES [CNT].[Guarantee] ([GuaranteeId])
GO





