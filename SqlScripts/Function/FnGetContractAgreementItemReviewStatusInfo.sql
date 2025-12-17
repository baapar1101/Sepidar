IF OBJECT_ID('CNT.FnGetContractAgreementItemReviewStatusInfo') IS NOT NULL
    DROP FUNCTION CNT.FnGetContractAgreementItemReviewStatusInfo
GO

CREATE FUNCTION CNT.FnGetContractAgreementItemReviewStatusInfo (@AgreementItemId INT)
RETURNS @StatusItems TABLE (
    Quantity DECIMAL(19, 4),
    Price DECIMAL(19, 4),
    ConfirmedQuantity DECIMAL(19, 4),
    ConfirmedPrice DECIMAL(19, 4)
)
AS
BEGIN
    WITH AggrementItems AS (
        SELECT CA.ContractAgreementItemID, CA.ContractAgreementItemRef
        FROM CNT.ContractAgreementItem CA
        WHERE CA.ContractAgreementItemID = @AgreementItemId
        
        UNION ALL

        SELECT CA.ContractAgreementItemID, CA.ContractAgreementItemRef
        FROM AggrementItems AI
        INNER JOIN CNT.ContractAgreementItem CA ON AI.ContractAgreementItemRef IS NOT NULL AND  CA.ContractAgreementItemID = AI.ContractAgreementItemRef
    )
    INSERT INTO @StatusItems
    SELECT
        SUM (CASE WHEN ISNULL(S.StatusRefType,0) = 3 THEN -1 * ISNULL(SI.Quantity, 0) ELSE ISNULL(SI.Quantity, 0) END) AS Quantity,
        SUM (CASE WHEN ISNULL(S.StatusRefType,0) = 3 THEN -1 * ISNULL(SI.Price, 0) ELSE ISNULL(SI.Price, 0) END) AS Price,
        SUM (CASE WHEN ISNULL(S.StatusRefType,0) = 3 THEN -1 * ISNULL(SI.ConfirmedQuantity, 0) ELSE ISNULL(SI.ConfirmedQuantity, 0) END) AS ConfirmedQuantity,
        SUM (CASE WHEN ISNULL(S.StatusRefType,0) = 3 THEN -1 * ISNULL(SI.ConfirmedPrice, 0) ELSE ISNULL(SI.ConfirmedPrice, 0) END) AS ConfirmedPrice
    FROM CNT.StatusItem SI
    INNER JOIN CNT.Status S ON SI.StatusRef = S.StatusID
    WHERE SI.ContractAgreementItemRef IN (
        SELECT ContractAgreementItemID
        FROM AggrementItems )
		AND S.ConfirmationState <> 3
    RETURN
END
GO