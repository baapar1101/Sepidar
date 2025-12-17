--<<FileName:CNT_ContractCompromiseItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractCompromiseItem') Is Null
CREATE TABLE [CNT].[ContractCompromiseItem](
	[ContractCompromiseItemID]		[int] NOT NULL,
	[ContractRef]				    [int] NOT NULL,
	[Date]							[datetime] NOT NULL,
	[Description]					[nvarchar](250) NOT NULL,
	[Description_En]				[nvarchar](250) NULL	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('CNT.ContractCompromiseItem') and
				[name] = 'ColumnName')
begin
    Alter table CNT.ContractAgreementItem Add ColumnName DataType Nullable
end
GO*/


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractCompromiseItem')
ALTER TABLE [CNT].[ContractCompromiseItem] ADD  CONSTRAINT [PK_ContractCompromiseItem] PRIMARY KEY CLUSTERED 
(
	[ContractCompromiseItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ContractCompromiseItem_ContractRef')
ALTER TABLE [CNT].[ContractCompromiseItem]  ADD  CONSTRAINT [FK_ContractCompromiseItem_ContractRef] FOREIGN KEY([ContractRef])
REFERENCES [CNT].[Contract] ([ContractID])
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
