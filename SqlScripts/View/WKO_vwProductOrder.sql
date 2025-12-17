IF Object_ID('WKO.vwProductOrder') IS NOT NULL
	Drop View WKO.vwProductOrder
GO

CREATE VIEW [WKO].[vwProductOrder]
AS
	SELECT P.*,
		   CASE 
				WHEN P.[ActualQuantity] = 0 THEN 0 
				ELSE CONVERT([decimal](19,4), (ISNULL(P.[Cost],0) / P.[ActualQuantity]))
		   END AS [CostPerUnit],
		   P.[ActualQuantity] + ISNULL(P.[WastageQuantity], 0) + ISNULL(P.[AbNormalWastageQuantity], 0) AS [ActualAndWastageQuantity],
		   CASE
				WHEN (P.[ActualQuantity] + P.[AbNormalWastageQuantity]) = 0 THEN 0
				ELSE CONVERT([decimal](19,4), (ISNULL(P.[BOMCost], 0) / (P.[ActualQuantity] + P.[AbNormalWastageQuantity])))
		   END AS [BOMRate],
		   CASE
				WHEN (P.[ActualQuantity] + P.[AbNormalWastageQuantity]) = 0 THEN 0
				ELSE CONVERT([decimal](19,4), (ISNULL(P.[EstimatedLabourCost], 0) / (P.[ActualQuantity] + P.[AbNormalWastageQuantity])))
		   END AS [EstimatedLabourRate],
		   CASE
				WHEN (P.[ActualQuantity] + P.[AbNormalWastageQuantity]) = 0 THEN 0
				ELSE CONVERT([decimal](19,4), (ISNULL(P.[IndirectMaterialsCost], 0) / (P.[ActualQuantity] + P.[AbNormalWastageQuantity])))
		   END AS [IndirectMaterialsRate],
		   CASE
				WHEN (P.[ActualQuantity] + P.[AbNormalWastageQuantity]) = 0 THEN 0
				ELSE CONVERT([decimal](19,4),(ISNULL(P.[EstimatedOverheadCost], 0) / (P.[ActualQuantity] + P.[AbNormalWastageQuantity])))
		   END AS [EstimatedOverheadRate]
	FROM (
		SELECT  
			PO.[ProductOrderID] ,PO.[Number] ,PO.[Date] ,
			PO.[BaseProductOrderRef], BPO.[Number] AS BaseProductOrderNumber,
			PO.[CostCenterRef] ,CC.DLRef CostCenterDLRef,DL.Title AS CostCenterDLTitle, DL.Title_En AS CostCenterDLTitle_En,DL.Code AS CostCenterDLCode,
			PO.[ProductRef] ,I.Code ProductCode,I.Title ProductTitle,I.Title_En ProductTitle_En,
			PO.[ProductFormulaRef] ,PF.Code ProductFormulaCode,PF.Title ProductFormulaTitle, PF.Quantity ProductFormulaQuantity,
			PO.ProductFormulaUnitRef,U.Title ProductFormulaUnitTitle,U.Title_En ProductFormulaUnitTitle_En,
			PO.[CustomerPartyRef] ,DL2.Code CustomerPartyDLCode,DL2.Title CustomerPartyDLTitle,DL2.Title_En CustomerPartyTitle_En,
			PO.[Quantity] , 

			ISNULL((
			    SELECT SUM(ActualQ.Quantity)
			    FROM (
			        SELECT 
			            CASE 
			                WHEN PO.ProductFormulaUnitRef = I.UnitRef 
			                    THEN IRI.Quantity - SUM(ISNULL(RIRI.Quantity, 0))
			                ELSE IRI.SecondaryQuantity - SUM(ISNULL(RIRI.SecondaryQuantity, 0))
			            END AS Quantity
			        FROM INV.InventoryReceiptItem IRI
			        LEFT JOIN INV.InventoryReceiptItem RIRI 
			            ON RIRI.IsReturn = 1 AND RIRI.ReturnBase = IRI.InventoryReceiptItemID
			        LEFT JOIN INV.InventoryReceipt IR2 
			            ON IR2.InventoryReceiptID = RIRI.InventoryReceiptRef
			        INNER JOIN INV.InventoryReceipt IR 
			            ON IR.InventoryReceiptID = IRI.InventoryReceiptRef
			        WHERE 
			            IRI.IsReturn = 0
			            AND IRI.ProductOrderRef = PO.ProductOrderID
			            AND IR.IsWastage = 0
			            AND (RIRI.InventoryReceiptItemID IS NULL OR IR2.IsWastage = 0)
			        GROUP BY 
			            IRI.InventoryReceiptItemID,
			            IRI.Quantity,
			            IRI.SecondaryQuantity
			    ) AS ActualQ
			), 0) AS ActualQuantity,


			ISNULL((
			    SELECT SUM(AbWastage.Quantity)
			    FROM (
			        SELECT 
			            CASE 
			                WHEN PO.ProductFormulaUnitRef = I.UnitRef 
			                    THEN IRI.Quantity - SUM(ISNULL(RIRI.Quantity, 0))
			                ELSE IRI.SecondaryQuantity - SUM(ISNULL(RIRI.SecondaryQuantity, 0))
			            END AS Quantity
			        FROM INV.InventoryReceiptItem IRI
			        LEFT JOIN INV.InventoryReceiptItem RIRI 
			            ON RIRI.IsReturn = 1 AND RIRI.ReturnBase = IRI.InventoryReceiptItemID
			        LEFT JOIN INV.InventoryReceipt IR2 
			            ON IR2.InventoryReceiptID = RIRI.InventoryReceiptRef
			        INNER JOIN INV.InventoryReceipt IR 
			            ON IR.InventoryReceiptID = IRI.InventoryReceiptRef
			        WHERE 
			            IRI.IsReturn = 0
			            AND IRI.ProductOrderRef = PO.ProductOrderID
			            AND IR.IsWastage = 1
			            --AND (RIRI.InventoryReceiptItemID IS NULL OR IR2.IsWastage = 1)
			        GROUP BY 
			            IRI.InventoryReceiptItemID,
			            IRI.Quantity,
			            IRI.SecondaryQuantity
			    ) AS AbWastage
			), 0) AS [AbNormalWastageQuantity],


			PO.[WastageQuantity],PO.[State] ,
			--PO.[AbNormalWastageQuantity],
			--PO.AbNormalWastageStockRef,STK.[Code] AS AbNormalWastageStockCode,STK.[Title] AS AbNormalWastageStockTitle,STK.[Title_En] AS AbNormalWastageStockTitle_En,

			BPO.[RemainingBOMCost] AS TransferedBOMCost,
			PO.[BOMCost],
			PO.[RemainingBOMCost],
			CONVERT([decimal](19,4),
        CASE
            WHEN CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)) = 0
            THEN 0
            ELSE ((ISNULL(PO.[BOMCost],0) / (CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)))) * 100)
        END, 0) AS BOMPercent,
			CurrentYearBOMCost = CASE WHEN PO.BOMCost IS NOT NULL THEN
									PO.BOMCost + ISNULL(PO.RemainingBOMCost ,0) - ISNULL(BPO.[RemainingBOMCost] /*TransferedBOMCost*/,0)
								 END,			
			PO.[EstimatedLabourCost] ,PO.[EstimatedOverheadCost] ,PO.[Cost],			
			CONVERT([decimal](19,4),
        CASE
            WHEN CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)) = 0
            THEN 0
            ELSE ((ISNULL(PO.[EstimatedLabourCost],0) / (CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)))) * 100)
        END, 0) AS EstimatedLabourPercent,
			CONVERT([decimal](19,4),
        CASE
            WHEN CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)) = 0
            THEN 0
            ELSE ((ISNULL(PO.[EstimatedOverheadCost],0) / (CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)))) * 100)
        END, 0) AS EstimatedOverheadPercent ,
		CONVERT([decimal](19,4),
		CASE
            WHEN CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)) = 0
            THEN 0
            ELSE ((ISNULL(PO.[IndirectMaterialsCost],0) / (CONVERT([decimal](19,4), ISNULL(PO.[IndirectMaterialsCost],0) + ISNULL(PO.[BOMCost],0) + ISNULL(PO.[EstimatedLabourCost],0) + ISNULL(PO.[EstimatedOverheadCost],0)))) * 100)
        END, 0) AS IndirectMaterialsPercent ,
		PO.IndirectMaterialsCost,
		QOT.Number AS [BaseQuotationItemNumber] , PO.BaseQuotationItemRef,
		I.TracingCategoryRef,
		--PO.TracingRef,
		PO.TracingTitle,
			PO.[FiscalYearRef] ,
			PO.[CanTransferNextPeriod] , PO.[IsInitial] ,	
			PO.[Creator] ,	PO.[CreationDate] ,PO.[LastModifier] ,PO.[LastModificationDate] ,PO.[Version],
			PF.EstimatedLabour ProductFormulaEstimatedLabour, PF.EstimatedOverhead ProductFormulaEstimatedOverhead,
            POP.Number AS ProdcutOperationNumber
		FROM WKO.ProductOrder PO
			INNER JOIN GNR.CostCenter CC ON CC.CostCenterId = PO.CostCenterRef		
			INNER JOIN ACC.DL AS DL ON CC.DLRef = DL.DLId  
			INNER JOIN INV.Item I ON I.ItemID = PO.ProductRef		
			INNER JOIN INV.Unit U ON U.UnitID = PO.ProductFormulaUnitRef
			LEFT JOIN WKO.ProductFormula PF ON PF.ProductFormulaID = PO.ProductFormulaRef
			LEFT OUTER JOIN GNR.Party AS P ON PO.CustomerPartyRef = P.PartyId 
			LEFT OUTER JOIN ACC.DL AS DL2 ON P.DLRef = DL2.DLId 
			LEFT OUTER JOIN WKO.ProductOrder BPO ON BPO.ProductOrderID = PO.BaseProductOrderRef
			--LEFT OUTER JOIN INV.Stock STK ON STK.StockID = PO.AbNormalWastageStockRef
			LEFT OUTER JOIN SLS.QuotationItem QIT ON QIT.QuotationItemID = PO.BaseQuotationItemRef
			LEFT OUTER JOIN SLS.Quotation QOT ON QOT.QuotationID = QIT.QuotationRef
            LEFT OUTER JOIN WKO.ProductOperationItem POPI ON POPI.ProductOrderRef = PO.ProductOrderID
            LEFT OUTER JOIN WKO.ProductOperation POP ON POP.ProductOperationID = POPI.ProductOperationRef
			--LEFT OUTER JOIN INV.Tracing AS T ON PO.TracingRef = T.TracingID
			) P 
GO
