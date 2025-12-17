if not Exists(select 1 from sys.schemas where [Name] = 'ACC')
	exec sp_executesql N'Create schema ACC Authorization dbo'
GO
