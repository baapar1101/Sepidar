if not Exists(select 1 from sys.schemas where [Name] = 'MRP')
    exec sp_executesql N'Create schema MRP Authorization dbo'
GO