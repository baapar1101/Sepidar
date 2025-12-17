IF Object_ID('GNR.spCreateTaxpayerBillInsertQuery') IS NOT NULL
    DROP PROCEDURE GNR.spCreateTaxpayerBillInsertQuery
GO
CREATE PROCEDURE GNR.spCreateTaxpayerBillInsertQuery (
    @ID int,
    @query NVARCHAR(MAX) OUTPUT)
AS
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM GNR.TaxPayerBill WHERE TaxPayerBillId = @ID)
    BEGIN
        PRINT 'wrong id!'
        RETURN
    END

    DECLARE @res NVARCHAR(MAX), @itemid INT;
    
    EXEC GNR.spGetInsertQueryForRow 'GNR', 'TaxPayerBill', @ID, @res OUTPUT;
    SET @query = @res

    DECLARE itemcursor CURSOR FOR
        SELECT TaxPayerBillItemId
        FROM GNR.TaxPayerBillItem
        WHERE TaxPayerBillRef = @ID

    OPEN itemcursor
    FETCH NEXT FROM itemcursor INTO @itemid

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC GNR.spGetInsertQueryForRow 'GNR', 'TaxPayerBillItem', @itemid, @res OUTPUT;
        SET @query = @query + @res

        FETCH NEXT FROM itemcursor INTO @itemid
    END

    CLOSE itemcursor
    DEALLOCATE itemcursor
END
GO
