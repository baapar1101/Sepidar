if not Exists(select 1 from sys.schemas where [Name] = 'PAY')
	exec sp_executesql N'Create schema PAY Authorization dbo'
GO
