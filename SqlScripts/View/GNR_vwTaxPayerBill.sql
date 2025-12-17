IF OBJECT_ID('GNR.vwTaxPayerBill') IS NOT NULL
    DROP VIEW GNR.vwTaxPayerBill
GO
CREATE VIEW GNR.vwTaxPayerBill
AS
SELECT TPB.[TaxPayerBillId]
     , TPB.[InvoiceRef]
     , TPB.[ReturnedInvoiceRef]
     , TPB.[StatusRef]
     , TPB.[CustomsDeclarationRef]
     , TPB.[ExportServiceInvoiceRef]
     , TPB.[AssetSaleRef]
     , TPB.[FiscalYearRef]
     , TPB.[BaseTaxPayerBillRef]
     , TPB.[SubmitType]
     , TPB.[State]
     , TPB.[StateInWorkBook]
     , TPB.[ReferenceNumber]
     , TPB.[Uid]
     , TPB.[MotamedInno]
     , TPB.[IsEdited]
     , TPB.[EditDateTime]
	 , TPB.[IsFake]
	 , TPB.[IsUnknown]
	 , TPB.[MakingMethod]
	 , TPB.[PreviousState]
     , TPB.[BillNumber]
     , TPB.[BillNumberInno]
     , TPB.[IssueDateIndatim]
     , TPB.[CreationDateIndati2m]
     , TPB.[UniqueBillCodeTaxid]
     , TPB.[BaseUniqueBillCodeIrtaxid]
     , TPB.[ActionTypeIns]
     , TPB.[BillTypeInty]
     , TPB.[BillPatternInp]
     , TPB.[SellerEconomicCodeTins]
     , TPB.[CustomerPartyTypeTob]
     , TPB.[CustomerNationalCodeBid]
     , TPB.[CustomerEconomicCodeTinb]
     , TPB.[CustomerZipCodeBpc]
     , TPB.[CustomerBranchCodeBbc]
     , TPB.[CustomerPassportNumberBpn]
     , TPB.[CustomerContractUniqueCodeCrn]
     , TPB.[CottageNumberCdcn]
     , TPB.[CottageDateCdcd]
     , TPB.[SellerCustomsDeclarationCodeScc]
     , TPB.[TotalExportPriceTocv]
     , TPB.[TotalExportPriceInBaseCurrencyTorv]
     , TPB.[TotalNetWeightTonw]
     , TPB.[TotalDiscountTdis]
     , TPB.[TotalAmountBeforeDiscountTprdis]
     , TPB.[TotalAmountAfterDiscountTadis]
     , TPB.[TotalTaxTvam]
     , TPB.[TotalOtherTaxesAndAmountsTodam]
     , TPB.[TotalNetPriceTbill]
     , TPB.[SettlementTypeSetm]
     , TPB.[CashPaymentCap]
     , TPB.[ChequePaymentInsp]
     , TPB.[TotalVatShareTvop]
     , TPB.[SepidarVersion]
     , TPB.[Version]
     , TPB.[Creator]
     , TPB.[CreationDate]
     , TPB.[LastModifier]
     , TPB.[LastModificationDate]
     , TPB.[IndependentBatchNumber]
     , TPB.[RelatedVoucherType]
     , LastTaxPayerBillRef = null
     , IsStateChangedManually = CASE WHEN TPB.PreviousState IS NULL THEN 0 ELSE 1 END
	 , [I].[FiscalYearRef] AS [InvoiceFiscalYearRef]
	 , [IFY].[Title] AS [InvoiceFiscalYearTitle]
     , FY.Title AS FiscalYearTitle
     , BaseTPB.[MotamedInno] AS BaseBillMotamedInno
     , BaseTPB.[BillNumber] AS BaseBillNumber
     , BaseTPB.[BillNumberInno] AS BaseBillInno
     , BaseTPB.[IssueDateIndatim] AS BaseBillIssueDateTime
     , BaseTPB.[ActionTypeIns] AS BaseBillActionType
     , I.Number AS InvoiceNumber
     , RI.Number AS ReturnedInvoiceNumber
     , CD.Number AS CustomsDeclarationNumber
     , ESI.Number AS ExportServiceInvoiceNumber
     , ST.Number AS StatusNumber
     , ASTS.Number AS AssetSaleNumber
     , S.Title AS SaleType
     , CASE WHEN ST.StatusID IS NOT NULL THEN ST.ContractorDlCode ELSE P.DLCode END AS CustomerDLCode
     , CASE WHEN ST.StatusID IS NOT NULL THEN ST.ContractorDlTitle ELSE P.DLTitle END AS CustomerTitle
     , CASE WHEN ST.StatusID IS NOT NULL THEN ST.ContractorAddress ELSE A.Address END AS CustomerAddress
     , C.Title AS CurrencyTitle
     , StatusTax = CASE
                       WHEN TPB.StatusRef IS NULL THEN NULL
                       ELSE ISNULL(ST.Tax, 0) + ISNULL(ST.Vat, 0)
                   END
     , StatusConfirmedCost = CASE
                                 WHEN TPB.StatusRef IS NULL THEN NULL
                                 ELSE ST.ConfirmedCost
                             END
     , InvoiceTax = CASE
                        WHEN TPB.InvoiceRef IS NULL OR TPB.ActionTypeIns = 3 OR TPB.ActionTypeIns = 4 THEN NULL
                        ELSE ISNULL(I.TaxInBaseCurrency, 0) + ISNULL(I.DutyInBaseCurrency, 0)
                    END
     , InvoiceTotalAmountBeforeDiscount = CASE
                                              WHEN TPB.InvoiceRef IS NULL OR TPB.ActionTypeIns = 3 or TPB.ActionTypeIns = 4 THEN NULL
                                              ELSE ISNULL(I.PriceInBaseCurrency, 0) + ISNULL(I.AdditionInBaseCurrency, 0) + ISNULL(I.AdditionFactorInBaseCurrency_VatEffective, 0)
                                          END
     , AssetSaleTax = NULL

FROM GNR.TaxPayerBill TPB
    LEFT JOIN GNR.TaxPayerBill BaseTPB ON TPB.BaseTaxPayerBillRef = BaseTPB.TaxPayerBillId
    LEFT JOIN SLS.Invoice I ON I.InvoiceId = TPB.InvoiceRef
    LEFT JOIN SLS.ReturnedInvoice RI ON RI.ReturnedInvoiceId = TPB.ReturnedInvoiceRef
    LEFT JOIN SLS.Invoice ESI ON ESI.InvoiceId = TPB.ExportServiceInvoiceRef
    LEFT JOIN AST.Sale ASTS ON ASTS.SaleId = TPB.AssetSaleRef
    LEFT JOIN (SELECT CD.CustomsDeclarationId ,CD.Number ,CD.CurrencyRef, TotalOtherTaxAndAmount = SUM(ISNULL(CDI.OtherTaxes,0) + ISNULL(CDI.OtherAmounts,0))
               FROM SLS.CustomsDeclaration CD
               JOIN SLS.CustomsDeclarationItem CDI ON CDI.CustomsDeclarationRef = CD.CustomsDeclarationId
               GROUP BY CD.CustomsDeclarationId ,CD.Number, CD.CurrencyRef
               ) CD ON CD.CustomsDeclarationId = TPB.CustomsDeclarationRef
    LEFT JOIN CNT.vwStatus ST ON TPB.StatusRef = ST.StatusID
    LEFT JOIN SLS.SaleType S ON I.SaleTypeRef = S.SaleTypeId
    LEFT JOIN GNR.vwParty P ON I.CustomerPartyRef = P.PartyId OR ASTS.PartyRef = P.PartyId
    LEFT JOIN GNR.PartyAddress A ON I.PartyAddressRef = A.PartyAddressId OR ASTS.PartyAddressRef = A.PartyAddressId
    LEFT JOIN GNR.Currency AS C ON ISNULL(ISNULL(ISNULL(I.CurrencyRef, CD.CurrencyRef), ESI.CurrencyRef), ASTS.Currencyref) = C.CurrencyID
    LEFT JOIN FMK.FiscalYear AS FY ON FY.FiscalYearId = TPB.FiscalYearRef
	LEFT JOIN FMK.FiscalYear AS IFY ON IFY.FiscalYearId = I.FiscalYearRef
