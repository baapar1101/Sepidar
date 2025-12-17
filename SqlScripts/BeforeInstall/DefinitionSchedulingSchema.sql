IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE [Name] = 'SCD')
	exec sp_executesql N'Create schema SCD Authorization dbo'
GO