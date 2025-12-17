If Object_ID('CNT.vwContract') Is Not Null
	Drop View CNT.vwContract
GO
CREATE VIEW CNT.vwContract
AS
SELECT        C.ContractID,   
              C.DocumentNumber,   
              C.Date,   
              C.Title,   
              C.Title_En,   
              P.DLRef AS ContractorDLRef,   
              C.ContractorPartyRef,   
              P.Name + ' ' + P.LastName AS ContractorFullName,   
              PD.Code AS ContractorDLCode, PD.Title AS ContractorDLTitle,   
              PD.Title_En AS ContractorDLTitle_En,   
              C.EndDate,   
              C.StartDate,   
              C.Location, C.Cost,   
              C.EstimatedCost,   
              C.ContractTypeRef,   
              CNT.ContractType.Title AS ContractTypeTitle,   
              C.DLRef,   
              D.Code AS DLCode,   
              D.Title AS DLTitle,   
              D.Title_En AS DLTitle_En,   
              CNT.ContractType.Title_En AS ContractTypeTitle_En,   
              C.AllowedChangePercent,   
              C.Established,   
              ISNULL(pr.PreReceiptPrice,0) DepositSum,   
              C.MaterialSum,   
              ISNULL(pr.PreReceiptPrice,0)- ISNULL(ConfirmedSt.PreReceipt, 0) AS RemainingDeposit,   
              C.MaterialSum - ISNULL(ConfirmedSt.Material, 0) AS RemainingMaterial,   
              C.DepositDepreciationPercent,   
              C.Description,   
              C.Description_En,   
              C.Version,   
              C.Creator,   
              C.CreationDate,   
              C.LastModifier,   
              C.LastModificationDate,   
              C.FiscalYearRef,   
              C.ContractRowNumber,   
              C.ContractDLType,   
              (SELECT COUNT(StatusID) FROM CNT.Status WHERE ContractRef = C.ContractID) AS StatusCount,   
              C.ProjectRef,   
              PJ.Code AS ProjectCode,   
              PJ.Title AS ProjectTitle,   
              PJ.Title_En AS ProjectTitle_En,   
              C.NeedsBillSerial,   
              C.TenderRef,   
              T.DocumentNumber AS TenderNumber,   
              T.Date AS TenderDate,   
              T.Title TenderTitle,   
              T.Title_En TenderTitle_En,   
              C.CancelDate,   
              C.Type,   
              C.ChangeAmountType,   
              C.PrimaryFee,   
              C.ChangeAmount,        
              CASE (ISNULL(C.ChangeAmountType, -1))   
                WHEN 1   
                  THEN C.PrimaryFee * C.ChangeAmount / 100   
                WHEN 2   
                  THEN - 1 * C.PrimaryFee * C.ChangeAmount / 100   
                WHEN 3   
                  THEN C.ChangeAmount   
                WHEN 4   
                  THEN - 1 * C.ChangeAmount   
                WHEN 5   
                  THEN C.ChangeAmount - C.PrimaryFee   
    WHEN -1  
      THEN 0  
              END AS ChangeFee,   
              C.PrimaryFee + CASE (ISNULL(C.ChangeAmountType, -1))   
                               WHEN 1   
                                 THEN C.PrimaryFee * C.ChangeAmount / 100   
                               WHEN 2   
                                 THEN - 1 * C.PrimaryFee * C.ChangeAmount / 100   
                               WHEN 3   
                                 THEN C.ChangeAmount   
                               WHEN 4   
                                 THEN - 1 * C.ChangeAmount  
                               WHEN 5   
                                 THEN C.ChangeAmount - C.PrimaryFee   
          WHEN -1  
         THEN 0  
                             END AS FinalCost,                 
     C.ContractRef,   
     ISNULL(C.ContractRef, C.ContractID) MainContractRef,   
              C.RowNumber,   
              C.AffectedChange,   
              C.AnnexDocumentNumber,   
              C.AnnexDate,   
              C.Nature,  
     C.IsActive,  
     ISNULL(ConfirmedSt.ConfirmedCost,0) ConfirmedStatusCost,   
     C.ParentContractRef, PC.DocumentNumber ParentContractNumber,  
     (select  (select max(Contractid) From cnt.contract Where isnull(contractref, contractid) = isnull(CC.contractref, CC.contractid)) LastParentContractRef  
         From cnt.Contract CC  
         Where Contractid = C.ParentContractRef) MainParentContractRef  
  
FROM   CNT.Contract  AS C   
  INNER JOIN      (SELECT        ContractRef, MAX(RowNumber) AS MaxRow  
                   FROM            CNT.Contract  
                   WHERE        (ContractRef IS NOT NULL)  
                   GROUP BY ContractRef)            AS a  ON C.ContractRef = a.ContractRef AND C.RowNumber = a.MaxRow   
  INNER JOIN            CNT.Project                 AS PJ ON PJ.ProjectID = C.ProjectRef                                
  INNER JOIN            ACC.DL                      AS D  ON D.DLId = C.DLRef   
  INNER JOIN            GNR.Party                   AS P  ON C.ContractorPartyRef = P.PartyId   
  INNER JOIN            ACC.DL                      AS PD ON P.DLRef = PD.DLId   
  INNER JOIN            CNT.ContractType                  ON C.ContractTypeRef = CNT.ContractType.ContractTypeID   
  LEFT OUTER JOIN       (SELECT ContractRef, SUM(ISNULL(PreReceipt,0)) AS PreReceipt, SUM(ISNULL(Material,0)) AS Material, SUM(ISNULL(ConfirmedCost,0)) AS ConfirmedCost  FROM CNT.Status   WHERE  ConfirmationState = 2 /*Confirmed*/ GROUP BY ContractRef) AS
 ConfirmedSt ON ConfirmedSt.ContractRef = C.ContractID  
  LEFT OUTER JOIN       CNT.Tender                  AS T  ON C.TenderRef = T.TenderID  
     left OUTER JOIN CNt.Contract PC On pc.ContractId = C.ParentContractRef  
  LEft OUter Join (select ContractRef,sum(ISNULL(Price, 0)) PreReceiptPrice
					 from cnt.ContractprereceiptItem
					 Group by ContractRef)PR On C.ContractID = pr.ContractRef

  
GROUP BY C.ContractID, C.DocumentNumber, C.Date, C.Title, C.Title_En, P.DLRef, D.Code, D.Title, D.Title_En, C.ContractorPartyRef, PD.Code, PD.Title, PD.Title_En, C.EndDate, C.StartDate, C.Location, C.Cost, C.EstimatedCost,   
                         C.ContractTypeRef, CNT.ContractType.Title, C.DLRef, CNT.ContractType.Title_En, C.AllowedChangePercent, C.Established,  C.MaterialSum, C.Description, C.Description_En, C.Version, C.Creator,   
                         C.CreationDate, C.LastModifier, C.LastModificationDate, C.ContractRowNumber, P.Name, P.LastName, C.DepositDepreciationPercent, C.FiscalYearRef, C.ProjectRef, C.ContractDLType, PJ.Code,   
                         PJ.Title, PJ.Title_En, C.NeedsBillSerial, C.TenderRef, T.DocumentNumber, T.Date, C.CancelDate,   
       C.Type, C.ChangeAmountType, C.PrimaryFee, C.ChangeAmount, C.ContractRef, C.RowNumber, T.Title, T.Title_En, C.AffectedChange, C.AnnexDocumentNumber, C.AnnexDate, C.Nature, C.IsActive,  
       ConfirmedSt.PreReceipt ,ConfirmedSt.Material ,ConfirmedSt.ConfirmedCost,  C.ParentContractRef, PC.DocumentNumber ,ISNULL(pr.PreReceiptPrice,0) 
  
UNION  
  
SELECT               C.ContractID,   
            C.DocumentNumber,   
      C.Date,   
      C.Title,   
      C.Title_En,   
      P.DLRef AS ContractorDLRef,   
      C.ContractorPartyRef, P.Name + ' ' + P.LastName AS ContractorFullName,   
      PD.Code AS ContractorDLCode,   
      PD.Title AS ContractorDLTitle,   
                     PD.Title_En AS ContractorDLTitle_En,  
      C.EndDate,   
      C.StartDate,   
      C.Location,   
      C.Cost,   
      C.EstimatedCost,   
      C.ContractTypeRef,   
      CNT.ContractType.Title AS ContractTypeTitle,   
      C.DLRef,   
      D.Code AS DLCode,   
      D.Title AS DLTitle,   
                     D.Title_En AS DLTitle_En,   
      CNT.ContractType.Title_En AS ContractTypeTitle_En,   
      C.AllowedChangePercent,   
      C.Established,   
      ISNULL(pr.PreReceiptPrice,0) DepositSum,   
      C.MaterialSum,  
      ISNULL(pr.PreReceiptPrice,0) - ISNULL(ConfirmedSt.PreReceipt, 0) AS RemainingDeposit,   
      C.MaterialSum - ISNULL(ConfirmedSt.Material, 0) AS RemainingMaterial,  
                     C.DepositDepreciationPercent,   
      C.Description,   
      C.Description_En, C.Version,   
      C.Creator, C.CreationDate, C.LastModifier, C.LastModificationDate,   
      C.FiscalYearRef,   
      C.ContractRowNumber,   
      C.ContractDLType,   
                     (SELECT COUNT(StatusID) FROM CNT.Status WHERE ContractRef = C.ContractID) AS StatusCount,    
      C.ProjectRef,   
      PJ.Code AS ProjectCode,  
      PJ.Title AS ProjectTitle,   
      PJ.Title_En AS ProjectTitle_En,   
      C.NeedsBillSerial,   
      C.TenderRef,   
      T.DocumentNumber AS TenderNumber,   
                     T.Date AS TenderDate,   
      T.Title TenderTitle,   
      T.Title_En TenderTitle_En,   
      C.CancelDate,   
      C.Type,   
      C.ChangeAmountType,   
      C.PrimaryFee,   
      C.ChangeAmount, 0 AS ChangeFee,   
                     C.Cost AS FinalCost,   
      C.ContractRef,   
      ISNULL(C.ContractRef, C.ContractID) MainContractRef,   
      C.RowNumber,   
      C.AffectedChange,   
      C.AnnexDocumentNumber,   
      C.AnnexDate,   
      C.Nature,  
      C.IsActive,  
      ISNULL(ConfirmedSt.ConfirmedCost,0) ConfirmedStatusCost,  
       C.ParentContractRef, PC.DocumentNumber ParentContractNumber,     (select  (select max(Contractid) From cnt.contract Where isnull(contractref, contractid) = isnull(CC.contractref, CC.contractid)) LastParentContractRef  
         From cnt.Contract CC  
         Where Contractid = C.ParentContractRef) MainParentContractRef  
  
  
FROM            CNT.Contract AS C   
      INNER JOIN        CNT.Project AS PJ ON PJ.ProjectID = C.ProjectRef   
      INNER JOIN        ACC.DL AS D ON D.DLId = C.DLRef   
      INNER JOIN        GNR.Party AS P ON C.ContractorPartyRef = P.PartyId   
      INNER JOIN        ACC.DL AS PD ON P.DLRef = PD.DLId   
      INNER JOIN        CNT.ContractType ON C.ContractTypeRef = CNT.ContractType.ContractTypeID   
   LEFT OUTER JOIN   (SELECT ContractRef, SUM(ISNULL(PreReceipt,0)) AS PreReceipt, SUM(ISNULL(Material,0)) AS Material, SUM(ISNULL(ConfirmedCost,0)) AS ConfirmedCost  FROM CNT.Status   WHERE  ConfirmationState = 2 /*Confirmed*/ GROUP BY ContractRef) AS ConfirmedSt ON ConfirmedSt.ContractRef = C.ContractID  
      LEFT OUTER JOIN   CNT.Tender AS T ON C.TenderRef = T.TenderID  
   left OUTER JOIN CNt.Contract PC On pc.ContractId = C.ParentContractRef  
     LEft OUter Join (select ContractRef,sum(ISNULL(Price, 0)) PreReceiptPrice
					 from cnt.ContractprereceiptItem
					 Group by ContractRef)PR On C.ContractID = pr.ContractRef

WHERE        (C.ContractRef IS NULL) AND (C.ContractID NOT IN  
                             (SELECT        ContractRef  
                                FROM            (SELECT    ContractID, ContractRef, MAX(RowNumber) AS MaxRow  
                                                 FROM            CNT.Contract  
                                                 WHERE        (ContractRef IS NOT NULL)  
                                                 GROUP BY ContractRef, ContractID) AS a))  
GROUP BY C.ContractID, C.DocumentNumber, C.Date, C.Title, C.Title_En, P.DLRef, D.Code, D.Title, D.Title_En, C.ContractorPartyRef, PD.Code, PD.Title, PD.Title_En, C.EndDate, C.StartDate, C.Location, C.Cost, C.EstimatedCost,   
                         C.ContractTypeRef, CNT.ContractType.Title, C.DLRef, CNT.ContractType.Title_En, C.AllowedChangePercent, C.Established,  C.MaterialSum, C.Description, C.Description_En, C.Version, C.Creator,   
                         C.CreationDate, C.LastModifier, C.LastModificationDate, C.ContractRowNumber, P.Name, P.LastName, C.DepositDepreciationPercent, C.FiscalYearRef, C.ProjectRef,   
                         C.ContractDLType, PJ.Code, PJ.Title, PJ.Title_En, C.NeedsBillSerial, C.TenderRef, T.DocumentNumber, T.Date, C.CancelDate,   
       C.Type, C.ChangeAmountType, C.PrimaryFee, C.ChangeAmount, C.ContractRef, C.RowNumber, T.Title, T.Title_En, C.AffectedChange, C.AnnexDocumentNumber, C.AnnexDate, C.Nature, C.IsActive,  
       ConfirmedSt.PreReceipt ,ConfirmedSt.Material ,ConfirmedSt.ConfirmedCost, C.ParentContractRef, PC.DocumentNumber  ,ISNULL(pr.PreReceiptPrice,0)
  
         
         
       