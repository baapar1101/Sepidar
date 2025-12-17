--<<FileName:GNR_Currency.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Currency') Is Null
CREATE TABLE [GNR].[Currency](
	[CurrencyID] [int] NOT NULL,
	[Title] [nvarchar](40) NOT NULL,
	[Title_En] [nvarchar](40) NOT NULL,
	[ExchangeUnit] [int] NOT NULL,
	[PrecisionCount] [int] NOT NULL,
	[PrecisionName] [nvarchar](40) NULL,
	[PrecisionName_En] [nvarchar](40) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.Currency') and
				[name] = 'ColumnName')
begin
    Alter table GNR.Currency Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Currency')
ALTER TABLE [GNR].[Currency] ADD  CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[CurrencyID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_Currency_Title')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Currency_Title] ON [GNR].[Currency] 
(
	[Title] ASC
) ON [PRIMARY]

GO
If not Exists (select 1 from sys.indexes where name = 'IX_Currency_Title_EN')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Currency_Title_EN] ON [GNR].[Currency] 
(
	[Title_En] ASC
) ON [PRIMARY]

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
