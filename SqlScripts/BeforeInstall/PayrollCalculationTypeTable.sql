IF NOT EXISTS(SELECT * FROM SYS.TABLE_TYPES WHERE NAME = 'PayrollCalculationTypeTable ')
	CREATE TYPE Pay.PayrollCalculationTypeTable AS TABLE
	(
		[CalculationType] [int] NULL
	)