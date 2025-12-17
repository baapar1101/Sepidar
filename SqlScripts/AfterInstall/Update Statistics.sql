
DECLARE @ReBuildTable NVARCHAR(max)  

DECLARE TableCursor CURSOR READ_ONLY FOR  
select  'Update STATISTICS' + '['+SCHEMA_NAME(schema_id)+'].['+name+']'  
from sys.tables


OPEN TableCursor    

   FETCH NEXT FROM TableCursor INTO @ReBuildTable   
   WHILE @@FETCH_STATUS = 0   
   BEGIN
      BEGIN TRY   
         EXEC (@ReBuildTable) 
      END TRY
      BEGIN CATCH
         PRINT '---'
         PRINT @ReBuildTable
         PRINT ERROR_MESSAGE() 
         PRINT '---'
      END CATCH

      FETCH NEXT FROM TableCursor INTO @ReBuildTable   
   END   

   CLOSE TableCursor   
   DEALLOCATE TableCursor
                       