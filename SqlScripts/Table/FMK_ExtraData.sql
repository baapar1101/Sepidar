--<<FileName:FMK_ExtraData.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.ExtraData') Is Null
CREATE TABLE [FMK].[ExtraData](
	[ExtraDataID] [int] NOT NULL,
	[EntityTypeName] [varchar](1000) NOT NULL,
	[EntityRef] [int] NOT NULL,
	[UrlColumn1] [nvarchar](1000) NULL,
	[UrlColumn2] [nvarchar](1000) NULL,
	[UrlColumn3] [nvarchar](1000) NULL,
	[UrlColumn4] [nvarchar](1000) NULL,
	[UrlColumn5] [nvarchar](1000) NULL,				
	[StringColumn1] [nvarchar](1000) NULL,
	[StringColumn2] [nvarchar](1000) NULL,
	[StringColumn3] [nvarchar](1000) NULL,
	[StringColumn4] [nvarchar](1000) NULL,
	[StringColumn5] [nvarchar](1000) NULL,
	[StringColumn6] [nvarchar](1000) NULL,
	[StringColumn7] [nvarchar](1000) NULL,
	[StringColumn8] [nvarchar](1000) NULL,
	[StringColumn9] [nvarchar](1000) NULL,
	[StringColumn10] [nvarchar](1000) NULL,
	[StringColumn11] [nvarchar](1000) NULL,
	[StringColumn12] [nvarchar](1000) NULL,
	[StringColumn13] [nvarchar](1000) NULL,
	[StringColumn14] [nvarchar](1000) NULL,
	[StringColumn15] [nvarchar](1000) NULL,
	[Note] [nvarchar](max) NULL,
	[DateColumn1] [datetime] NULL,
	[DateColumn2] [datetime] NULL,
	[DateColumn3] [datetime] NULL,
	[DateColumn4] [datetime] NULL,
	[DateColumn5] [datetime] NULL,
	[IntegerColumn1] [bigint] NULL,
	[IntegerColumn2] [bigint] NULL,
	[IntegerColumn3] [bigint] NULL,
	[IntegerColumn4] [bigint] NULL,
	[IntegerColumn5] [bigint] NULL,
	[DecimalColumn1] [decimal](19, 4) NULL,
	[DecimalColumn2] [decimal](19, 4) NULL,
	[DecimalColumn3] [decimal](19, 4) NULL,
	[DecimalColumn4] [decimal](19, 4) NULL,
	[DecimalColumn5] [decimal](19, 4) NULL,
	[DecimalColumn6] [decimal](19, 4) NULL,
	[DecimalColumn7] [decimal](19, 4) NULL,
	[DecimalColumn8] [decimal](19, 4) NULL,
	[DecimalColumn9] [decimal](19, 4) NULL,
	[DecimalColumn10] [decimal](19, 4) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'ColumnName')
begin
    Alter table FMK.ExtraData Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'Note')
begin
    Alter table FMK.ExtraData Add [Note] nvarchar(max) null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'UrlColumn1')
begin
    Alter table FMK.ExtraData Add [UrlColumn1] nvarchar(1000) null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'UrlColumn2')
begin
    Alter table FMK.ExtraData Add [UrlColumn2] nvarchar(1000) null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'UrlColumn3')
begin
    Alter table FMK.ExtraData Add [UrlColumn3] nvarchar(1000) null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'UrlColumn4')
begin
    Alter table FMK.ExtraData Add [UrlColumn4] nvarchar(1000) null
END

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'UrlColumn5')
begin
    Alter table FMK.ExtraData Add [UrlColumn5] nvarchar(1000) null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'StringColumn11')
begin
    Alter table FMK.ExtraData Add [StringColumn11] nvarchar(1000) null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'StringColumn12')
begin
    Alter table FMK.ExtraData Add [StringColumn12] nvarchar(1000) null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'StringColumn13')
begin
    Alter table FMK.ExtraData Add [StringColumn13] nvarchar(1000) null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'StringColumn14')
begin
    Alter table FMK.ExtraData Add [StringColumn14] nvarchar(1000) null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'StringColumn15')
begin
    Alter table FMK.ExtraData Add [StringColumn15] nvarchar(1000) null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DateColumn4')
begin
    Alter table FMK.ExtraData Add [DateColumn4] datetime null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DateColumn5')
begin
    Alter table FMK.ExtraData Add [DateColumn5] datetime null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'IntegerColumn4')
begin
    Alter table FMK.ExtraData Add [IntegerColumn4] bigint null
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'IntegerColumn5')
begin
    Alter table FMK.ExtraData Add [IntegerColumn5] bigint null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DecimalColumn4')
begin
    Alter table FMK.ExtraData Add [DecimalColumn4] [decimal](19, 4) NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DecimalColumn5')
begin
    Alter table FMK.ExtraData Add [DecimalColumn5] [decimal](19, 4) NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DecimalColumn6')
begin
    Alter table FMK.ExtraData Add [DecimalColumn6] [decimal](19, 4) NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DecimalColumn7')
begin
    Alter table FMK.ExtraData Add [DecimalColumn7] [decimal](19, 4) NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DecimalColumn8')
begin
    Alter table FMK.ExtraData Add [DecimalColumn8] [decimal](19, 4) NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DecimalColumn9')
begin
    Alter table FMK.ExtraData Add [DecimalColumn9] [decimal](19, 4) NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('FMK.ExtraData') and
				[name] = 'DecimalColumn10')
begin
    Alter table FMK.ExtraData Add [DecimalColumn10] [decimal](19, 4) NULL
end

Go

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ExtraData')
ALTER TABLE [FMK].[ExtraData] ADD  CONSTRAINT [PK_ExtraData] PRIMARY KEY CLUSTERED 
(
	[ExtraDataID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
