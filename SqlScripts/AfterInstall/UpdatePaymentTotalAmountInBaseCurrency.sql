IF NOT EXISTS(SELECT * FROM FMK.[Configuration] WHERE [Key] ='UpdatePaymentTotalAmountInBaseCurrency') 
		AND NOT EXISTS (SELECT * FROM FMK.[Version] WHERE Major * 100 + Minor * 10 + Build > 598)
BEGIN
	UPDATE [header]
	SET [header].[TotalAmountInBaseCurrency] = [X].[TotalAmountInBaseCurrency]
	FROM
	(
	    SELECT ISNULL([header].[AmountInBaseCurrency], 0) + ISNULL([A].[a], 0) + ISNULL([B].[b], 0) + ISNULL([C].[c], 0) [TotalAmountInBaseCurrency],
	           [header].[PaymentHeaderId]
	    FROM [RPA].[PaymentHeader] AS [header]
	        LEFT JOIN
	        (
	            SELECT SUM([AmountInBaseCurrency]) [a],
	                   [PaymentHeaderRef]
	            FROM [RPA].[PaymentCheque]
	            WHERE [State] <> 4
	            GROUP BY [PaymentHeaderRef]
	        ) AS [A]
	            ON [A].[PaymentHeaderRef] = [header].[PaymentHeaderId]
	        LEFT JOIN
	        (
	            SELECT SUM([AmountInBaseCurrency]) [b],
	                   [PaymentHeaderRef]
	            FROM [RPA].[vwPaymentChequeOther]
	            GROUP BY [PaymentHeaderRef]
	        ) AS [B]
	            ON [B].[PaymentHeaderRef] = [header].[PaymentHeaderId]
	        LEFT JOIN
	        (
	            SELECT SUM([AmountInBaseCurrency]) [c],
	                   [PaymentHeaderRef]
	            FROM [RPA].[PaymentDraft]
	            GROUP BY [PaymentHeaderRef]
	        ) AS [C]
	            ON [C].[PaymentHeaderRef] = [header].[PaymentHeaderId]
	    GROUP BY [header].[PaymentHeaderId],
	             [header].[AmountInBaseCurrency],
	             [A].[a],
	             [B].[b],
	             [C].[c],
	             [header].[Rate]
	) AS [X]
	    INNER JOIN [RPA].[PaymentHeader] AS [header]
	        ON [X].[PaymentHeaderId] = [header].[PaymentHeaderId]

	DECLARE @ConfigurationID INT;
		EXEC [FMK].[spGetNextId] @TableName = N'FMK.Configuration', -- nvarchar(100)
		                         @Id = @ConfigurationID OUTPUT, -- int
		                         @IncValue = 1     -- int
		
	INSERT INTO FMK.[Configuration] (ConfigurationID,[Key], [Value],[Version])
		VALUES (@ConfigurationID, 'UpdatePaymentTotalAmountInBaseCurrency', 'True', 1);
   
END
