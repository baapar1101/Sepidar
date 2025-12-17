If Object_ID('CNT.vwStatus') Is Not Null
    Drop View CNT.vwStatus
GO
CREATE VIEW CNT.vwStatus
AS
SELECT            S.StatusID,
                  S.Nature, 
                  S.[Date], 
                  S.Number, 
                  S.ContractRef, 
                  S.[Type], 
                  S.StatusRef, 
                  S.StatusRefType,
                  CASE WHEN ISNULL(s.StatusRefType,0) = 3 then -1 ELSE 1 END StatusCoef,
                  S.CurrentCost, 
                  S.ConfirmedCost, 
                  S.BillSerial,
                  ISNULL(Total2, 0) + (CASE WHEN S.ConfirmationState = 2 THEN S.ConfirmedCost ELSE 0 END) AS Cost,
                  S.Material, 
                  S.PreReceipt, 
                  S.ConfirmationState, 
                  S.ConfirmationDate, 
                  S.PreStatusPrice,
                  Remained =
                   (S.ConfirmedCost) -
                                (SUM(ISNULL(OnAccount.Price,0)) )+
                                ((ISNULL(CoInf.price,0))+ SUM(ISNULL(PreCoInf.price,0))) + 
                                (SUM(ISNULL(Vat.price,0))) + 
                                (SUM(ISNULL(Duty.price, 0))) -
                                (SUM(ISNULL(InSurance.price,0))) - 
                                (SUM(ISNULL(Tax.price,0))) -
                                (SUM(ISNULL(GoodJob.price,0))) -
                                ((ISNULL(CoDec.Price,0)) + SUM(ISNULL(PreCoDec.Price,0))) -
                                (S.Material) -
                                (S.PreReceipt),
                  
                  NotSettled =
                 (S.ConfirmedCost) -
                                (SUM(ISNULL(OnAccount.Price,0)))+
                                ((ISNULL(CoInf.price,0)) + SUM(ISNULL(PreCoInf.price,0))) + 
                                (SUM(ISNULL(Vat.price,0))) + 
                                (SUM(ISNULL(Duty.price, 0))) -
                                (SUM(ISNULL(InSurance.price,0))) - 
                                (SUM(ISNULL(Tax.price,0))) -
                                (SUM(ISNULL(GoodJob.price,0))) -
                                ((ISNULL(CoDec.Price,0)) + SUM(ISNULL(PreCoDec.Price,0))) -
                                (S.Material) -
                                (S.PreReceipt)-
                                ISNULL(settlement.Settled, 0) - 
                                ISNULL(S.InitialSettledValue,0),
                  settlement.Settled + ISNULL(S.InitialSettledValue,0) Settled,
                  settlement.MaxSettledDate, 
                  S2.Number AS [PreStatusNumber],
                  S2.[Date] AS [PreStatusDate],
                  ISNULL(Total2,0) AS [PreStatusCost],
                  C.DLCode AS [ContractDLCode], 
                  C.[Date] AS [ContractDate], 
                  C.ContractorPartyRef,C.DLRef AS [ContractDLRef], 
                  C.Title AS [ContractTitle], 
                  C.Title_En AS [ContractTitle_En], 
                  C.FinalCost AS [ContractFinalCost],
                  C.RemainingDeposit, 
                  C.RemainingMaterial,
                  P.DLRef AS [ContractorDlRef], 
                  ACC.DL.Code AS [ContractorDlCode],
                  ACC.DL.Title AS [ContractorDlTitle], 
                  ACC.DL.Title_En AS [ContractorDlTitle_En], 
                  S.Established,
                  S.VoucherRef, 
                  V.Number AS [VoucherNumber], 
                  V.[Date] AS [VoucherDate],
                  S.[Version], 
                  S.Creator, 
                  S.CreationDate, 
                  S.LastModifier, 
                  S.LastModificationDate, 
                  S.FiscalYearRef, 
                  S.InitialSettledValue,
                  S.SLRef, 
                  A.FullCode AS [SLCode], 
                  A.Title AS [SLTitle], 
                  A.Title_En AS [SLTitle_En],
                  S.SLDebitCreditRef,
                  AB.FullCode AS [SLDebitCreditCode], 
                  AB.Title AS [SLDebitCreditTitle], 
                  AB.Title_En AS [SLDebitCreditTitle_En],
                  -- REGION "required for Status BIll Report only"
                  C.ContractorFullName AS [ContractorFullName], 
                  P.EconomicCode AS [ContractorEconomicCode],
                  P.IdentificationCode AS [ContractorIdentificationCode],
                  (SELECT TOP 1 Phone       FROM GNR.PartyPhone   WHERE (P.PartyId = PartyRef) AND (Type = 1)) AS ContractorPhone, 
                  S.PartyAddressRef,
                  CASE
                    WHEN S.PartyAddressRef IS NOT NULL THEN PA.[Address]
                    ELSE (SELECT TOP 1 [Address]  FROM GNR.PartyAddress WHERE (P.PartyId = PartyRef) ORDER BY IsMain DESC, PartyAddressId)
                  END AS ContractorAddress,
                  CASE
                    WHEN S.PartyAddressRef IS NOT NULL THEN PA.ZipCode
                    ELSE (SELECT TOP 1 [ZipCode]  FROM GNR.PartyAddress WHERE (P.PartyId = PartyRef) ORDER BY IsMain DESC, PartyAddressId)
                  END AS ContractorZipCode,
                  CASE
                    WHEN S.PartyAddressRef IS NOT NULL THEN PA.BranchCode
                    ELSE (SELECT TOP 1 [BranchCode]  FROM GNR.PartyAddress WHERE (P.PartyId = PartyRef) ORDER BY IsMain DESC, PartyAddressId)
                  END AS ContractorBranchCode,
                  PA.Address AS PartyAddress,
                  PA.ZipCode AS PartyZipCode,
                  PA.BranchCode AS PartyBranchCode,
                  CCI.[Percent] AS [ContractVATPercent],
                  CCIDuty.[Percent] AS [ContractDutyPercent],
                  C.[NeedsBillSerial], 
                  C.[DocumentNumber] AS [ContractNumber],
                  S.[TaxPayerBillIssueDateTime],
				  S.SettlementType
                  -- ENDREGION
                  ,PreReceiptPercent = CASE WHEN S.ConfirmedCost <> 0 THEN ROUND(S.PreReceipt * 100 / S.ConfirmedCost , 2) End,
                   (ISNULL(CoInf.price,0)) + SUM(ISNULL(PreCoInf.price,0)) IncCoef, 
                   SUM(ISNULL(Vat.price,0)) Vat,
                   SUM(ISNULL(Duty.price, 0)) Duty,
                   SUM(ISNULL(InSurance.price,0)) InSurance,
                   SUM(ISNULL(Tax.price,0)) Tax,
                   SUM(ISNULL(GoodJob.price,0)) GoodJob,
                   (ISNULL(CoDec.Price,0))+ SUM(ISNULL(PreCoDec.Price,0)) DecCoef,
                   SUM(ISNULL(OnAccount.Price, 0)) OnAccountReport,
                   (ISNULL(CoInf.price,0)) + SUM(ISNULL(PreCoInf.price,0)) IncCoefReport,
                   SUM(ISNULL(Vat.price,0)) VatReport,
                   SUM(ISNULL(Duty.price, 0)) DutyReport,
                   SUM(ISNULL(InSurance.price,0)) InSuranceReport,
                   SUM(ISNULL(Tax.price,0)) TaxReport,
                   SUM(ISNULL(GoodJob.price,0)) GoodJobReport, 
                   (ISNULL(CoDec.Price,0))+ SUM(ISNULL(PreCoDec.Price,0)) DecCoefReport
				   ,CASE
                        WHEN MainTPB.StatusRef IS NULL THEN 0
                        ELSE 1
                    END AS HasSendedMainBill 

FROM      (SELECT *  , (SELECT SUM(S3.ConfirmedCost) 
                        From CNT.[Status] AS [S3] 
                        WHERE S3.ConfirmationState = 2 /*Confirmed*/ 
                          AND S3.[Date] <= S2.[Date]
                          AND S3.StatusId <> S2.StatusId
                          AND S3.StatusRefType = S2.StatusRefType 
                          AND S3.ContractRef = S2.ContractRef
                        ) Total2 
           FROM CNT.[Status] AS [S2])           AS [S]                                                  INNER JOIN
           -----------------------------------------------------------------------------------------------------
           ACC.vwAccount                 AS A              ON S.SLRef = A.AccountId           LEFT JOIN
           ACC.vwAccount                 AS AB             ON S.SLDebitCreditRef = AB.AccountId     INNER JOIN
           -----------------------------------------------------------------------------------------------------
           CNT.vwContract                AS C              ON S.ContractRef = C.ContractID     INNER JOIN
           -----------------------------------------------------------------------------------------------------
           GNR.Party                     AS P              ON C.ContractorPartyRef = P.PartyId INNER JOIN   -- required for Status Bill Report only
           ---------------------------------------------------------------------------------------------------
           ACC.DL                                          ON P.DLRef = ACC.DL.DLId            LEFT OUTER JOIN
           -----------------------------------------------------------------------------------------------------
           CNT.[Status]                    AS S2             ON S2.StatusID = S.StatusRef        LEFT OUTER JOIN
           -----------------------------------------------------------------------------------------------------
           ACC.Voucher                   AS V              ON S.VoucherRef = V.VoucherId       LEFT OUTER JOIN                      
           -----------------------------------------------------------------------------------------------------
           -- required for Status Bill Report only:           CoefficeintRef = -5: VAT Coefficient
           CNT.ContractCoefficientItem   AS CCI            ON CCI.ContractRef = C.ContractID 
                                                              AND CCI.CoefficientRef = -5      LEFT OUTER JOIN  
           -----------------------------------------------------------------------------------------------------
           -- CoefficeintRef = -6: Duty Coefficient
           CNT.ContractCoefficientItem   AS CCIDuty        ON CCIDuty.ContractRef = C.ContractID 
                                                              AND CCIDuty.CoefficientRef = -6  LEFT OUTER JOIN  
           -----------------------------------------------------------------------------------------------------
           (SELECT sti.StatusRef, SUM(sti.Amount) Settled, MAX(st.Date) MaxSettledDate 
            FROM CNT.Settlement st 
              JOIN CNT.SettlementItem sti ON st.SettlementID = sti.SettlementRef 
            GROUP BY sti.StatusRef)      AS settlement     ON settlement.StatusRef = S.StatusID

            --------------------------------------------------------------------------------------------------
            LEFT JOIN (Select StatusRef , Sum(ISNUll(Price,0)) price from   CNT.vwStatusCoefficientItem  
                        WHERE   (ContractCoefficientRef > 0  AND CofficientType = 1)
                        group by StatusRef)AS CoInf ON CoInf.StatusRef = S.StatusID  /*User Define Additive*/
            LEFT JOIN CNT.vwStatusCoefficientItem  AS PreCoInf ON PreCoInf.StatusRef = S.StatusID AND (PreCoInf.ContractCoefficientRef = -1000 /*Other*/ OR  PreCoInf.CoefficientRef = -1000 /*Other*/ OR PreCoInf.ContractCoefficientRef = -1500 /*Ownership*/)
            ----------------------------------------------------------------------------------------------------
            LEFT JOIN CNT.vwStatusCoefficientItem AS  Vat  ON Vat.StatusRef = S.StatusID AND (Vat.ContractCoefficientRef = -5 /*Vat*/ OR  PreCoInf.CoefficientRef = -5 OR Vat.ContractCoefficientRef = -504 )/*Ownership*/
            ----------------------------------------------------------------------------------------------------
            LEFT JOIN CNT.vwStatusCoefficientItem AS Duty  ON Duty.StatusRef = S.StatusID AND (Duty.ContractCoefficientRef = -6 /*Duty*/ OR Duty.CoefficientRef = -6 /*Duty*/ OR Duty.ContractCoefficientRef = -505)
            ----------------------------------------------------------------------------------------------------
            LEFT JOIN CNT.vwStatusCoefficientItem AS InSuRANCE ON InSuRANCE.StatusRef = S.StatusID AND (InSuRANCE.ContractCoefficientRef = -4 /*Insurance*/ OR InSuRANCE.CoefficientRef = -4 /*Insurance*/ OR InSuRANCE.ContractCoefficientRef = -503)
            ----------------------------------------------------------------------------------------------------
            LEFT JOIN CNT.vwStatusCoefficientItem AS Tax ON Tax.StatusRef = S.StatusID AND (Tax.ContractCoefficientRef = -2 /*Tax*/ OR Tax.CoefficientRef = -2 /*Tax*/ OR Tax.ContractCoefficientRef = -502)
            ----------------------------------------------------------------------------------------------------
            LEFT JOIN CNT.vwStatusCoefficientItem AS  GoodJob ON GoodJob.StatusRef = S.StatusID AND (GoodJob.ContractCoefficientRef = -1 /*GoodJob*/ OR GoodJob.CoefficientRef = -1 /*GoodJob*/ OR GoodJob.ContractCoefficientRef = -501)
            ----------------------------------------------------------------------------------------------------
            LEFT JOIN (SELECT StatusRef, SUM(ISNULL(Price, 0)) Price 
                       FROM  CNT.vwStatusCoefficientItem 
                       WHERE (ContractCoefficientRef > 0 AND CofficientType = 2 /*User define Reductive*/)
                       GROUP BY StatusRef )AS  CoDec ON CoDec.StatusRef = S.StatusID 
            LEFT JOIN CNT.vwStatusCoefficientItem AS  PreCoDec ON PreCoDec.StatusRef = S.StatusID AND (PreCoDec.ContractCoefficientRef = -1001 /*Other*/ OR PreCoDec.CoefficientRef = -1001 /*Other*/ OR  PreCoDec.ContractCoefficientRef = -1501) /*Ownership*/
            ----------------------------------------------------------------------------------------------------
            LEFT JOIN (SELECT StatusRef, SUM(ISNULL(Price, 0)) Price FROM CNT.StatusOnAccountItem GROUP BY StatusRef) OnAccount ON OnAccount.StatusRef = S.StatusID
            LEFT JOIN GNR.PartyAddress AS PA ON S.PartyAddressRef = PA.PartyAddressId
            ----------------------------------------------------------------------------------------------------
			LEFT JOIN (
		    SELECT
		        StatusRef
		    FROM GNR.TaxPayerBill
		    WHERE ActionTypeIns = 1
		      AND [State] = 4
		      AND StatusRef IS NOT NULL
		    GROUP BY
		        StatusRef
        ) AS MainTPB ON S.StatusID = MainTPB.StatusRef
            
  GROUP BY S.StatusID, S.Nature, S.[Date], S.Number, S.ContractRef, S.[Type], S.StatusRef, S.StatusRefType, S.CurrentCost, S.ConfirmedCost, S.BillSerial
            ,S.Total2, S2.ConfirmationState, S2.ConfirmedCost, S.Material, S.PreReceipt, S.ConfirmationState, S.ConfirmationDate,S.PreStatusPrice, settlement.Settled
            ,S.InitialSettledValue, settlement.MaxSettledDate, S2.Number, settlement.MaxSettledDate, S2.[Date], C.DLCode,
            C.[Date] ,C.ContractorPartyRef,C.DLRef,C.Title ,C.Title_En,C.FinalCost ,C.RemainingDeposit,C.RemainingMaterial,P.DLRef,ACC.DL.Title,ACC.DL.Code, 
            ACC.DL.Title_En,S.Established,S.VoucherRef, V.Number ,V.[Date],S.[Version],S.Creator,S.CreationDate, S.LastModifier, S.LastModificationDate, S.FiscalYearRef, 
            S.PartyAddressRef,S.SLRef, S.SLDebitCreditRef,A.FullCode,A.Title,A.Title_En ,C.ContractorFullName,P.EconomicCode ,P.IdentificationCode ,
            P.[PartyId],
            CCI.[Percent] ,
            CCIDuty.[Percent] ,
            C.[NeedsBillSerial], 
            C.[DocumentNumber],
            S.[TaxPayerBillIssueDateTime],
            CoDec.Price,
            CoInf.price,
            AB.FullCode,
            AB.Title,
            AB.Title_EN,
            PA.[Address],
            PA.ZipCode,
            PA.BranchCode,
			S.SettlementType,
			MainTPB.StatusRef