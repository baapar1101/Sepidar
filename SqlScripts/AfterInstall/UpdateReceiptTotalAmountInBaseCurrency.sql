IF NOT EXISTS(SELECT * FROM FMK.[Configuration] WHERE [Key] ='UpdateReceiptTotalAmountInBaseCurrency') 
		AND NOT EXISTS (SELECT * FROM FMK.[Version] WHERE Major * 100 + Minor * 10 + Build > 598)
BEGIN
    UPDATE [header]
    SET [header].[TotalAmountInBaseCurrency] = [X].[TotalAmountInBaseCurrency]
    FROM
    (
        SELECT ISNULL([header].[AmountInBaseCurrency], 0) + ISNULL([A].[a], 0) + ISNULL([B].[b], 0) + ISNULL([C].[c], 0) + ISNULL([D].[d], 0) AS [TotalAmountInBaseCurrency],
               [header].[ReceiptHeaderId]
        FROM [RPA].[ReceiptHeader] AS [header]
            LEFT JOIN
            (
                SELECT SUM([AmountInBaseCurrency]) [a],
                       [ReceiptHeaderRef]
                FROM [RPA].[ReceiptCheque]
                GROUP BY [ReceiptHeaderRef]
            ) AS [A]
                ON [A].[ReceiptHeaderRef] = [header].[ReceiptHeaderId]
            LEFT JOIN
            (
                SELECT SUM([AmountInBaseCurrency]) [b],
                       [ReceiptHeaderRef]
                FROM [RPA].[ReceiptPos]
                GROUP BY [ReceiptHeaderRef]
            ) AS [B]
                ON [B].[ReceiptHeaderRef] = [header].[ReceiptHeaderId]
            LEFT JOIN
            (
                SELECT SUM([AmountInBaseCurrency]) [c],
                       [ReceiptHeaderRef]
                FROM [RPA].[ReceiptDraft]
                GROUP BY [ReceiptHeaderRef]
            ) AS [C]
                ON [C].[ReceiptHeaderRef] = [header].[ReceiptHeaderId]
    		LEFT JOIN
            (
                SELECT SUM([AmountInBaseCurrency]) [d],
                       [ReceiptHeaderRef]
                FROM [RPA].[ReceiptPettyCash]
                GROUP BY [ReceiptHeaderRef]
            ) AS [D]
    			ON [D].[ReceiptHeaderRef] = [header].[ReceiptHeaderId]
        GROUP BY [header].[ReceiptHeaderId],
                 [header].[AmountInBaseCurrency],
                 [A].[a],
                 [B].[b],
                 [C].[c],
    			 [D].[d],
                 [header].[Rate]
    ) AS [X]
        INNER JOIN [RPA].[ReceiptHeader] AS [header]
            ON [X].[ReceiptHeaderId] = [header].[ReceiptHeaderId]

	DECLARE @ConfigurationID INT;
		EXEC [FMK].[spGetNextId] @TableName = N'FMK.Configuration', -- nvarchar(100)
		                         @Id = @ConfigurationID OUTPUT, -- int
		                         @IncValue = 1     -- int
		
	INSERT INTO FMK.[Configuration] (ConfigurationID,[Key], [Value],[Version])
		VALUES (@ConfigurationID, 'UpdateReceiptTotalAmountInBaseCurrency', 'True', 1);
   
END
