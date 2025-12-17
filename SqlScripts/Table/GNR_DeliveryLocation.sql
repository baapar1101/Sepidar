--<<FileName: GNR_DeliveryLocation.sql>>--
--<< TABLE DEFINITION >>--

IF object_id('GNR.DeliveryLocation') IS NULL
CREATE TABLE [GNR].[DeliveryLocation] (
	[DeliveryLocationID] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[Title_En] [nvarchar](250) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.Bill') and
				[name] = 'ColumnName')
begin
    Alter table GNR.Bill Add ColumnName DataType Nullable
end
GO*/

GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DeliveryLocation')
ALTER TABLE [GNR].[DeliveryLocation] ADD  CONSTRAINT [PK_DeliveryLocation] PRIMARY KEY CLUSTERED 
(
	[DeliveryLocationID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
