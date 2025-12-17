--<<FileName:GNR_CurrencyExchangeRate.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.CurrencyExchangeRate') Is Null
CREATE TABLE [GNR].[CurrencyExchangeRate](
	[CurrencyExchangeRateId] [int] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[ExchangeRate] [decimal](26, 16) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] int Not Null
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('GNR.CurrencyExchangeRate') and
				[name] = 'FiscalYearRef')
begin
    Alter table GNR.CurrencyExchangeRate Add FiscalYearRef int Null
end
Go

if exists (select 1 from sys.columns where object_id=object_id('GNR.CurrencyExchangeRate') and
				[name] = 'FiscalYearRef' and Is_Nullable= 1)
begin
	Update GNR.CurrencyExchangeRate  set FiscalYearRef = (Select top 1 FiscalYearID from Fmk.FiscalYear where EffectiveDate <= Enddate and EffectiveDate >= StartDate)
    Alter table GNR.CurrencyExchangeRate Alter column FiscalYearRef int Not Null
end
Go
if exists (select 1 from sys.columns where object_id=object_id('GNR.CurrencyExchangeRate') and
				[name] = 'ExchangeRate')
begin
    Alter table GNR.CurrencyExchangeRate Alter column ExchangeRate decimal(26, 16) NOT NULL
end

Go
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.CurrencyExchangeRate') and
				[name] = 'ColumnName')
begin
    Alter table GNR.CurrencyExchangeRate Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CurrencyExchangeRate')
ALTER TABLE [GNR].[CurrencyExchangeRate] ADD  CONSTRAINT [PK_CurrencyExchangeRate] PRIMARY KEY CLUSTERED 
(
	[CurrencyExchangeRateId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_CurrencyExchangeRate_CurrencyRate')
CREATE NONCLUSTERED INDEX [IX_CurrencyExchangeRate_CurrencyRate] ON [GNR].[CurrencyExchangeRate] 
(
	[CurrencyRef] ASC
) ON [PRIMARY]

Go
--<< FOREIGNKEYS DEFINITION >>--

if Exists(select 1 from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
		  where Constraint_Name = 'FK_CurrencyExchangeRate_CurrencyRef'
		  and Delete_Rule ='no action')
begin
	ALTER TABLE [GNR].[CurrencyExchangeRate]  Drop CONSTRAINT [FK_CurrencyExchangeRate_CurrencyRef] 
end		  


GO

If not Exists (select 1 from sys.objects where name = 'FK_CurrencyExchangeRate_CurrencyRef')
	ALTER TABLE [GNR].[CurrencyExchangeRate]  
		ADD  CONSTRAINT [FK_CurrencyExchangeRate_CurrencyRef] 
		FOREIGN KEY([CurrencyRef])
		REFERENCES [GNR].[Currency] ([CurrencyID]) On Delete Cascade On Update Cascade

Go

If not Exists (select 1 from sys.objects where name = 'FK_CurrencyExchangeRate_FiscalYearRef')
	ALTER TABLE [GNR].[CurrencyExchangeRate]  
		ADD  CONSTRAINT [FK_CurrencyExchangeRate_FiscalYearRef] 
		FOREIGN KEY([FiscalYearRef])
		REFERENCES [Fmk].[FiscalYear] ([FiscalYearID]) 

--<< DROP OBJECTS >>--
