--<<FileName:FMK_User.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('FMK.User') Is Null
CREATE TABLE [FMK].[User](
	[UserID] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Name_En] [nvarchar](200) NOT NULL,
	[UserName] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](100) NULL,
	[Status] [bit] NULL,
	[IsDeleted] [bit] Not NULL,
	[CanChangeAdminConfiguration] bit Not Null,
	[CanLoginAsAPIServer] bit Not Null,
	Creator int not null,
	LastModifier int not null,
	CreationDate datetime not null,
	LastModificationDate datetime not null,
	Version int not null,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'Name_En')
begin
    Alter table FMK.[User] Add [Name_En] [nvarchar](200) NULL
end
Go
if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'Name_En' and Is_Nullable =1)
begin
    Update FMK.[User] set [Name_En] = [name]
end
Go
if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'Name_En' and Is_Nullable=1)
begin
    Alter table FMK.[User] Alter Column [Name_En] [nvarchar](200) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'CanChangeAdminConfiguration')
begin
    Alter table FMK.[User] Add [CanChangeAdminConfiguration] bit Null
end
Go
if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'CanChangeAdminConfiguration' and Is_nullable = 1)
begin
	Update FMK.[User] set [CanChangeAdminConfiguration] = 0
    Alter table FMK.[User] Alter column [CanChangeAdminConfiguration] bit not Null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'IsDeleted')
begin
    Alter table FMK.[User] Add IsDeleted BIT Null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'CanLoginAsAPIServer')
begin
    ALTER TABLE FMK.[User] Add CanLoginAsAPIServer BIT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'CanLoginAsAPIServer' AND is_nullable = 1)
begin
	UPDATE fmk.[USER] SET CanLoginAsAPIServer = CASE WHEN UserID = 1 THEN 1 ELSE 0 END
    ALTER TABLE FMK.[User] ALTER COLUMN CanLoginAsAPIServer BIT NOT NULL
end
Go

if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'IsDeleted' and Is_nullable = 1)
begin
	Update FMK.[User] set IsDeleted = 0
    Alter table FMK.[User] Alter column IsDeleted bit not Null
end
Go


Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'Creator')
begin
    Alter table FMK.[User] Add Creator int Null
end
Go
if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'Creator' and Is_nullable = 1)
begin
	Update FMK.[User] set Creator = (select top 1 UserId from Fmk.[User])
    Alter table FMK.[User] Alter column Creator int not Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'LastModifier')
begin
    Alter table FMK.[User] Add LastModifier int Null
end
Go
if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'LastModifier' and Is_nullable = 1)
begin
	Update FMK.[User] set LastModifier = (select top 1 UserId from Fmk.[User])
    Alter table FMK.[User] Alter column LastModifier int not Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'CreationDate')
begin
    Alter table FMK.[User] Add CreationDate datetime Null
end
Go
if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'CreationDate' and Is_nullable = 1)
begin
	Update FMK.[User] set CreationDate = GetDate()
    Alter table FMK.[User] Alter column CreationDate datetime not Null
end
Go
if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'LastModificationDate')
begin
    Alter table FMK.[User] Add LastModificationDate datetime Null
end
Go
if exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'LastModificationDate' and Is_nullable = 1)
begin
	Update FMK.[User] set LastModificationDate = GetDate()
    Alter table FMK.[User] Alter column LastModificationDate datetime not Null
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'Version')
begin
    Alter table FMK.[User] Add [Version] int not Null DEFAULT 1
end
Go

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('FMK.User') and
				[name] = 'ColumnName')
begin
    Alter table FMK.User Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_User')
ALTER TABLE [FMK].[User] ADD  CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If Exists (select 1 from sys.indexes where name = 'UIX_FMK_User_UserName')
Drop Index [UIX_FMK_User_UserName] ON [FMK].[User] 

GO
--<< FOREIGNKEYS DEFINITION >>--


--<< DROP OBJECTS >>--
