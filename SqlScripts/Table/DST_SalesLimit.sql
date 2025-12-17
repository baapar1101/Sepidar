--<<FileName:DST_SalesLimit.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.SalesLimit') Is Null
CREATE TABLE [DST].[SalesLimit]
(
	[SalesLimitId] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[Code] NVARCHAR(250) NOT NULL,
	[Title] NVARCHAR(250) NOT NULL,
	[Title_En] NVARCHAR(250) NOT NULL,
	[ControlType] int NOt NULL,
	[StartDate] DateTime NOT NULL,
	[EndDate]  DateTime  NOT NULL,
	[IsActive] [BIT] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
) 
ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Quotation Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

/* Sample
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN PriceInBaseCurrency
	END
END
*/

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DST_SalesLimit')
ALTER TABLE [DST].[SalesLimit] ADD  CONSTRAINT [PK_DST_SalesLimit] PRIMARY KEY CLUSTERED 
(
	[SalesLimitId] ASC
) 
ON [PRIMARY]
GO
If NOT Exists (select 1 from sys.objects where name = 'FK_SalesLimit_FiscalYearRef')
ALTER TABLE [DST].[SalesLimit] ADD CONSTRAINT [FK_SalesLimit_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearID])

GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_DST_SalesLimit_Code')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DST_SalesLimit_Code] ON [DST].[SalesLimit]
(
	[Code] ASC
) ON [PRIMARY]
GO

If not Exists (select 1 from sys.indexes where name = 'UIX_DST_SalesLimit_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_DST_SalesLimit_Title] ON [DST].[SalesLimit]
(
	[Title] ASC
) ON [PRIMARY]
GO
--<< FOREIGNKEYS DEFINITION >>--

GO

--<< DROP OBJECTS >>--


