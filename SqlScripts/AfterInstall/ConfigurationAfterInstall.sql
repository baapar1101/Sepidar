if  exists(select top(1) * from RPA.ReceiptChequeBanking) 
begin 
	if not exists(select top(1) * from FMK.Configuration where [Key] = 'IsReceiptCheckBankingSeperatedByBank')
	begin
		declare @newID int
		exec FMK.spGetNextID 'FMK.Configuration', @newID output, 1
		INSERT INTO [FMK].[Configuration]
           ([ConfigurationID]
           ,[Key]
           ,[Value]
           ,[Version])
     VALUES
           (@newID
           ,'IsReceiptCheckBankingSeperatedByBank'             
           ,'True'
           ,1)
	end
end


if exists(select * from fmk.configuration
			Where [Key] ='ControlNegativeBankBalance'
			And [Value] = 'false')
BEGIN
	DECLARE @key AS NVARCHAR(50), @value AS NVARCHAR(MAX)
	SET @key = 'ControlBlockedAmount'

	SELECT @value=[Value] FROM FMK.Configuration WHERE [Key]=@key
	IF @value IS NULL OR @value='True'
	BEGIN
		SELECT TOP 1 @value= FiscalYearId FROM FMK.FiscalYear ORDER BY StartDate
		exec FMK.spSetConfiguration @key, 'False'
	END
END

GO


DECLARE @key AS NVARCHAR(50), @value AS NVARCHAR(MAX)
SET @key = 'PettyCashBillIssueVoucher'

SELECT @value=[Value] FROM FMK.Configuration WHERE [Key]=@key

IF @value IS NULL OR @value=''
BEGIN
	exec FMK.spSetConfiguration @key,'True'
END