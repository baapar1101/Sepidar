if not Exists(select 1 from sys.schemas where [Name] = 'CNT')
	exec sp_executesql N'Create schema CNT Authorization dbo'
GO
