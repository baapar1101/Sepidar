-- *** Set PayrollConfiguration Tables ***
DECLARE @DailyHourMinute INT
DECLARE @PayrollConfigurationRef INT
IF (NOT EXISTS (SELECT 1 FROM Pay.PayrollConfiguration))
	BEGIN
		INSERT INTO  PAY.PayrollConfiguration(PayrollConfigurationId,TopDailyInsurance, EmployeeInsurancePercent ,EmployerInsurancePercent ,UnemploymentInsurancePercent ,HardWorkInsurance ,SocialSecurityAccountRef ,PaymentSocialSecurityAccountRef ,NonTaxableSocialSecurityPercent ,SupportingInsurancePercent ,PaymentInsuranceAccountRef ,SupportingInsuranceEmployeeElementRef ,SupportingInsuranceEmployerElementRef ,SupportingInsuranceCostAccountRef ,PaymentSupportingInsuranceAccountRef ,TopMonthlyLeave ,TransferYearlyLeave ,LeaveCostAccountRef ,LeaveSavingAccountRef ,TopNewYearBonus ,NewYearBonusBaseFactor ,NonTaxableNewYearBonus ,NonTaxbleBonusRelatedToWorkTime ,NewYearBonuCostAccountRef ,WorkingHistoryYearlyDay ,WorkingHistorySavingAccountRef ,WorkingHistoryCostAccountRef ,PaymentRound ,PaymentAccountRef ,PaymentRoundAccountRef ,EmployeesCurrentAccountRef,CalculateNegativeTax, HealthInsurancePercent)
		VALUES
		(7 ,0.0000 ,7.0000 ,20.0000 ,3.0000 ,4.0000 ,NULL ,NULL ,1.0000 ,1.0000 ,NULL ,NULL ,NULL ,NULL ,NULL ,1100 ,3960 ,NULL ,NULL ,NULL ,2.00 ,NULL ,0 ,NULL ,30 ,NULL ,NULL ,3 ,NULL ,NULL ,NULL,0, 1)
		
		SET @DailyHourMinute = 440
		SET @PayrollConfigurationRef = 7
			
		DECLARE @id int
		EXEC FMK.spGetNextId 'PAY.PayrollConfiguration', @id, 100	
		EXEC FMK.spGetNextId 'PAY.PayrollConfigurationCalendar', @id, 100
   END

DECLARE @IsNullablePayrollCalendarYearColumn BIT	
IF (NOT EXISTS (SELECT 1 FROM SYS.columns WHERE OBJECT_ID = OBJECT_ID('Pay.PayrollCalendar') AND
												[NAME] = 'Year' AND is_nullable = 0))
BEGIN
	DELETE FROM Pay.PayrollCalendar
	SET @IsNullablePayrollCalendarYearColumn = 1
END
-- Fill DailyHourMinute FROM PayrollConfiguration
CREATE TABLE TempDailyHourMinute(DHM INT)
BEGIN TRY
	EXEC('	INSERT INTO TempDailyHourMinute
			SELECT DailyHourMinute
			FROM PAY.PayrollConfiguration')
	SELECT TOP 1 @DailyHourMinute = DHM FROM TempDailyHourMinute
END TRY
BEGIN CATCH
END CATCH			
DROP TABLE TempDailyHourMinute

IF (@DailyHourMinute IS NULL)
BEGIN
	SET @DailyHourMinute = 440
END

SELECT @PayrollConfigurationRef = PayrollConfigurationId FROM PAY.PayrollConfiguration		
		
IF (NOT EXISTS (SELECT 1 FROM Pay.PayrollCalendar))
BEGIN
	IF (@IsNullablePayrollCalendarYearColumn = 1)
	BEGIN
		-- Set PayrollCalendar Year Column To Not Null
		ALTER TABLE Pay.PayrollCalendar ALTER COLUMN [Year] [int] NOT NULL
	END
		 
	DECLARE @Year INT,@PayCalendarId INT
	SET @Year = 1388
	SET @PayCalendarId = 1
	
	WHILE @Year < 1393
		BEGIN
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId,@Year,1, 31, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId,@Year, 2, 31, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId, @Year,3, 31, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId,@Year, 4, 31, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId,@Year, 5, 31, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId, @Year,6, 31, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId,@Year, @PayrollConfigurationRef, 30, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId, @Year,8, 30, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId, @Year,9, 30, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId,@Year, 10, 30, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
			VALUES(@PayCalendarId,@Year,11, 30, @DailyHourMinute, @PayrollConfigurationRef)

			SET @PayCalendarId = @PayCalendarId + 1
			IF (@Year = 1391)
			BEGIN
				INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
				VALUES(@PayCalendarId,@Year, 12, 30, @DailyHourMinute, @PayrollConfigurationRef)
			END
			ELSE
			BEGIN
				INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, Year,Month, Day, HourMinute, PayrollConfigurationRef)
				VALUES(@PayCalendarId,@Year, 12, 29, @DailyHourMinute, @PayrollConfigurationRef)
			END

			SET @PayCalendarId = @PayCalendarId + 1
			SET @Year = @Year + 1
		END
			-- Update FMK.IDGeneration
			--EXEC FMK.spGetNextId 'PAY.PayrollCalendar', @id, 100				
			DECLARE @MaxPayrollCalendarId INT
			SELECT @MaxPayrollCalendarId = MAX(PayrollCalendarId) FROM Pay.PayrollCalendar			
			EXEC FMK.[spSetLastId] 'PAY.PayrollCalendar', @MaxPayrollCalendarId
END

IF NOT EXISTS(SELECT 1 FROM PAY.DailyHourMinute)	
BEGIN
		
	INSERT INTO PAY.DailyHourMinute VALUES	(1,@PayrollConfigurationRef,1388,@DailyHourMinute)
	INSERT INTO PAY.DailyHourMinute VALUES	(2,@PayrollConfigurationRef,1389,@DailyHourMinute)
	INSERT INTO PAY.DailyHourMinute VALUES	(3,@PayrollConfigurationRef,1390,@DailyHourMinute)
	INSERT INTO PAY.DailyHourMinute VALUES	(4,@PayrollConfigurationRef,1391,@DailyHourMinute)
	INSERT INTO PAY.DailyHourMinute VALUES	(5,@PayrollConfigurationRef,1392,@DailyHourMinute)
	-- Update FMK.IDGeneration
	EXEC FMK.[spSetLastId] 'PAY.DailyHourMinute', 5
	
	IF EXISTS (SELECT 1 FROM SYS.columns WHERE	OBJECT_ID = OBJECT_ID('PAY.PayrollConfiguration') AND
												[NAME] = 'DailyHourMinute')
	BEGIN
		EXEC('ALTER TABLE PAY.PayrollConfiguration DROP COLUMN DailyHourMinute')
	END
END



---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 88 Èå 89
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 707000
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 614800

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 9090000
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 7905600

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 4375000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 4166667

---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 89 Èå 90
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 770700
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 707000

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 9909000
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 9090000

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 4850000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 4375000

---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 90 Èå 91
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 909300
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 770700

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 11691000
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 9909000

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 5500000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 4850000

------------------
UPDATE PAY.Element 
SET CalculateForMinBase = 1
WHERE ElementId = 147

---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 91 Èå 92
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 1136625
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 909300

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 14613750
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 11691000

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 8333333
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 5500000.0000
---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 92 Èå 93
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 1420790
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 1136625

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 18267300
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 14613750

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 10000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 8333333.0000
---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 93 Èå 94
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 1662297
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 1420790

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 21372390
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 18267300

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 11500000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 10000000.0000
---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 94 Èå 95
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 1895054
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 1662297

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 24364980
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 21372390

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 13000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 11500000
---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 95 Èå 96
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 2169839
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 1895054

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 27897930
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 24364980

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 20000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 13000000

---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 96 Èå 97

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 2592961
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 2169839

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 33338070
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 27897930
UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 23000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 20000000

---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 97 Èå 98

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 3539389
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 2592961

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 45506430
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 33338070
UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 27500000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 23000000


---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 98 Èå 99

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 4282663
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 3539389

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 55062810
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 45506430
UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 30000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 27500000

---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí  æ ÓÞÝ Èíãå ÏÑ ÊíÑ ÓÇá 99 ÈäÇÈÑ ÈÎÔäÇãå
UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 4457663
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 4282663

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 57312810
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 55062810

---------- Èå ÑæÒ ÑÓÇäí ÓÞÝ ÚíÏí æ ãÚÇÝíÊ ãÇáíÇÊí ÚíÏí æ ÓÞÝ Èíãå ÇÒ ÓÇá 99 Èå 1400

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 6196155
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 4457663

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 79664850
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 57312810
UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 40000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 30000000

--------- تغييرات حداقل حقوق و بيمه و ماليات عيدي از سال 1400 به 1401

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 9752750
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 6196155

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 125392500
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 79664850
UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 56000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 40000000

--------- تغييرات حداقل حقوق و بيمه و ماليات عيدي از سال 1401 به 1402

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 12385996
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 9752750

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 159248520
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 125392500

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 100000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 56000000

--------- تغييرات حداقل حقوق و بيمه و ماليات عيدي از سال 1402 به 1403

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 16721096
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 12385996

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 214985520
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 159248520

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 120000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 100000000

--------- تغييرات حداقل حقوق و بيمه و ماليات عيدي از سال 1403 به 1404

UPDATE PAY.PayrollConfiguration
SET
TopDailyInsurance = 24245592
WHERE
ISNULL(TopDailyInsurance,0) = 0 OR TopDailyInsurance = 16721096

UPDATE PAY.PayrollConfiguration
SET
TopNewYearBonus  = 311729040
WHERE
ISNULL(TopNewYearBonus,0) = 0 OR TopNewYearBonus = 214985520

UPDATE PAY.PayrollConfiguration
SET
NonTaxableNewYearBonus = 240000000
WHERE
ISNULL(NonTaxableNewYearBonus,0) = 0 OR NonTaxableNewYearBonus = 120000000

/**********************************
**********
**********	Duplicated from InsertDefaultElementStaticdataProvider
**********
**********************************/



	/* UPDATE PAY.ELEMENT  ================================================================*/
IF EXISTS (SELECT 1 FROM PAY.Element WHERE ElementId = 117)
BEGIN	
	UPDATE PAY.Element SET Class = 2 ,InsuranceCoverage = 1,Taxable = 1, DenominatorsType = 2,Denominators = null
	WHERE ElementId = 117
END

	/* INSERT PAY.ELEMENTITEM  ================================================================*/
--DELETE FROM PAY.ElementItem
------------ ElementRef = 97
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 97)
BEGIN
	exec PAY.spInsertDefaultElementItem 7287, 97, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7288, 97, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7289, 97, 121, -1, 1	
END	
------------ ElementRef = 98	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 98)
BEGIN
	exec PAY.spInsertDefaultElementItem 7290, 98, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7291, 98, 119, 1, 2
END 
------------ ElementRef = 99	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 99)
BEGIN
	exec PAY.spInsertDefaultElementItem 7292, 99, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7293, 99, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7294, 99, 121, -1, 1
END 
------------ ElementRef = 137	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 137)
BEGIN
	exec PAY.spInsertDefaultElementItem 7295, 137, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7296, 137, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7297, 137, 121, -1, 1
END 
------------ ElementRef = 138	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 138)
BEGIN
	exec PAY.spInsertDefaultElementItem 7298, 138, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7299, 138, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7300, 138, 121, -1, 1
END 
------------ ElementRef = 139	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 139)
BEGIN
	exec PAY.spInsertDefaultElementItem 7301, 139, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7302, 139, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7303, 139, 121, -1, 1
END 
------------ ElementRef = 100	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 100)
BEGIN
	exec PAY.spInsertDefaultElementItem 7304, 100, 100, 1, 4 
	exec PAY.spInsertDefaultElementItem 7305, 100, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7306, 100, 121, -1, 1 
	exec PAY.spInsertDefaultElementItem 7307, 100, 129, 1, 1
END 
------------ ElementRef = 140	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 140)
BEGIN
	exec PAY.spInsertDefaultElementItem 7308, 140, 140, 1, 4 
	exec PAY.spInsertDefaultElementItem 7309, 140, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7310, 140, 121, -1, 1
END 
------------ ElementRef = 141	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 141)
BEGIN
	exec PAY.spInsertDefaultElementItem 7311, 141, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7312, 141, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7313, 141, 121, -1, 1
END 
------------ ElementRef = 101	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 101)
BEGIN
	exec PAY.spInsertDefaultElementItem 7314, 101, 101, 1, 4 
	exec PAY.spInsertDefaultElementItem 7315, 101, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7316, 101, 121, -1, 1
END 
------------ ElementRef = 102	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 102)
BEGIN
	exec PAY.spInsertDefaultElementItem 7317, 102, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7318, 102, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7319, 102, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7320, 102, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7321, 102, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7322, 102, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7323, 102, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7324, 102, 122, 1, 2
END 
------------ ElementRef = 103	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 103)
BEGIN
	exec PAY.spInsertDefaultElementItem 7325, 103, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7326, 103, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7327, 103, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7328, 103, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7329, 103, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7330, 103, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7331, 103, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7332, 103, 123, 1, 2 
END	
------------ ElementRef = 142	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 142)
BEGIN
	exec PAY.spInsertDefaultElementItem 7333, 142, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7334, 142, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7335, 142, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7336, 142, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7337, 142, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7338, 142, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7339, 142, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7340, 142, 124, 1, 1
END 
------------ ElementRef = 143	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 143)
BEGIN
	exec PAY.spInsertDefaultElementItem 7341, 143, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7342, 143, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7343, 143, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7344, 143, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7345, 143, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7346, 143, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7347, 143, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7348, 143, 125, 1, 2 
END
------------ ElementRef = 105	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 105)
BEGIN
	exec PAY.spInsertDefaultElementItem 7349, 105, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7350, 105, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7351, 105, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7352, 105, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7353, 105, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7354, 105, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7355, 105, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7356, 105, 126, 0.1, 1 
	exec PAY.spInsertDefaultElementItem 7357, 105, 127, 0.15, 1 
	exec PAY.spInsertDefaultElementItem 7358, 105, 128, 0.225, 1
	exec PAY.spInsertDefaultElementItem 8031, 105, 152, 0.35, 1
END
------------ ElementRef = 144	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 144)
BEGIN
	exec PAY.spInsertDefaultElementItem 7359, 144, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7360, 144, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7361, 144, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7362, 144, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7363, 144, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7364, 144, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7365, 144, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7366, 144, 151, 1, 3
END 
------------ ElementRef = 107	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 107)
BEGIN
	exec PAY.spInsertDefaultElementItem 7367, 107, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7368, 107, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7369, 107, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7370, 107, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7371, 107, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7372, 107, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7373, 107, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7374, 107, 131, 1, 3
END 
------------ ElementRef = 108	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 108)
BEGIN
	exec PAY.spInsertDefaultElementItem 7375, 108, 132, 1, 1
END 
------------ ElementRef = 147	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 147)
BEGIN
	exec PAY.spInsertDefaultElementItem 7376, 147, 150, 1, 1
END 
------------ ElementRef = 110	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 110)
BEGIN
	exec PAY.spInsertDefaultElementItem 7377, 110, 110, 1, 4
END 
------------ ElementRef = 149	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 149)
BEGIN
	exec PAY.spInsertDefaultElementItem 7378, 149, 149, 1, 4
END 
------------ ElementRef = 112	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 112)
BEGIN
	exec PAY.spInsertDefaultElementItem 7379, 112, 112, 1, 4
END 
------------ ElementRef = 113	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 113)
BEGIN
	exec PAY.spInsertDefaultElementItem 7380, 113, 97, 1, 4 
	exec PAY.spInsertDefaultElementItem 7381, 113, 98, 1, 4 
	exec PAY.spInsertDefaultElementItem 7382, 113, 99, 1, 4 
	exec PAY.spInsertDefaultElementItem 7383, 113, 137, 1, 4 
	exec PAY.spInsertDefaultElementItem 7384, 113, 138, 1, 4 
	exec PAY.spInsertDefaultElementItem 7385, 113, 139, 1, 4 
	exec PAY.spInsertDefaultElementItem 7386, 113, 141, 1, 4 
	exec PAY.spInsertDefaultElementItem 7387, 113, 120, 1, 2
END 
------------ ElementRef = 115	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 115)
BEGIN
	exec PAY.spInsertDefaultElementItem 7388, 115, 115, 1, 4
END 
------------ ElementRef = 116	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 116)
BEGIN
	exec PAY.spInsertDefaultElementItem 7389, 116, 116, 1, 4
END
------------ ElementRef = 117	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 117)
BEGIN
	exec PAY.spInsertDefaultElementItem 7390, 117, 117, 1, 4 
	exec PAY.spInsertDefaultElementItem 7391, 117, 118, 1, 1 
	exec PAY.spInsertDefaultElementItem 7392, 117, 121, -1, 1
END 
------------ ElementRef = 500	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 500)
BEGIN
	exec PAY.spInsertDefaultElementItem 8000, 500, 500, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8001, 500, 118, 1.0000, 1
	exec PAY.spInsertDefaultElementItem 8002, 500, 121, -1.0000, 1
END 
------------ ElementRef = 501	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 501)
BEGIN
	exec PAY.spInsertDefaultElementItem 8003, 501, 501, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8004, 501, 118, 1.0000, 1
	exec PAY.spInsertDefaultElementItem 8005, 501, 121, -1.0000, 1
END 
------------ ElementRef = 502	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 502)
BEGIN
	exec PAY.spInsertDefaultElementItem 8006, 502, 502, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8007, 502, 118, 1.0000, 1
	exec PAY.spInsertDefaultElementItem 8008, 502, 121, -1.0000, 1
END 
------------ ElementRef = 503	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 503)
BEGIN
	exec PAY.spInsertDefaultElementItem 8009, 503, 503, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8010, 503, 118, 1.0000, 1
	exec PAY.spInsertDefaultElementItem 8011, 503, 121, -1.0000, 1
END 
------------ ElementRef = 504	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 504)
BEGIN
	exec PAY.spInsertDefaultElementItem 8012, 504, 504, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8013, 504, 118, 1.0000, 1
	exec PAY.spInsertDefaultElementItem 8014, 504, 121, -1.0000, 1
END 
------------ ElementRef = 505	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 505)
BEGIN
	exec PAY.spInsertDefaultElementItem 8015, 505, 505, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8016, 505, 118, 1.0000, 1
	exec PAY.spInsertDefaultElementItem 8017, 505, 121, -1.0000, 1
END 
------------ ElementRef = 512	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 512)
BEGIN
	exec PAY.spInsertDefaultElementItem 8018, 512, 512, 1.0000, 4
END 
------------ ElementRef = 513	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 513)
BEGIN
	exec PAY.spInsertDefaultElementItem 8019, 513, 513, 1.0000, 4
END 
------------ ElementRef = 514	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 514)
BEGIN
	exec PAY.spInsertDefaultElementItem 8020, 514, 514, 1.0000, 4
END 
------------ ElementRef = 515	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 515)
BEGIN
	exec PAY.spInsertDefaultElementItem 8021, 515, 515, 1.0000, 4
END 
------------ ElementRef = 516	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 516)
BEGIN
	exec PAY.spInsertDefaultElementItem 8022, 516, 516, 1.0000, 4
END
------------ ElementRef = 517	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 517)
BEGIN
	exec PAY.spInsertDefaultElementItem 8023, 517, 517, 1.0000, 4
END 
------------ ElementRef = 524	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 524)
BEGIN
	exec PAY.spInsertDefaultElementItem 8025, 524, 524, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8026, 524, 118, 1.0000, 1
END 
------------ ElementRef = 525	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 525)
BEGIN
	exec PAY.spInsertDefaultElementItem 8027, 525, 525, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8028, 525, 118, 1.0000, 1
END 
------------ ElementRef = 526	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 526)
BEGIN
	exec PAY.spInsertDefaultElementItem 8029, 526, 526, 1.0000, 4
	exec PAY.spInsertDefaultElementItem 8030, 526, 118, 1.0000, 1
END 

	--newly added: 5659
------------ ElementRef = 603	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 603)
BEGIN
	exec PAY.spInsertDefaultElementItem 9000, 603, 603, 1, 4 
	exec PAY.spInsertDefaultElementItem 9001, 603, 600, 1, 1
END 
------------ ElementRef = 604	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 604)
BEGIN
	exec PAY.spInsertDefaultElementItem 9002, 604, 604, 1, 4 
	exec PAY.spInsertDefaultElementItem 9003, 604, 601, 1, 1
END 
------------ ElementRef = 605	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 605)
BEGIN
	exec PAY.spInsertDefaultElementItem 9004, 605, 605, 1, 4 
	exec PAY.spInsertDefaultElementItem 9005, 605, 602, 1, 1
END
------------ ElementRef = 606	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 606)
BEGIN
	exec PAY.spInsertDefaultElementItem 9006, 606, 606, 1, 4
END
------------ ElementRef = 607	
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 607)
BEGIN
	exec PAY.spInsertDefaultElementItem 9007, 607, 607, 1, 4
END
------------ ElementRef = 608
IF NOT EXISTS(SELECT * FROM PAY.ElementItem where ElementRef = 608)
BEGIN
	exec PAY.spInsertDefaultElementItem 9008, 608, 608, 1, 4 
END

	DECLARE @id1 int
    Select @id1 = Max(ElementItemId) from PAY.ElementItem
    if @id1 < 10000
		EXEC FMK.spGetNextId 'PAY.ElementItem', @id1, 10000

	/* END OF INSERT PAY.ELEMENTITEM  ================================================================*/



IF NOT EXISTS (SELECT 1 FROM Pay.PayrollConfigurationElement WHERE PayrollConfigurationElementId < 100)
BEGIN

	exec Pay.spInsertConfigurationElement 43, 118, 1.0000 ,7, 7
	exec Pay.spInsertConfigurationElement 44 ,121, -1.0000 , 7, 7
	exec Pay.spInsertConfigurationElement 45 ,119,  1.0000 , 7, 7
	exec Pay.spInsertConfigurationElement 46 ,129,  1.0000 , 7, 7
	exec Pay.spInsertConfigurationElement 47 ,130, -1.0000 , 7, 7
	exec Pay.spInsertConfigurationElement 48 ,118,  1.0000 , 1, 7
	exec Pay.spInsertConfigurationElement 49 ,121, -1.0000 , 1, 7
	exec Pay.spInsertConfigurationElement 50 ,119,  1.0000 , 1, 7
	exec Pay.spInsertConfigurationElement 52 ,130, -1.0000 , 1, 7
	exec Pay.spInsertConfigurationElement 53 ,97,  1.0000 , 2, 7
	exec Pay.spInsertConfigurationElement 54 ,99,  1.0000 , 2, 7
	exec Pay.spInsertConfigurationElement 55 ,137,  1.0000 , 2, 7
	exec Pay.spInsertConfigurationElement 56 ,139,  1.0000 , 2, 7
	exec Pay.spInsertConfigurationElement 57 ,118,  1.0000 , 3, 7
	exec Pay.spInsertConfigurationElement 58 ,121, -1.0000 , 3, 7
	exec Pay.spInsertConfigurationElement 59 ,119,  1.0000 , 3, 7
	exec Pay.spInsertConfigurationElement 60 ,129,  1.0000 , 3, 7
	exec Pay.spInsertConfigurationElement 61 ,130, -1.0000 , 3, 7
	exec Pay.spInsertConfigurationElement 62 ,97,  1.0000 , 4, 7
	exec Pay.spInsertConfigurationElement 63 ,99,  1.0000 , 4, 7
	exec Pay.spInsertConfigurationElement 64 ,137,  1.0000 , 4, 7
	exec Pay.spInsertConfigurationElement 65 ,139,  1.0000 , 4, 7
	exec Pay.spInsertConfigurationElement 66 ,118,  1.0000 , 5, 7
	exec Pay.spInsertConfigurationElement 67 ,121, -1.0000 , 5, 7
	exec Pay.spInsertConfigurationElement 68 ,119,  1.0000 , 5, 7
	exec Pay.spInsertConfigurationElement 69 ,129,  1.0000 , 5, 7
	exec Pay.spInsertConfigurationElement 70 ,130, -1.0000 , 5, 7
	exec Pay.spInsertConfigurationElement 71 ,97,  1.0000 , 6, 7
	exec Pay.spInsertConfigurationElement 73 ,99,  1.0000 , 6, 7
	exec Pay.spInsertConfigurationElement 74 ,137,  1.0000 , 6, 7
	exec Pay.spInsertConfigurationElement 75 ,139,  1.0000 , 6, 7

	EXEC FMK.spGetNextId 'PAY.PayrollConfigurationElement', @id, 100
END 
---------- Èå ÑæÒ ÑÓÇäí ãÚÇÝíÊ Èíãå Óåã ßÇÑãäÏ ÇÒ ãÇáíÇÊ 1400
UPDATE PAY.PayrollConfiguration
SET NonTaxableSocialSecurityPercent = 1.0000
WHERE ISNULL(NonTaxableSocialSecurityPercent,0) = 0 OR NonTaxableSocialSecurityPercent = 0.2857
-----------------------------
UPDATE PAY.PayrollConfiguration
SET HealthInsurancePercent = 1.0000
WHERE HealthInsurancePercent IS NULL