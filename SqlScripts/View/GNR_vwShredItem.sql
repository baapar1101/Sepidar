If Object_ID('GNR.vwShredItem') Is Not Null
	Drop View GNR.vwShredItem
GO
CREATE VIEW GNR.vwShredItem
AS
SELECT     SI.ShredItemID, SI.ShredRef, SI.RowNumber, SI.UsanceDate, SI.Amount, 
                      SI.InterestAmount, SI.PenaltyAmount, SI.Status, SI.PaymentRef, 
                      RPA.PaymentHeader.Number AS PaymentNumber
                      ,ISNULL(SI.ReceiptRef,CASE WHEN SI.PartySettlementRef IS NOT NULL THEN PSI.CreditEntityRef ELSE NULL END) AS ReceiptRef
                      ,RPA.ReceiptHeader.Number AS ReceiptNumber 
                      ,SI.PaymentDate
                      ,SI.PartySettlementRef
                      ,CASE WHEN S.[Key] = 1 /*Invoice*/  THEN PS.Number ELSE NULL END AS PartySettlementNumber
                      ,SI.IsPaid, SI.PaidDate, SI.PaidDesc

FROM              GNR.ShredItem SI
  INNER JOIN      GNR.Shred S ON S.ShredID = SI.ShredRef
  LEFT OUTER JOIN RPA.PartyAccountSettlement PS ON SI.PartySettlementRef =  PS.PartyAccountSettlementID
  LEFT OUTER JOIN RPA.PartyAccountSettlementItem PSI ON PSI.PartyAccountSettlementRef = PS.PartyAccountSettlementID AND PSI.CreditEntityType = 23 /*Receipt*/
  LEFT OUTER JOIN RPA.PaymentHeader ON RPA.PaymentHeader.PaymentHeaderId = SI.PaymentRef 
  LEFT OUTER JOIN RPA.ReceiptHeader ON RPA.ReceiptHeader.ReceiptHeaderId =
									   CASE 
										 WHEN SI.PartySettlementRef IS NOT NULL 
										 THEN   PSI.CreditEntityRef
										 ELSE SI.ReceiptRef
										END

