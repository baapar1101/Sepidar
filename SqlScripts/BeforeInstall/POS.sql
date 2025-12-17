if not Exists(select 1 from sys.schemas where [Name] = 'POS')
	exec sp_executesql N'Create schema POS Authorization dbo'
GO
