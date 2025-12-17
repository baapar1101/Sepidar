--<<FileName:GNR_Bill.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Bill') Is Null
CREATE TABLE [GNR].[Bill](
	[BillID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[PartyRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[FiscalYearRef] int NOT NULL,
	[LastRemainder] [decimal](19, 4) NULL,
	[NewRemainder] [decimal](19, 4) NULL,
	[RPARemainder] [decimal](19, 4) NULL,
	[ReturnedRemainder] [decimal](19, 4) NULL,
	[EnteryRemainder] [decimal](19, 4) NULL,
	[OtherRemainder] [decimal](19, 4) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[VoucherRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.Bill') and
				[name] = 'ColumnName')
begin
    Alter table GNR.Bill Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Bill') and
				[name] = 'FiscalYearRef')
begin
    Alter table GNR.Bill Add FiscalYearRef int NULL
end

GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Bill')
ALTER TABLE [GNR].[Bill] ADD  CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Bill_PartyRef')
ALTER TABLE [GNR].[Bill]  ADD  CONSTRAINT [FK_Bill_PartyRef] FOREIGN KEY([PartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO

--<< DROP OBJECTS >>--
