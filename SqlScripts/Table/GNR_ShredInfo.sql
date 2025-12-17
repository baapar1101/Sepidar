--<<FileName:GNR_ShredItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.ShredInfo') Is Null
CREATE TABLE [GNR].[ShredInfo](
	[ShredInfoID] [int] NOT NULL,
	[ShredRef] [int] NOT NULL,
	[ShredLength] [int] NOT NULL,
	[ShredCount] [int] NOT NULL,
	[InterestType] [int] NOT NULL,
	[InterestRate] [decimal](19, 4) NOT NULL,
	[PenaltyRate] [decimal](19, 4) NOT NULL,
	[RoundDigCount] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[TransferType] [int] NOT NULL,
	[InterestAmount] [decimal](19, 4) NULL,
	[ShredAmount] [decimal](19, 4) NULL,
	[FinishDate] [datetime] NULL,
	[Length] [int] NULL)
ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.ShredItem') and
				[name] = 'ColumnName')
begin
    Alter table GNR.ShredItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ShredableItem')
ALTER TABLE [GNR].[ShredInfo] ADD  CONSTRAINT [PK_ShredInfo] PRIMARY KEY CLUSTERED 
(
	[ShredInfoID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--If Exists (select 1 from sys.objects where name = 'FK_ShredItem_Shred')
--ALTER TABLE [GNR].[ShredItem]  DROP CONSTRAINT [FK_ShredItem_Shred]

If not Exists (select 1 from sys.objects where name = 'FK_Shred_ShredInfo')
ALTER TABLE [GNR].[ShredInfo]  WITH CHECK ADD  CONSTRAINT [FK_Shred_ShredInfo] FOREIGN KEY([ShredRef])
REFERENCES [GNR].[Shred] ([ShredID])
ON DELETE CASCADE
GO

--<< DROP OBJECTS >>--
