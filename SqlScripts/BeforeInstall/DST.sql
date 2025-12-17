if not Exists(select 1 from sys.schemas where [Name] = 'DST')
	exec sp_executesql N'Create schema DST Authorization dbo'
GO
