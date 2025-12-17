IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('PAY.Personnel') AND
				[name] = 'BirthDate') AND
   EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Party') AND
				[name] = 'BirthDate')
BEGIN

	
	EXECUTE('UPDATE GNR.Party
		    SET BirthDate = Pnl.BirthDate
		    FROM GNR.Party P
				INNER JOIN PAY.Personnel Pnl ON P.PartyId = Pnl.PartyRef')

	EXECUTE('ALTER TABLE [PAY].[Personnel]  DROP COLUMN [BirthDate]')

END