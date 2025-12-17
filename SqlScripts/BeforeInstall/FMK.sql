if not Exists(select 1 from sys.schemas where [Name] = 'FMK')
	exec sp_executesql N'Create schema FMK Authorization dbo'
GO
