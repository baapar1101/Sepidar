if not Exists(select 1 from sys.schemas where [Name] = 'AST')
	exec sp_executesql N'Create schema AST Authorization dbo'
GO
