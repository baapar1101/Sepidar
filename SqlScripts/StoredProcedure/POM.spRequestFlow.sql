IF Object_ID('POM.spRequestFlow') IS NOT NULL
    DROP PROCEDURE POM.spRequestFlow
GO
CREATE PROCEDURE POM.spRequestFlow (
        @ItemRequestItemId int
       ,@PurchaseRequestItemId int
    )
AS

BEGIN
-- ItemRequestItem = 10
-- PurchaseRequestItem = 11
-- PerformaItem = 12
-- PurchaseOrderItem = 13
-- InventoryPurchaseInvoiceItem = 14
-- ServiceInventoryPurchaseInvoiceItem = 15
-- AssetInventoryPurchaseInvoiceItem = 16
-- ImportPurchaseInvoiceItem = 17

-- DECLARE @ItemRequestItemId int, @PurchaseRequestItemId int
-- SELECT @ItemRequestItemId = -1, @PurchaseRequestItemId = -1


;WITH
AllItems (EntityId, EntityType, Id, ParentId, Quantity, State, Number, Date, LastAcceptorId, LastAcceptDate, PurchasingProcedure, PurchasingAgentPartyRef, ValidityDate, VendorDLRef, OrderDLRef)
AS
(
SELECT EntityId                = IR.ItemRequestID
     , EntityType              = 10 -- ItemRequestItem = 10
     , Id                      = (IRI.ItemRequestItemID * 100) + 10
     , ParentId                = NULL
     , Quantity                = IRI.Quantity
     , State                   = IR.State
     , Number                  = IR.Number
     , Date                    = IR.Date
     , LastAcceptorId          = IR.LastAcceptor
     , LastAcceptDate          = IR.LastAcceptDate
     , PurchasingProcedure     = NULL
     , PurchasingAgentPartyRef = NULL
     , ValidityDate            = NULL
     , VendorDLRef             = NULL
     , OrderDLRef              = NULL
FROM POM.ItemRequestItem IRI
JOIN POM.ItemRequest IR ON IRI.ItemRequestRef = IR.ItemRequestID

UNION ALL

SELECT EntityId                = PR.PurchaseRequestID
     , EntityType              = 11 -- PurchaseRequestItem = 11
     , Id                      = (PRI.PurchaseRequestItemId * 100) + 11
     , ParentId                = CASE
                                     WHEN PRI.ItemRequestItemRef IS NOT NULL THEN (PRI.ItemRequestItemRef * 100) + 10 -- ItemRequestItem = 10
                                 END
     , Quantity                = PRI.Quantity
     , State                   = PR.State
     , Number                  = PR.Number
     , Date                    = PR.Date
     , LastAcceptorId          = PR.LastAcceptor
     , LastAcceptDate          = PR.LastAcceptDate
     , PurchasingProcedure     = PR.PurchasingProcedure
     , PurchasingAgentPartyRef = PR.PurchasingAgentPartyRef
     , ValidityDate            = NULL
     , VendorDLRef             = NULL
     , OrderDLRef              = NULL
FROM POM.PurchaseRequestItem PRI
JOIN POM.PurchaseRequest PR ON PRI.PurchaseRequestRef = PR.PurchaseRequestID

UNION ALL

SELECT EntityId                = P.PerformaID
     , EntityType              = 12 -- PerformaItem = 12
     , Id                      = (PI.PerformaItemId * 100) + 12
     , ParentId                = CASE
                                     WHEN PI.PurchaseRequestItemRef IS NOT NULL THEN (PI.PurchaseRequestItemRef * 100) + 11 -- PurchaseRequestItem = 11
                                 END
     , Quantity                = PI.Quantity
     , State                   = P.State
     , Number                  = P.Number
     , Date                    = P.Date
     , LastAcceptorId          = NULL
     , LastAcceptDate          = NULL
     , PurchasingProcedure     = NULL
     , PurchasingAgentPartyRef = P.PurchasingAgentPartyRef
     , ValidityDate            = P.ValidityDate
     , VendorDLRef             = P.VendorDLRef
     , OrderDLRef              = NULL
FROM POM.PerformaItem PI
JOIN POM.Performa P ON PI.PerformaRef = P.PerformaID
WHERE PI.PurchaseRequestItemRef IS NOT NULL

UNION ALL

SELECT EntityId                = PO.PurchaseOrderId
     , EntityType              = 13 -- PurchaseOrderItem = 13
     , Id                      = (POI.PurchaseOrderItemId * 100) + 13
     , ParentId                = CASE
                                     WHEN POI.BasePurchaseRequestItemRef IS NOT NULL THEN (POI.BasePurchaseRequestItemRef * 100) + 11 -- PurchaseRequestItem = 11
                                     WHEN POI.BasePerformaItemRef IS NOT NULL THEN (POI.BasePerformaItemRef * 100) + 12 -- PerformaItem = 12
                                 END
     , Quantity                = POI.Quantity
     , State                   = PO.State
     , Number                  = PO.Number
     , Date                    = PO.Date
     , LastAcceptorId          = NULL
     , LastAcceptDate          = NULL
     , PurchasingProcedure     = NULL
     , PurchasingAgentPartyRef = PO.PurchasingAgentPartyRef
     , ValidityDate            = NULL
     , VendorDLRef             = PO.VendorDLRef
     , OrderDLRef              = PO.DLRef
FROM POM.PurchaseOrderItem POI
JOIN POM.PurchaseOrder PO ON POI.PurchaseOrderRef = PO.PurchaseOrderID
WHERE BasePurchaseRequestItemRef IS NOT NULL OR BasePerformaItemRef IS NOT NULL

UNION ALL

SELECT EntityId                = IPI.InventoryPurchaseInvoiceID
     , EntityType              = CASE
                                     WHEN [Type] = 1 THEN 14 -- InventoryPurchaseInvoiceItem = 14
                                     WHEN [Type] = 2 THEN 15 -- ServiceInventoryPurchaseInvoiceItem = 15
                                     WHEN [Type] = 3 THEN 16 -- AssetInventoryPurchaseInvoiceItem = 16
                                 END
     , Id                      = CASE
                                     WHEN [Type] = 1 THEN (IPII.InventoryPurchaseInvoiceItemId * 100) + 14 -- InventoryPurchaseInvoiceItem = 14
                                     WHEN [Type] = 2 THEN (IPII.InventoryPurchaseInvoiceItemId * 100) + 15 -- ServiceInventoryPurchaseInvoiceItem = 15
                                     WHEN [Type] = 3 THEN (IPII.InventoryPurchaseInvoiceItemId * 100) + 16 -- AssetInventoryPurchaseInvoiceItem = 16
                                 END
     , ParentId                = (IPII.PurchaseOrderItemRef * 100) + 13 -- PurchaseOrderItem = 13
     , Quantity                = IPII.Quantity
     , State                   = NULL
     , Number                  = IPI.Number
     , Date                    = IPI.Date
     , LastAcceptorId          = NULL
     , LastAcceptDate          = NULL
     , PurchasingProcedure     = NULL
     , PurchasingAgentPartyRef = IPI.PurchasingAgentPartyRef
     , ValidityDate            = NULL
     , VendorDLRef             = IPI.VendorDLRef
     , OrderDLRef              = NULL
FROM INV.InventoryPurchaseInvoiceItem IPII
JOIN INV.InventoryPurchaseInvoice IPI ON IPI.InventoryPurchaseInvoiceID = IPII.InventoryPurchaseInvoiceRef
WHERE IPII.PurchaseOrderItemRef IS NOT NULL

UNION ALL

SELECT EntityId                = PI.PurchaseInvoiceID
     , EntityType              = 17 -- ImportPurchaseInvoiceItem = 17
     , Id                      = (PII.PurchaseInvoiceItemId * 100) + 17
     , ParentId                = (PII.PurchaseOrderItemRef * 100) + 13 -- PurchaseOrderItem = 13
     , Quantity                = PII.Quantity
     , State                   = NULL
     , Number                  = PI.Number
     , Date                    = PI.Date
     , LastAcceptorId          = NULL
     , LastAcceptDate          = NULL
     , PurchasingProcedure     = NULL
     , PurchasingAgentPartyRef = PI.PurchasingAgentPartyRef
     , ValidityDate            = NULL
     , VendorDLRef             = PI.VendorDLRef
     , OrderDLRef              = NULL
FROM POM.PurchaseInvoiceItem PII
JOIN POM.PurchaseInvoice PI ON PII.PurchaseInvoiceRef = PI.PurchaseInvoiceID
WHERE PII.PurchaseOrderItemRef IS NOT NULL
)
,Hierarchy
AS
(
SELECT EntityId
     , EntityType
     , Id
     , ParentId = NULL
     , Quantity
     , State
     , Number
     , Date
     , LastAcceptorId
     , LastAcceptDate
     , PurchasingProcedure
     , PurchasingAgentPartyRef
     , ValidityDate
     , VendorDLRef
     , OrderDLRef
FROM AllItems
WHERE (@ItemRequestItemId = -1 OR  ((@ItemRequestItemId * 100) + 10) = Id)
  AND (@PurchaseRequestItemId = -1 OR ((@PurchaseRequestItemId * 100) + 11) = Id)

UNION ALL
--  Recursive query
SELECT AL.*
FROM AllItems AL
JOIN Hierarchy H ON AL.ParentId = H.Id
)

SELECT H.EntityId
     , H.EntityType
     , EntityTypeForIcons = H.EntityType - 10
     , EntityName = ''
     , EntityTitle = ''
     , H.Id
     , H.ParentId
     , H.Quantity
     , H.State
     , StateTitle = ''
     , H.Number
     , H.Date
     , H.LastAcceptorId
     , LastAcceptorName = U.Name
     , H.LastAcceptDate
     , H.PurchasingProcedure
     , PurchasingProcedureTitle = ''
     , H.PurchasingAgentPartyRef
     , PurchasingAgentPartyDlTitle = ADl.Title
     , H.ValidityDate
     , H.VendorDLRef
     , VendorDLTitle = VDl.Title
     , H.OrderDLRef
     , OrderDLTitle = ODl.Title
FROM Hierarchy H
LEFT JOIN ACC.DL VDl ON VDl.DLId = H.VendorDLRef
LEFT JOIN ACC.DL ODl ON ODl.DLId = H.OrderDLRef
LEFT JOIN GNR.Party P ON P.PartyId = H.PurchasingAgentPartyRef
LEFT JOIN ACC.DL ADl ON ADl.DLId = P.DLRef
LEFT JOIN FMK.[User] U ON U.UserID = H.LastAcceptorId

END

GO