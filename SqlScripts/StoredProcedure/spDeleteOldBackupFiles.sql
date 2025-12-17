
If Object_ID('GNR.spDeleteOldBackupFiles') IS NOT NULL
	DROP PROCEDURE GNR.spDeleteOldBackupFiles
GO
CREATE PROCEDURE GNR.spDeleteOldBackupFiles @File_path VARCHAR(200), @FileCount int
AS
BEGIN

	if( RIGHT(@File_path ,1) <> '\')
		SET @File_path =@File_path + '\'

	if object_id('tempdb.dbo.#files') is not null
		drop table #files;
	create table #files
	(
		FileInfo varchar(200),
		FileDate DateTime null
	)
	declare @Command varchar(300)
	set @Command = 'dir "' + @File_path+'"'
	
	insert into #files(FileInfo)
		exec sys.xp_cmdshell @Command 

	delete #files
	where FileInfo is null 
		or(FileInfo like '%<DIR>%')
		or(FileInfo LIKE ' %')

	
	
	UPDATE #files SET FileDate =LEFT(FileInfo,20)
	
	
	UPDATE #files SET FileInfo = LTRIM(RIGHT(FileInfo,(LEN(FileInfo)-20)))

	DECLARE @FileName varchar(200)
	

	DECLARE FileName_Cursor CURSOR FOR
		select A.FileName
		from(
				select *,
					FileDate CreationDateTime	,
					RIGHT(FileInfo,LEN(FileInfo) -PATINDEX('% %',FileInfo)) AS FileName,
					ROW_NUMBER() OVER(ORDER BY FileDate  desc, FileInfo) AS  rownumber	
				from #files f			
				where FileInfo like '%.bak' or FileInfo like '%.rar'
		
			)A
			Where rownumber > @fileCount 
			order by CreationDateTime  desc

	OPEN FileName_Cursor

	FETCH NEXT FROM FileName_Cursor INTO @FileName
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		SET @Command = 'del "' + @file_path +@FileName + '"'
		print @Command 
		EXEC xp_cmdshell @Command 
		FETCH NEXT FROM FileName_Cursor INTO @FileName
	END

	CLOSE FileName_Cursor
	DEALLOCATE FileName_Cursor

	drop table #files;
END