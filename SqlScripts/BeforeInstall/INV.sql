if not Exists(select 1 from sys.schemas where [Name] = 'INV')
	exec sp_executesql N'Create schema INV Authorization dbo'
GO
