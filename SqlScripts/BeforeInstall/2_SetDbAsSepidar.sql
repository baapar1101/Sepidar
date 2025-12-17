if not Exists(
		SELECT objtype, objname, name, value
		FROM fn_listextendedproperty (NULL, null, null, null, null, null, null)
		where name = 'IsSgDb'
		)
EXEC sp_addextendedproperty @name = N'IsSgDB', @value = '1'
