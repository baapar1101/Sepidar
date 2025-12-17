IF Object_ID('GNR.spTaxPayerGetBillHeader') IS NOT NULL
    DROP PROCEDURE GNR.spTaxPayerGetBillHeader
GO
CREATE PROCEDURE GNR.spTaxPayerGetBillHeader (
    @billNumber int)
AS
BEGIN
    SELECT
        B.TaxPayerBillId,
        B.BillNumber,
        B.BillNumberInno,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillState' AND Code = B.[State]) AS [State],
        B.UniqueBillCodeTaxid,
        B.BaseUniqueBillCodeIrtaxid,
        B.IssueDateIndatim,
        B.CreationDateIndati2m,
        B.IsEdited,
        B.EditDateTime,
        BB.BillNumber AS BaseBillNumber,
        I.Number AS InvoiceNumber,
        S.Number AS StatusNumber,
        RI.Number AS ReturnedInvoiceNumber,
        CD.Number AS CustomsDeclarationNumber,
        EI.Number AS ExportServiceInvoiceNumber,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillBillPattern' AND Code = B.BillPatternInp) AS BillPatternInp,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillActionType' AND Code = B.ActionTypeIns) AS ActionTypeIns,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillBillType' AND Code = B.BillTypeInty) AS BillTypeInty,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillStateInWorkBook' AND Code = B.StateInWorkBook) AS StateInWorkBook,
        B.TotalAmountBeforeDiscountTprdis,
        B.TotalDiscountTdis,
        B.TotalAmountAfterDiscountTadis,
        B.TotalTaxTvam,
        B.TotalOtherTaxesAndAmountsTodam,
        B.TotalExportPriceInBaseCurrencyTorv,
        B.TotalExportPriceTocv,
        B.TotalNetPriceTbill,
        B.TotalNetWeightTonw,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillSettlementType' AND Code = B.SettlementTypeSetm) AS SettlementTypeSetm,
        B.CashPaymentCap,
        B.ChequePaymentInsp,
        B.TotalVatShareTvop,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerPartyType' AND Code = B.CustomerPartyTypeTob) AS CustomerPartyTypeTob,
        B.CustomerNationalCodeBid,
        B.CustomerEconomicCodeTinb,
        B.CustomerZipCodeBpc,
        B.CustomerBranchCodeBbc,
        B.CustomerPassportNumberBpn,
        B.CustomerContractUniqueCodeCrn,
        PDL.Code AS CustomerDLCode,
        P.Name + ' ' + ISNULL(P.LastName, '') AS CustomerTitle,
        B.CottageNumberCdcn,
        B.CottageDateCdcd,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillSubmitType' AND Code = B.SubmitType) AS SubmitType,
        B.ReferenceNumber,
        B.Uid,
        B.SellerEconomicCodeTins,
        BB.MotamedInno AS BaseBillMotamedInno,
        B.MotamedInno,
        B.InvoiceRef,
        B.ReturnedInvoiceRef,
        B.StatusRef,
        B.CustomsDeclarationRef,
        B.ExportServiceInvoiceRef,
        B.BaseTaxPayerBillRef,
        B.FiscalYearRef,
        B.SepidarVersion,
        B.Version,
        B.Creator,
        B.CreationDate,
        B.LastModifier,
        B.LastModificationDate
    FROM GNR.TaxPayerBill B
    LEFT JOIN GNR.TaxPayerBill BB ON B.BaseTaxPayerBillRef = BB.TaxPayerBillId
    LEFT JOIN SLS.CustomsDeclaration CD ON B.CustomsDeclarationRef = CD.CustomsDeclarationId
    LEFT JOIN CNT.[Status] S ON B.StatusRef = S.StatusID
    LEFT JOIN CNT.[Contract] C ON S.ContractRef = C.ContractID
    LEFT JOIN SLS.Invoice EI ON B.ExportServiceInvoiceRef = EI.InvoiceId
    LEFT JOIN SLS.ReturnedInvoice RI ON B.ReturnedInvoiceRef = RI.ReturnedInvoiceId
    LEFT JOIN SLS.Invoice I ON B.InvoiceRef = I.InvoiceId
    LEFT JOIN GNR.Party P ON B.BillTypeInty = 1 AND (
        S.StatusID IS NOT NULL AND C.ContractorPartyRef = P.PartyId
        OR EI.InvoiceId IS NOT NULL AND EI.CustomerPartyRef = P.PartyId
        OR RI.ReturnedInvoiceId IS NOT NULL AND RI.CustomerPartyRef = P.PartyId
        OR I.InvoiceId IS NOT NULL AND I.CustomerPartyRef = P.PartyId
    )
    LEFT JOIN ACC.DL PDL ON P.DLRef = PDL.DLId
    WHERE B.BillNumber = @billNumber
END
GO
