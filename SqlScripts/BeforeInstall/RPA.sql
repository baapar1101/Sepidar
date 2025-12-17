if not Exists(select 1 from sys.schemas where [Name] = 'RPA')
	exec sp_executesql N'Create schema RPA Authorization dbo'
GO
