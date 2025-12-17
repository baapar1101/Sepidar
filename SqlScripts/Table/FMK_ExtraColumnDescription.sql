--<<FileName:FMK_ExtraColumnDescription.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.ExtraColumnDescription') Is Null
CREATE TABLE [FMK].[ExtraColumnDescription](
	[ExtraColumnDescriptionID] [int] NOT NULL,
	[EntityTypeName] [varchar](1000) NOT NULL,
	[UrlColumn1Description] [nvarchar](500) NULL,
	[UrlColumn2Description] [nvarchar](500) NULL,
	[UrlColumn3Description] [nvarchar](500) NULL,
	[UrlColumn4Description] [nvarchar](500) NULL,
	[UrlColumn5Description] [nvarchar](500) NULL,
	[StringColumn1Description] [nvarchar](100) NULL,
	[StringColumn2Description] [nvarchar](100) NULL,
	[StringColumn3Description] [nvarchar](100) NULL,
	[StringColumn4Description] [nvarchar](100) NULL,
	[StringColumn5Description] [nvarchar](100) NULL,
	[StringColumn6Description] [nvarchar](100) NULL,
	[StringColumn7Description] [nvarchar](100) NULL,
	[StringColumn8Description] [nvarchar](100) NULL,
	[StringColumn9Description] [nvarchar](100) NULL,
	[StringColumn10Description] [nvarchar](100) NULL,
	[StringColumn11Description] [nvarchar](100) NULL,
	[StringColumn12Description] [nvarchar](100) NULL,
	[StringColumn13Description] [nvarchar](100) NULL,
	[StringColumn14Description] [nvarchar](100) NULL,
	[StringColumn15Description] [nvarchar](100) NULL,
	[DateColumn1Description] [nvarchar](100) NULL,
	[DateColumn2Description] [nvarchar](100) NULL,
	[DateColumn3Description] [nvarchar](100) NULL,
	[DateColumn4Description] [nvarchar](100) NULL,
	[DateColumn5Description] [nvarchar](100) NULL,
	[IntegerColumn1Description] [nvarchar](100) NULL,
	[IntegerColumn2Description] [nvarchar](100) NULL,
	[IntegerColumn3Description] [nvarchar](100) NULL,
	[IntegerColumn4Description] [nvarchar](100) NULL,
	[IntegerColumn5Description] [nvarchar](100) NULL,
	[DecimalColumn1Description] [nvarchar](100) NULL,
	[DecimalColumn2Description] [nvarchar](100) NULL,
	[DecimalColumn3Description] [nvarchar](100) NULL,
	[DecimalColumn4Description] [nvarchar](100) NULL,
	[DecimalColumn5Description] [nvarchar](100) NULL,
	[DecimalColumn6Description] [nvarchar](100) NULL,
	[DecimalColumn7Description] [nvarchar](100) NULL,
	[DecimalColumn8Description] [nvarchar](100) NULL,
	[DecimalColumn9Description] [nvarchar](100) NULL,
	[DecimalColumn10Description] [nvarchar](100) NULL,
	
	[UrlColumn1Order] int NULL,
	[UrlColumn2Order] int NULL,
	[UrlColumn3Order] int NULL,
	[UrlColumn4Order] int NULL,
	[UrlColumn5Order] int NULL,
	[StringColumn1Order] int NULL,
	[StringColumn2Order] int NULL,
	[StringColumn3Order] int NULL,
	[StringColumn4Order] int NULL,
	[StringColumn5Order] int NULL,
	[StringColumn6Order] int NULL,
	[StringColumn7Order] int NULL,
	[StringColumn8Order] int NULL,
	[StringColumn9Order] int NULL,
	[StringColumn10Order] int NULL,
	[StringColumn11Order] int NULL,
	[StringColumn12Order] int NULL,
	[StringColumn13Order] int NULL,
	[StringColumn14Order] int NULL,
	[StringColumn15Order] int NULL,
	[DateColumn1Order] int NULL,
	[DateColumn2Order] int NULL,
	[DateColumn3Order] int NULL,
	[DateColumn4Order] int NULL,
	[DateColumn5Order] int NULL,
	[IntegerColumn1Order] int NULL,
	[IntegerColumn2Order] int NULL,
	[IntegerColumn3Order] int NULL,
	[IntegerColumn4Order] int NULL,
	[IntegerColumn5Order] int NULL,
	[DecimalColumn1Order] int NULL,
	[DecimalColumn2Order] int NULL,
	[DecimalColumn3Order] int NULL,
	[DecimalColumn4Order] int NULL,
	[DecimalColumn5Order] int NULL,
	[DecimalColumn6Order] int NULL,
	[DecimalColumn7Order] int NULL,
	[DecimalColumn8Order] int NULL,
	[DecimalColumn9Order] int NULL,
	[DecimalColumn10Order] int NULL,
	
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'ColumnName')
begin
    Alter table FMK.ExtraColumnDescription Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn1Description')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn1Description nvarchar(500) Null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn2Description')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn2Description nvarchar(500) Null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn3Description')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn3Description nvarchar(500) Null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn4Description')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn4Description nvarchar(500) Null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn5Description')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn5Description nvarchar(500) Null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn11Description')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn11Description nvarchar(100) Null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn12Description')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn12Description nvarchar(100) Null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn13Description')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn13Description nvarchar(100) Null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn14Description')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn14Description nvarchar(100) Null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn15Description')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn15Description nvarchar(100) Null
end

GO

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DateColumn4Description')
begin
    Alter table FMK.ExtraColumnDescription Add DateColumn4Description nvarchar(100) Null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DateColumn5Description')
begin
    Alter table FMK.ExtraColumnDescription Add DateColumn5Description nvarchar(100) Null
end

GO

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'IntegerColumn4Description')
begin
    Alter table FMK.ExtraColumnDescription Add IntegerColumn4Description nvarchar(100) Null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'IntegerColumn5Description')
begin
    Alter table FMK.ExtraColumnDescription Add IntegerColumn5Description nvarchar(100) Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn4Description')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn4Description nvarchar(100) Null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn5Description')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn5Description nvarchar(100) Null
end
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn6Description')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn6Description nvarchar(100) Null
end
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn7Description')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn7Description nvarchar(100) Null
end
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn8Description')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn8Description nvarchar(100) Null
end
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn9Description')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn9Description nvarchar(100) Null
end
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn10Description')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn10Description nvarchar(100) Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn1Order')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn1Order int Null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn2Order')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn2Order int Null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn3Order')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn3Order int Null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn4Order')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn4Order int Null
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'UrlColumn5Order')
begin
    Alter table FMK.ExtraColumnDescription Add UrlColumn5Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn1Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn1Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn2Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn2Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn3Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn3Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn4Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn4Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn5Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn5Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn6Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn6Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn7Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn7Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn8Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn8Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn9Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn9Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn10Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn10Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn11Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn11Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn12Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn12Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn13Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn13Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn14Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn14Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'StringColumn15Order')
begin
    Alter table FMK.ExtraColumnDescription Add StringColumn15Order int Null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DateColumn1Order')
begin
    Alter table FMK.ExtraColumnDescription Add DateColumn1Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DateColumn2Order')
begin
    Alter table FMK.ExtraColumnDescription Add DateColumn2Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DateColumn3Order')
begin
    Alter table FMK.ExtraColumnDescription Add DateColumn3Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DateColumn4Order')
begin
    Alter table FMK.ExtraColumnDescription Add DateColumn4Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DateColumn5Order')
begin
    Alter table FMK.ExtraColumnDescription Add DateColumn5Order int Null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'IntegerColumn1Order')
begin
    Alter table FMK.ExtraColumnDescription Add IntegerColumn1Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'IntegerColumn2Order')
begin
    Alter table FMK.ExtraColumnDescription Add IntegerColumn2Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'IntegerColumn3Order')
begin
    Alter table FMK.ExtraColumnDescription Add IntegerColumn3Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'IntegerColumn4Order')
begin
    Alter table FMK.ExtraColumnDescription Add IntegerColumn4Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'IntegerColumn5Order')
begin
    Alter table FMK.ExtraColumnDescription Add IntegerColumn5Order int Null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn1Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn1Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn2Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn2Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn3Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn3Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn4Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn4Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn5Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn5Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn6Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn6Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn7Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn7Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn8Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn8Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn9Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn9Order int Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraColumnDescription') and
				[name] = 'DecimalColumn10Order')
begin
    Alter table FMK.ExtraColumnDescription Add DecimalColumn10Order int Null
end
Go



--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ExtraColumnDescription')
ALTER TABLE [FMK].[ExtraColumnDescription] ADD  CONSTRAINT [PK_ExtraColumnDescription] PRIMARY KEY CLUSTERED 
(
	[ExtraColumnDescriptionID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
