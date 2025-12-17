BEGIN TRANSACTION TR
BEGIN TRY
    DECLARE @LastFiscalYearID INT = (SELECT TOP 1 FiscalYearId FROM FMK.FiscalYear ORDER BY EndDate DESC)
    
    IF EXISTS (SELECT * FROM FMK.[Version] WHERE Major = 5 AND Minor = 6 AND Build = 6)
    BEGIN
        WITH states AS
        (
            SELECT ReceiptChequeRef, RCH.[State]
            FROM RPA.ReceiptChequeHistory rch
            INNER JOIN RPA.ReceiptCheque RC ON RCH.ReceiptChequeRef = RC.ReceiptChequeId
            INNER JOIN RPA.ReceiptHeader RH ON RC.ReceiptHeaderRef = RH.ReceiptHeaderId
            WHERE NOT EXISTS (SELECT TOP 1 1 FROM rpa.ReceiptChequeHistory irch WHERE irch.ReceiptChequeHistoryRef = rch.ReceiptChequeHistoryId)
                AND RH.FiscalYearRef = @LastFiscalYearID
        )
        UPDATE rc
        SET rc.[State] = States.[State]
        FROM states INNER JOIN rpa.ReceiptCheque rc ON states.ReceiptChequeRef = rc.ReceiptChequeId
        WHERE rc.[State] <> states.[State];
        
        WITH states AS
        (
            SELECT PaymentChequeRef, RCH.[State]
            FROM rpa.PaymentChequeHistory rch
            INNER JOIN RPA.PaymentCheque RC ON RCH.PaymentChequeRef = RC.PaymentChequeId
            INNER JOIN RPA.PaymentHeader RH ON RC.PaymentHeaderRef = RH.PaymentHeaderId
            WHERE NOT EXISTS (SELECT TOP 1 1 FROM rpa.PaymentChequeHistory irch WHERE irch.PaymentChequeHistoryRef = rch.PaymentChequeHistoryId)
                AND RH.FiscalYearRef = @LastFiscalYearID
        )
        UPDATE rc
        SET rc.[State] = States.[State]
        FROM states INNER JOIN rpa.PaymentCheque rc ON states.PaymentChequeRef = rc.PaymentChequeId
        WHERE rc.[State] <> states.[State];
    END
    COMMIT TRANSACTION TR
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION TR
END CATCH
