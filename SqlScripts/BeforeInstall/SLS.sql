if not Exists(select 1 from sys.schemas where [Name] = 'SLS')
	exec sp_executesql N'Create schema SLS Authorization dbo'
GO
