IF OBJECT_ID('GNR.PartyOpeningBalance') IS NOT NULL AND
   EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('GNR.Party') and
 			[name] = 'CustomerOpeningBalanceType')
BEGIN
	DECLARE @SqlStr NVARCHAR(4000)
	
	Set @SqlStr = 
	'DECLARE @cnt INT, @id INT;
	SELECT @cnt = COUNT(*) FROM GNR.PartyOpeningBalance
	IF (@cnt = 0)
	BEGIN
		INSERT INTO GNR.PartyOpeningBalance 		
		SELECT ROW_NUMBER ( ) OVER(ORDER BY PartyID ), 0, 
				CustomerOpeningBalance, PartyID , 
				(SELECT TOP 1 FiscalYearId FROM FMK.FiscalYear ORDER BY StartDate),  CustomerOpeningBalanceType, 0 
		FROM GNR.[Party] WHERE CustomerOpeningBalance IS NOT NULL AND IsCustomer = 1


		SELECT @cnt = COUNT(*) FROM GNR.PartyOpeningBalance
		INSERT INTO GNR.PartyOpeningBalance 		
		SELECT @cnt + ROW_NUMBER ( ) OVER(ORDER BY PartyID ), 1, 
				VendorOpeningBalance, PartyID , 
				(SELECT TOP 1 FiscalYearId FROM FMK.FiscalYear ORDER BY StartDate),  VendorOpeningBalanceType, 0 
		FROM GNR.[Party] WHERE VendorOpeningBalance IS NOT NULL AND IsVendor = 1

		SELECT @cnt = COUNT(*) FROM GNR.PartyOpeningBalance
     	EXEC FMK.spGetNextId ''GNR.PartyOpeningBalance'' , @id, @cnt
		
		ALTER TABLE GNR.Party DROP COLUMN VendorOpeningBalance
		ALTER TABLE GNR.Party DROP COLUMN VendorOpeningBalanceType
		ALTER TABLE GNR.Party DROP COLUMN CustomerOpeningBalance
		ALTER TABLE GNR.Party DROP COLUMN CustomerOpeningBalanceType
	END'
	exec sp_ExecuteSql @SqlStr
END

