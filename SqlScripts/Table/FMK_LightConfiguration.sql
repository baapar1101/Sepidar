--<<FileName:FMK_LightConfiguration.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.LightConfiguration') Is Null
CREATE TABLE [FMK].[LightConfiguration](
    [Key] [nvarchar](50) NOT NULL,
    [Value] [nvarchar](max) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.LightConfiguration') and
                [name] = 'ColumnName')
begin
    Alter table FMK.LightConfiguration Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_LightConfiguration')
ALTER TABLE [FMK].[LightConfiguration] ADD  CONSTRAINT [PK_LightConfiguration] PRIMARY KEY ([Key] ASC) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
