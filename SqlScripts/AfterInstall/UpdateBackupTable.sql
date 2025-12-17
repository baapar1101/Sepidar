UPDATE
[GNR].[Backup]
SET
[IsCompressed] = [IsPasswordProtected]
WHERE [IsCompressed] IS NULL

