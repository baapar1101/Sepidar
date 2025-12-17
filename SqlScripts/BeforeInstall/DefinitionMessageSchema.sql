IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE [Name] = 'MSG')
	exec sp_executesql N'Create schema MSG Authorization dbo'
GO
