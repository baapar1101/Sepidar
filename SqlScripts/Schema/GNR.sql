if not Exists(select 1 from sys.schemas where [Name] = 'GNR')
	exec sp_executesql N'Create schema GNR Authorization dbo'
GO
