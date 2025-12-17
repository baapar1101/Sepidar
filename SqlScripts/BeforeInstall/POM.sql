if not Exists(select 1 from sys.schemas where [Name] = 'POM')
	exec sp_executesql N'Create schema POM Authorization dbo'
GO
