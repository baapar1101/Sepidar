If Object_ID('GNR.spReviewPartyRemainderDetail') Is Not Null
    Drop Procedure GNR.spReviewPartyRemainderDetail
GO


-- declare @EntityType int,@EntityId int,@EntityItemID int,@Debit int,@PartyRef int,@ContainsCheque bit,@FromDate datetime,@ToDate datetime,@CustomerPermission bit,@VendorPermission bit,@BrokerPermission bit,@OtherPermission bit,@FiscalYearRef int,@FilterFiscalYear int,@SystemCurrency int
-- select @EntityType = -1,
--        @EntityId = -1,
--        @EntityItemID = -1,
--        @Debit = -1,
--        @PartyRef = -1,
--        @ContainsCheque = 1,
--        @FromDate = '2021-03-20 00:00:00',
--        @ToDate = '2022-03-21 00:00:00',
--        @CustomerPermission = 1,
--        @VendorPermission = 1,
--        @BrokerPermission = 1,
--        @OtherPermission = 1,
--        @FiscalYearRef = 2,
--        @FilterFiscalYear = 2,
--        @SystemCurrency = 1

-- exec GNR.spReviewPartyRemainderDetail  @ContainsCheque ,
--                                               @PartyRef ,
--                                               @EntityType ,
--                                               @EntityId ,
--                                               @EntityItemID ,
--                                               @Debit

-- drop procedure GNR.spReviewPartyRemainderDetail


CREATE PROCEDURE [GNR].[spReviewPartyRemainderDetail] @ContainsCheque bit,
                                                      @PartyRef int,
                                                      @EntityType int,
                                                      @EntityId int,
                                                      @EntityItemID int,
                                                      @Debit int
AS

BEGIN

    SELECT *
    FROM (

             -- اقلام اسناد حسابداري
             SELECT V.VoucherId                                              EntityId,
                    VI.DLCode                                                PartyCode,
                    VI.DLTitle                                               PartyName
                     ,
                    VI.DLRef                                                 PartyDLRef
                     ,
                    4 /*ساير*/                                               PartyRoleType,
                    ''                                                       PartyRoleTypeTitle,
                    20 /*سند حسابداري*/                                      EntityType,
                    ''                                                       EntityTypeTitle,
                    V.Number                                                 EntityNumber,
                    V.Date                                                   HeaderDate,
                    CAST(VI.RowNumber AS NVARCHAR(MAX))                      ItemNumber,
                    VI.Description                                           ItemDescription,
                    ''                                                       ItemTitle,
                    CASE WHEN VI.Debit <> 0 THEN 1 ELSE 2 END                ItemTitleCode,
                    CASE WHEN VI.Debit <> 0 THEN VI.Debit ELSE VI.Credit END ItemFee,
                    NULL                                                     ItemQuantity,
                    CASE WHEN VI.Debit <> 0 THEN VI.Debit ELSE 0 END         DebitAmount,
                    CASE WHEN VI.Credit <> 0 THEN VI.Credit ELSE 0 END       CreditAmount,
                    ''                                                       RelatedPeople
             FROM ACC.Voucher V
                      INNER JOIN ACC.vwVoucherItem VI
                                 ON V.VoucherId = VI.VoucherRef
             WHERE (V.Type = 1 OR V.Type = 6)
               AND /*نوع سند*/ VI.IssuerEntityName = 'SG.Accounting.VoucherManagement.Common.DsVoucher, SG.Accounting.VoucherManagement.Common, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null' /*حسابداري*/
               AND VI.DLType = 2 /*طرف مقابل*/
               AND (@EntityType = 20 /*AccountingCVoucher*/ OR @EntityType = -1)
               AND (V.VoucherId = @EntityId OR @EntityId = -1)
               AND (VI.VoucherItemID = @EntityItemID OR @EntityItemID = -1)
               AND (VI.DLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

--قلم صورت هزينه
             SELECT CS.CostStatementID      EntityID,
                    CS.FundResponderDLCode  PartyCode,
                    CS.FundResponderDLTitle PartyName,
                    CS.FundResponderDLRef   PartyDLRef,
                    4 /*ساير*/              PartyRoleType,
                    ''                      PartyRoleTypeTitle,
                    21 /*صورت هزينه*/       EntityType,
                    ''                      EntityTypeTitle,
                    CS.Number               EntityNumber,
                    CS.Date                 HeaderDate,
                    I.Code                  ItemNumber,
                    CSI.Description         ItemDescription,
                    CSI.ItemTitle,
                    NULL                    ItemTitleCode,
                    CSI.Fee                 ItemFee,
                    CSI.Quantity            ItemQuantity,
                    0                       DebitAmount,
                    CSI.Price               CreditAmount,
                    ''                      RelatedPeople
             FROM CNT.vwCostStatement CS
                      INNER JOIN CNT.vwCostStatementItem CSI ON CS.CostStatementID = CSI.CostStatementRef
                      LEFT JOIN INV.Item I ON CSI.ItemRef = I.ItemId
             WHERE (@EntityType = 21 /*CostStatment*/ OR @EntityType = -1)
               AND (CS.CostStatementID = @EntityId OR @EntityId = -1)
               AND (CS.FundResponderDLRef = @PartyRef OR @PartyRef = -1 AND CS.Type = 1)

             UNION ALL

             SELECT CS.CostStatementID EntityID,
                    CSI.PartyDLCode    PartyCode,
                    CSI.PartyDlTitle   PartyName,
                    CSI.PartyDLRef     PartyDLRef,
                    4 /*ساير*/         PartyRoleType,
                    ''                 PartyRoleTypeTitle,
                    21 /*صورت هزينه*/  EntityType,
                    ''                 EntityTypeTitle,
                    CS.Number          EntityNumber,
                    CS.Date            HeaderDate,
                    I.Code             ItemNumber,
                    CSI.Description    ItemDescription,
                    CSI.ItemTitle,
                    NULL               ItemTitleCode,
                    CSI.Fee            ItemFee,
                    CSI.Quantity       ItemQuantity,
                    0                  DebitAmount,
                    CSI.Price          CreditAmount,
                    ''                 RelatedPeople
             FROM CNT.vwCostStatement CS
                      INNER JOIN CNT.vwCostStatementItem CSI ON CS.CostStatementID = CSI.CostStatementRef
                      LEFT JOIN INV.Item I ON CSI.ItemRef = I.ItemId
             WHERE (@EntityType = 21 /*CostStatment*/ OR @EntityType = -1)
               AND (CS.CostStatementID = @EntityId OR @EntityId = -1)
               AND (CSI.CostStatementItemID = @EntityItemId OR @EntityItemId = -1)
               AND (CSI.PartyDLRef = @PartyRef OR @PartyRef = -1)
               AND CS.Type = 2

             UNION ALL

             -- قلم صورت وضعيت
             SELECT S.StatusID                               EntityID,
                    DL.Code                                  PartyCode,
                    DL.Title                                 PartyName,
                    DL.DLId                                  PartyDLRef,
                    4 /*ساير*/                               PartyRoleType,
                    ''                                       PartyRoleTypeTitle,
                    22 /*صورت وضعيت*/                        EntityType,
                    ''                                       EntityTypeTitle,
                    S.Number                                 EntityNumber,
                    S.Date                                   HeaderDate,
                    I.Code                                   ItemNumber,
                    SI.Description                           ItemDescription,
                    SI.ItemTitle,
                    NULL                                     ItemTitleCode,
                    SI.ConfirmedFee                          ItemFee,
                    SI.ConfirmedQuantity                     ItemQuantity,
                    (SI.ConfirmedFee * SI.ConfirmedQuantity) DebitAmount,
                    0                                        CreditAmount,
                    ''                                       RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.vwStatusItem SI ON S.StatusID = SI.StatusRef
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
                      LEFT JOIN INV.Item I ON SI.ItemRef = I.ItemId
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (SI.ConfirmedFee * SI.ConfirmedQuantity <> 0)
               AND (S.ConfirmationState = 2)
               AND (S.StatusRefType <> 3 AND S.Nature = 1)

             UNION All

             SELECT S.StatusID                               EntityID,
                    DL.Code                                  PartyCode,
                    DL.Title                                 PartyName,
                    DL.DLId                                  PartyDLRef,
                    4 /*ساير*/                               PartyRoleType,
                    ''                                       PartyRoleTypeTitle,
                    22 /*صورت وضعيت*/                        EntityType,
                    ''                                       EntityTypeTitle,
                    S.Number                                 EntityNumber,
                    S.Date                                   HeaderDate,
                    I.Code                                   ItemNumber,
                    SI.Description                           ItemDescription,
                    SI.ItemTitle,
                    NULL                                     ItemTitleCode,
                    SI.ConfirmedFee                          ItemFee,
                    SI.ConfirmedQuantity                     ItemQuantity,
                    0                                        DebitAmount,
                    (SI.ConfirmedFee * SI.ConfirmedQuantity) CreditAmount,
                    ''                                       RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.vwStatusItem SI ON S.StatusID = SI.StatusRef
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
                      LEFT JOIN INV.Item I ON SI.ItemRef = I.ItemId
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (SI.ConfirmedFee * SI.ConfirmedQuantity <> 0)
               AND (S.ConfirmationState = 2)
               AND (S.StatusRefType = 3 AND S.Nature = 1)

             UNION All

             SELECT S.StatusID                               EntityID,
                    DL.Code                                  PartyCode,
                    DL.Title                                 PartyName,
                    DL.DLId                                  PartyDLRef,
                    4 /*ساير*/                               PartyRoleType,
                    ''                                       PartyRoleTypeTitle,
                    22 /*صورت وضعيت*/                        EntityType,
                    ''                                       EntityTypeTitle,
                    S.Number                                 EntityNumber,
                    S.Date                                   HeaderDate,
                    I.Code                                   ItemNumber,
                    SI.Description                           ItemDescription,
                    SI.ItemTitle,
                    NULL                                     ItemTitleCode,
                    SI.ConfirmedFee                          ItemFee,
                    SI.ConfirmedQuantity                     ItemQuantity,
                    0                                        DebitAmount,
                    (SI.ConfirmedFee * SI.ConfirmedQuantity) CreditAmount,
                    ''                                       RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.vwStatusItem SI ON S.StatusID = SI.StatusRef
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
                      LEFT JOIN INV.Item I ON SI.ItemRef = I.ItemId
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (SI.ConfirmedFee * SI.ConfirmedQuantity <> 0)
               AND (S.ConfirmationState = 2)
               AND (S.StatusRefType <> 3 AND S.Nature = 2)

             UNION All

             SELECT S.StatusID                               EntityID,
                    DL.Code                                  PartyCode,
                    DL.Title                                 PartyName,
                    DL.DLId                                  PartyDLRef,
                    4 /*ساير*/                               PartyRoleType,
                    ''                                       PartyRoleTypeTitle,
                    22 /*صورت وضعيت*/                        EntityType,
                    ''                                       EntityTypeTitle,
                    S.Number                                 EntityNumber,
                    S.Date                                   HeaderDate,
                    I.Code                                   ItemNumber,
                    SI.Description                           ItemDescription,
                    SI.ItemTitle,
                    NULL                                     ItemTitleCode,
                    SI.ConfirmedFee                          ItemFee,
                    SI.ConfirmedQuantity                     ItemQuantity,
                    (SI.ConfirmedFee * SI.ConfirmedQuantity) DebitAmount,
                    0                                        CreditAmount,
                    ''                                       RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.vwStatusItem SI ON S.StatusID = SI.StatusRef
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
                      LEFT JOIN INV.Item I ON SI.ItemRef = I.ItemId
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (SI.ConfirmedFee * SI.ConfirmedQuantity <> 0)
               AND (S.ConfirmationState = 2)
               AND (S.StatusRefType = 3 AND S.Nature = 2)

             UNION All

             SELECT S.StatusID    EntityID,
                    DL.Code       PartyCode,
                    DL.Title      PartyName,
                    DL.DLId       PartyDLRef,
                    4 /*ساير*/    PartyRoleType,
                    ''            PartyRoleTypeTitle,
                    23 /*ماليات*/ EntityType,
                    ''            EntityTypeTitle,
                    S.Number      EntityNumber,
                    S.Date        HeaderDate,
                    ''            ItemNumber,
                    NULL          ItemDescription,
                    ''            ItemTitle,
                    3             ItemTitleCode,
                    S.Tax         ItemFee,
                    NULL          ItemQuantity,
                    0             DebitAmount,
                    S.Tax         CreditAmount,
                    ''            RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.Tax IS NOT NULL)
               AND (S.Tax <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType <> 3 AND S.Nature = 1) OR (S.StatusRefType = 3 AND S.Nature = 2))

             UNION All

             SELECT S.StatusID    EntityID,
                    DL.Code       PartyCode,
                    DL.Title      PartyName,
                    DL.DLId       PartyDLRef,
                    4 /*ساير*/    PartyRoleType,
                    ''            PartyRoleTypeTitle,
                    23 /*ماليات*/ EntityType,
                    ''            EntityTypeTitle,
                    S.Number      EntityNumber,
                    S.Date        HeaderDate,
                    ''            ItemNumber,
                    NULL          ItemDescription,
                    ''            ItemTitle,
                    3             ItemTitleCode,
                    S.Tax         ItemFee,
                    NULL          ItemQuantity,
                    S.Tax         DebitAmount,
                    0             CreditAmount,
                    ''            RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.Tax IS NOT NULL)
               AND (S.Tax <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType = 3 AND S.Nature = 1) OR (S.StatusRefType <> 3 AND S.Nature = 2))


             UNION ALL

             SELECT S.StatusID  EntityID,
                    DL.Code     PartyCode,
                    DL.Title    PartyName,
                    DL.DLId     PartyDLRef,
                    4 /*ساير*/  PartyRoleType,
                    ''          PartyRoleTypeTitle,
                    24 /*بيمه*/ EntityType,
                    ''          EntityTypeTitle,
                    S.Number    EntityNumber,
                    S.Date      HeaderDate,
                    ''          ItemNumber,
                    NULL        ItemDescription,
                    ''          ItemTitle,
                    4           ItemTitleCode,
                    S.Insurance ItemFee,
                    NULL        ItemQuantity,
                    0           DebitAmount,
                    S.Insurance CreditAmount,
                    ''          RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.Insurance IS NOT NULL)
               AND (S.Insurance <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType <> 3 AND S.Nature = 1) OR (S.StatusRefType = 3 AND S.Nature = 2))

             UNION ALL

             SELECT S.StatusID  EntityID,
                    DL.Code     PartyCode,
                    DL.Title    PartyName,
                    DL.DLId     PartyDLRef,
                    4 /*ساير*/  PartyRoleType,
                    ''          PartyRoleTypeTitle,
                    24 /*بيمه*/ EntityType,
                    ''          EntityTypeTitle,
                    S.Number    EntityNumber,
                    S.Date      HeaderDate,
                    ''          ItemNumber,
                    NULL        ItemDescription,
                    ''          ItemTitle,
                    4           ItemTitleCode,
                    S.Insurance ItemFee,
                    NULL        ItemQuantity,
                    S.Insurance DebitAmount,
                    0           CreditAmount,
                    ''          RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.Insurance IS NOT NULL)
               AND (S.Insurance <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType = 3 AND S.Nature = 1) OR (S.StatusRefType <> 3 AND S.Nature = 2))


             UNION ALL

             SELECT S.StatusID           EntityID,
                    DL.Code              PartyCode,
                    DL.Title             PartyName,
                    DL.DLId              PartyDLRef,
                    4 /*ساير*/           PartyRoleType,
                    ''                   PartyRoleTypeTitle,
                    25 /*حسن انجام كار*/ EntityType,
                    ''                   EntityTypeTitle,
                    S.Number             EntityNumber,
                    S.Date               HeaderDate,
                    ''                   ItemNumber,
                    NULL                 ItemDescription,
                    ''                   ItemTitle,
                    5                    ItemTitleCode,
                    S.GoodJob            ItemFee,
                    NULL                 ItemQuantity,
                    0                    DebitAmount,
                    S.GoodJob            CreditAmount,
                    ''                   RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.GoodJob IS NOT NULL)
               AND (S.GoodJob <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType <> 3 AND S.Nature = 1) OR (S.StatusRefType = 3 AND S.Nature = 2))

             UNION ALL

             SELECT S.StatusID           EntityID,
                    DL.Code              PartyCode,
                    DL.Title             PartyName,
                    DL.DLId              PartyDLRef,
                    4 /*ساير*/           PartyRoleType,
                    ''                   PartyRoleTypeTitle,
                    25 /*حسن انجام كار*/ EntityType,
                    ''                   EntityTypeTitle,
                    S.Number             EntityNumber,
                    S.Date               HeaderDate,
                    ''                   ItemNumber,
                    NULL                 ItemDescription,
                    ''                   ItemTitle,
                    5                    ItemTitleCode,
                    S.GoodJob            ItemFee,
                    NULL                 ItemQuantity,
                    S.GoodJob            DebitAmount,
                    0                    CreditAmount,
                    ''                   RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.GoodJob IS NOT NULL)
               AND (S.GoodJob <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType = 3 AND S.Nature = 1) OR (S.StatusRefType <> 3 AND S.Nature = 2))


             UNION All

             SELECT S.StatusID         EntityID,
                    DL.Code            PartyCode,
                    DL.Title           PartyName,
                    DL.DLId            PartyDLRef,
                    4 /*ساير*/         PartyRoleType,
                    ''                 PartyRoleTypeTitle,
                    26 /*ضرايب كاهشي*/ EntityType,
                    ''                 EntityTypeTitle,
                    S.Number           EntityNumber,
                    S.Date             HeaderDate,
                    ''                 ItemNumber,
                    NULL               ItemDescription,
                    ''                 ItemTitle,
                    6                  ItemTitleCode,
                    S.DecCoef          ItemFee,
                    NULL               ItemQuantity,
                    0                  DebitAmount,
                    S.DecCoef          CreditAmount,
                    ''                 RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.DecCoef IS NOT NULL)
               AND (S.DecCoef <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType <> 3 AND S.Nature = 1) OR (S.StatusRefType = 3 AND S.Nature = 2))

             UNION All

             SELECT S.StatusID         EntityID,
                    DL.Code            PartyCode,
                    DL.Title           PartyName,
                    DL.DLId            PartyDLRef,
                    4 /*ساير*/         PartyRoleType,
                    ''                 PartyRoleTypeTitle,
                    26 /*ضرايب كاهشي*/ EntityType,
                    ''                 EntityTypeTitle,
                    S.Number           EntityNumber,
                    S.Date             HeaderDate,
                    ''                 ItemNumber,
                    NULL               ItemDescription,
                    ''                 ItemTitle,
                    6                  ItemTitleCode,
                    S.DecCoef          ItemFee,
                    NULL               ItemQuantity,
                    S.DecCoef          DebitAmount,
                    0                  CreditAmount,
                    ''                 RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.DecCoef IS NOT NULL)
               AND (S.DecCoef <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType = 3 AND S.Nature = 1) OR (S.StatusRefType <> 3 AND S.Nature = 2))


             UNION All

             SELECT S.StatusID                   EntityID,
                    DL.Code                      PartyCode,
                    DL.Title                     PartyName,
                    DL.DLId                      PartyDLRef,
                    4 /*ساير*/                   PartyRoleType,
                    ''                           PartyRoleTypeTitle,
                    27 /*ماليات بر ارزش افزوده*/ EntityType,
                    ''                           EntityTypeTitle,
                    S.Number                     EntityNumber,
                    S.Date                       HeaderDate,
                    ''                           ItemNumber,
                    NULL                         ItemDescription,
                    ''                           ItemTitle,
                    7                            ItemTitleCode,
                    S.VAT                        ItemFee,
                    NULL                         ItemQuantity,
                    S.VAT                        DebitAmount,
                    0                            CreditAmount,
                    ''                           RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.VAT IS NOT NULL)
               AND (S.VAT <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType <> 3 AND S.Nature = 1) OR (S.StatusRefType = 3 AND S.Nature = 2))

             UNION All

             SELECT S.StatusID                   EntityID,
                    DL.Code                      PartyCode,
                    DL.Title                     PartyName,
                    DL.DLId                      PartyDLRef,
                    4 /*ساير*/                   PartyRoleType,
                    ''                           PartyRoleTypeTitle,
                    27 /*ماليات بر ارزش افزوده*/ EntityType,
                    ''                           EntityTypeTitle,
                    S.Number                     EntityNumber,
                    S.Date                       HeaderDate,
                    ''                           ItemNumber,
                    NULL                         ItemDescription,
                    ''                           ItemTitle,
                    7                            ItemTitleCode,
                    S.VAT                        ItemFee,
                    NULL                         ItemQuantity,
                    0                            DebitAmount,
                    S.VAT                        CreditAmount,
                    ''                           RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.VAT IS NOT NULL)
               AND (S.VAT <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType = 3 AND S.Nature = 1) OR (S.StatusRefType <> 3 AND S.Nature = 2))

             UNION All

             SELECT S.StatusID           EntityID,
                    DL.Code              PartyCode,
                    DL.Title             PartyName,
                    DL.DLId              PartyDLRef,
                    4 /*ساير*/           PartyRoleType,
                    ''                   PartyRoleTypeTitle,
                    28 /*ضرايب افزايشي*/ EntityType,
                    ''                   EntityTypeTitle,
                    S.Number             EntityNumber,
                    S.Date               HeaderDate,
                    ''                   ItemNumber,
                    NULL                 ItemDescription,
                    ''                   ItemTitle,
                    8                    ItemTitleCode,
                    S.IncCoef            ItemFee,
                    NULL                 ItemQuantity,
                    S.IncCoef            DebitAmount,
                    0                    CreditAmount,
                    ''                   RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.IncCoef IS NOT NULL)
               AND (S.IncCoef <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType <> 3 AND S.Nature = 1) OR (S.StatusRefType = 3 AND S.Nature = 2))

             UNION All

             SELECT S.StatusID           EntityID,
                    DL.Code              PartyCode,
                    DL.Title             PartyName,
                    DL.DLId              PartyDLRef,
                    4 /*ساير*/           PartyRoleType,
                    ''                   PartyRoleTypeTitle,
                    28 /*ضرايب افزايشي*/ EntityType,
                    ''                   EntityTypeTitle,
                    S.Number             EntityNumber,
                    S.Date               HeaderDate,
                    ''                   ItemNumber,
                    NULL                 ItemDescription,
                    ''                   ItemTitle,
                    8                    ItemTitleCode,
                    S.IncCoef            ItemFee,
                    NULL                 ItemQuantity,
                    0                    DebitAmount,
                    S.IncCoef            CreditAmount,
                    ''                   RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 /*CostStatment*/ OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.IncCoef IS NOT NULL)
               AND (S.IncCoef <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType = 3 AND S.Nature = 1) OR (S.StatusRefType <> 3 AND S.Nature = 2))

             UNION All

             SELECT S.StatusID                  EntityID,
                    DL.Code                     PartyCode,
                    DL.Title                    PartyName,
                    DL.DLId                     PartyDLRef,
                    4 /*ساير*/                  PartyRoleType,
                    ''                          PartyRoleTypeTitle,
                    38 /*عوارض بر ارزش افزوده*/ EntityType,
                    ''                          EntityTypeTitle,
                    S.Number                    EntityNumber,
                    S.Date                      HeaderDate,
                    ''                          ItemNumber,
                    NULL                        ItemDescription,
                    ''                          ItemTitle,
                    9                           ItemTitleCode,
                    S.Duty                      ItemFee,
                    NULL                        ItemQuantity,
                    S.Duty                      DebitAmount,
                    0                           CreditAmount,
                    ''                          RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.Duty IS NOT NULL)
               AND (S.Duty <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType <> 3 AND S.Nature = 1) OR (S.StatusRefType = 3 AND S.Nature = 2))

             UNION All

             SELECT S.StatusID                  EntityID,
                    DL.Code                     PartyCode,
                    DL.Title                    PartyName,
                    DL.DLId                     PartyDLRef,
                    4 /*ساير*/                  PartyRoleType,
                    ''                          PartyRoleTypeTitle,
                    38 /*عوارض بر ارزش افزوده*/ EntityType,
                    ''                          EntityTypeTitle,
                    S.Number                    EntityNumber,
                    S.Date                      HeaderDate,
                    ''                          ItemNumber,
                    NULL                        ItemDescription,
                    ''                          ItemTitle,
                    9                           ItemTitleCode,
                    S.Duty                      ItemFee,
                    NULL                        ItemQuantity,
                    0                           DebitAmount,
                    S.Duty                      CreditAmount,
                    ''                          RelatedPeople
             FROM CNT.vwStatus S
                      INNER JOIN CNT.Contract C ON C.ContractID = S.ContractRef
                      INNER JOIN GNR.Party P ON P.PartyID = C.ContractorPartyRef
                      INNER JOIN ACC.DL DL ON DL.dlID = P.DlRef
             WHERE (@EntityType = 22 OR @EntityType = -1)
               AND (S.StatusID = @EntityId OR @EntityId = -1)
               AND (ContractorDLRef = @PartyRef OR @PartyRef = -1)
               AND (S.Duty IS NOT NULL)
               AND (S.Duty <> 0)
               AND (S.ConfirmationState = 2)
               AND ((S.StatusRefType = 3 AND S.Nature = 1) OR (S.StatusRefType <> 3 AND S.Nature = 2))


             UNION ALL

             SELECT AR.AcquisitionReceiptID                 EntityID
                  , AR.DLFullCode                           PartyCode
                  , AR.DLTitle                              PartyName
                  , AR.AccountingDLRef                      PartyDLRef
                  , 4 /*Other*/                             PartyRoleType
                  , ''                                      PartyRoleTypeTitle
                  , 34 /*AcquisitionReceipt*/               EntityType
                  , ''                                      EntityTypeTitle
                  , AR.Number                               EntityNumber
                  , Ar.Date                                 HeaderDate
                  , CAST(ARI.PlaqueNumber AS NVARCHAR(MAX)) ItemNumber
                  , ARI.Description                         ItemDescription
                  , ARI.Title                               ItemTitle
                  , NULL                                    ItemTitleCode
                  , ARI.TotalCostInBasecurrency             ItemFee
                  , 1                                       ItemQuantity
                  , 0                                       DebitAmount
                  , ARI.TotalCostInBasecurrency             CreditAmount
                  , ''                                      RelatedPeople
             FROM AST.vwAcquisitionReceipt AR
                      INNER JOIN AST.vwAcquisitionReceiptItem ARI
                                 ON AR.AcquisitionReceiptID = ARI.AcquisitionReceiptRef
             WHERE (@EntityType = 34 /*AcquisitionReceipt*/ OR @EntityType = -1)
               AND (AR.AcquisitionReceiptID = @EntityId OR @EntityId = -1)
               AND (AR.AccountingDLRef = @PartyRef OR @PartyRef = -1)
               AND NOT EXISTS(Select 1
                              from AST.vwAcquisitionRelatedPurchaseInvoice AI
                              WHERE ARI.AcquisitionReceiptItemID = AI.AcquisitionReceiptItemRef)

             UNION ALL

             SELECT               S.SaleID                               EntityID
                  ,               S.PartyDLCode                          PartyCode
                  ,               S.PartyName                            PartyName
                  ,               S.PartyDLRef                           PartyDLRef
                  ,               4 /*Customer*/                         PartyRoleType
                  ,               ''                                     PartyRoleTypeTitle
                  ,               35 /*Sale*/                            EntityType
                  ,               ''                                     EntityTypeTitle
                  ,               S.Number                               EntityNumber
                  ,               S.Date                                 HeaderDate
                  ,               CAST(SI.PlaqueNumber AS NVARCHAR(MAX)) ItemNumber
                  ,               SI.Description                         ItemDescription
                  ,               SI.AssetTitle                          ItemTitle
                  ,               NULL                                   ItemTitleCode
                  ,               SI.SalePriceInBaseCurrency             ItemFee
                  ,               1                                      ItemQuantity
                  , DebitAmount = SI.SalePriceInBaseCurrency + ISNULL(SI.TaxInBaseCurrency, 0) +
                                  ISNULL(SI.DutyInBaseCurrency, 0)
                  ,               0                                      CreditAmount
                  , ''                                                   RelatedPeople
             FROM AST.vwSale S
                      INNER JOIN AST.vwSaleItem SI
                                 ON S.SaleID = si.SaleRef
             WHERE (@EntityType = 35 /*Sale*/ OR @EntityType = -1)
               AND (S.SaleID = @EntityId OR @EntityId = -1)
               AND (S.PartyDLRef = @PartyRef OR @PartyRef = -1)


             UNION ALL

             SELECT R.RepairId                             EntityID
                  , R.DlCode                               PartyCode
                  , R.DlTitle                              PartyName
                  , R.DlRef                                PartyDLRef
                  , 4 /*Vendor*/                           PartyRoleType
                  , ''                                     PartyRoleTypeTitle
                  , 36 /*Repair*/                          EntityType
                  , ''                                     EntityTypeTitle
                  , R.Number                               EntityNumber
                  , R.Date                                 HeaderDate
                  , CAST(RI.PlaqueNumber AS NVARCHAR(MAX)) ItemNumber
                  , ''                                     ItemDescription
                  , RI.AssetTitle                          ItemTitle
                  , NULL                                   ItemTitleCode
                  , RI.TotalCost                           ItemFee
                  , 1                                      ItemQuantity
                  , 0                                      DebitAmount
                  , RI.TotalCost                           CreditAmount
                  , ''                                     RelatedPeople
             FROM AST.vwRepair R
                      INNER JOIN AST.vwRepairItem RI
                                 ON R.RepairId = RI.RepairRef
             WHERE (@EntityType = 36 /*Repair*/ OR @EntityType = -1)
               AND (R.RepairId = @EntityId OR @EntityId = -1)
               AND (R.DlRef = @PartyRef OR @PartyRef = -1)
               AND NOT EXISTS(
                     Select 1 from AST.vwRepairRelatedPurchaseInvoice AI WHERE RI.RepairItemId = AI.RepairItemRef)


             UNION ALL

             -- مبالغ بستانكار در اعلاميه بدهكار/بستانكار
             SELECT DCN.DebitCreditNoteID             EntityID,
                    DL.Code                           PartyCode,
                    DL.Title                          PartyName,
                    DL.DLId                           PartyDLRef,
                    CASE DCNI.CreditType
                        WHEN 2 /*Sale*/ THEN 1 /*Customer*/
                        WHEN 1 /*Buy*/ THEN 2 /*Vendor*/
                        WHEN 3 /*Other*/ THEN 4 /*Other*/
                        WHEN 4 /*Broker*/ THEN 3 /*Brokerr*/
                        END                           PartyRoleType,
                    ''                                PartyRoleTypeTitle,
                    10 /*DebitCreditNoteCredit*/      EntityType,
                    ''                                EntityTypeTitle,
                    DCN.Number                        EntityNumber,
                    DCN.Date                          HeaderDate,
                    CAST(DCNI.RowId AS NVARCHAR(MAX)) ItemNumber,
                    DCNI.Description                  ItemDescription,
                    ''                                ItemTitle,
                    10                                ItemTitleCode,
                    DCNI.AmountInBaseCurrency         ItemFee,
                    NULL                              ItemQuantity,
                    0                                 DebitAmount,
                    DCNI.AmountInBaseCurrency         CreditAmount,
                    ''                                RelatedPeople
             FROM GNR.vwDebitCreditNote DCN
                      INNER JOIN GNR.DebitCreditNoteItem DCNI
                                 ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef
                      INNER JOIN ACC.DL DL
                                 ON DCNI.CreditDLRef = Dl.DLId
             WHERE (@EntityType = 11 /*DebitCreditNoteCredit*/ OR @EntityType = 10 /*DebitCreditNoteDebit*/ OR
                    @EntityType = -1)
               AND (DCN.DebitCreditNoteID = @EntityId OR @EntityId = -1)
               AND (DCNI.DebitCreditNoteItemID = @EntityItemID OR @EntityItemID = -1)
               AND (DCNI.CreditDLRef IS NOT NULL)
               AND (DCNI.CreditDLRef = @PartyRef OR @PartyRef = -1)
               AND (@Debit = 0 OR @Debit = -1)
               AND DCNI.CreditType <> 5
             UNION ALL

             --مبالغ بدهكار اعلاميه بدهكار/بستانكار
             SELECT DCN.DebitCreditNoteID             EntityID,
                    DL.Code                           PartyCode,
                    DL.Title                          PartyName,
                    DL.DLId                           PartyDLRef,
                    CASE DCNI.DebitType
                        WHEN 2 /*Sale*/ THEN 1 /*Customer*/
                        WHEN 1 /*Buy*/ THEN 2 /*Vendor*/
                        WHEN 3 /*Other*/ THEN 4 /*Other*/
                        WHEN 4 /*Broker*/ THEN 3 /*Broker*/
                        END                           PartyRoleType,
                    ''                                PartyRoleTypeTitle,
                    11 /*DebitCreditNoteDebit*/       EntityType,
                    ''                                EntityTypeTitle,
                    DCN.Number                        EntityNumber,
                    DCN.Date                          HeaderDate,
                    CAST(DCNI.RowId AS NVARCHAR(MAX)) ItemNumber,
                    DCNI.Description                  ItemDescription,
                    ''                                ItemTitle,
                    11                                ItemTitleCode,
                    DCNI.AmountInBaseCurrency         ItemFee,
                    NULL                              ItemQuantity,
                    DCNI.AmountInBaseCurrency         DebitAmount,
                    0                                 CreditAmount,
                    ''                                RelatedPeople
             FROM GNR.vwDebitCreditNote DCN
                      INNER JOIN GNR.DebitCreditNoteItem DCNI
                                 ON DCN.DebitCreditNoteID = DCNI.DebitCreditNoteRef
                      INNER JOIN ACC.DL DL
                                 ON DCNI.DebitDLRef = Dl.DLId
             WHERE (@EntityType = 10 /*DebitCreditNoteCredit*/ OR @EntityType = 11 /*DebitCreditNoteDebit*/ OR
                    @EntityType = -1)
               AND (DCN.DebitCreditNoteID = @EntityId OR @EntityId = -1)
               AND (DCNI.DebitCreditNoteItemID = @EntityItemID OR @EntityItemID = -1)
               AND (DCNI.DebitDLRef IS NOT NULL)
               AND (DCNI.DebitDLRef = @PartyRef OR @PartyRef = -1)
               AND (@Debit = 1 OR @Debit = -1)

             UNION ALL

-- قلم تقسيط

             SELECT SH.ShredId                                                     EntityID,
                    SH.DLCode                                                      PartyCode,
                    SH.DLTitle                                                     PartyName,
                    SH.DLRef                                                       PartyDLRef,
                    CASE
                        WHEN SH.[Key] = 1 /*فاكتور فروش*/ THEN 1 /*مشتري*/
                        WHEN (SH.[Key] = 3 /*رسيد انبار*/ OR SH.[Key] = 8 /*فاكتور خريد خدمات*/ OR
                              SH.[Key] = 2 /*فاكتور خريد */) THEN 2 /*تامين كننده*/
                        WHEN (SH.[Key] = 6 /*ساير دريافتني*/ OR SH.[Key] = 7 /*ساير پرداختني*/ OR
                              SH.[Key] = 4 /*وام كارمندي*/) THEN 4 /*ساير*/
                        END                                                        PartyRoleType,
                    ''                                                             PartyRoleTypeTitle,
                    18 /*Shred*/                                                   EntityType,
                    ''                                                             EntityTypeTitle,
                    SH.Number                                                      EntityNumber,
                    SH.Date                                                        HeaderDate,
                    CAST(SHI.RowNumber AS NVARCHAR(MAX))                           ItemNumber,
                    SHI.PaidDesc                                                   ItemDescription,
                    ''                                                             ItemTitle,
                    12                                                             ItemTitleCode,
                    (ISNULL(SHI.InterestAmount, 0) + ISNULL(SHI.PenaltyAmount, 0)) ItemFee,
                    NULL                                                           ItemQuantity,
                    CASE
                        WHEN SH.[Key] IN (1, 4, 6) THEN ISNULL(SHI.InterestAmount, 0) + ISNULL(SHI.PenaltyAmount, 0)
                        ELSE 0
                        END                                                        DebitAmount,
                    CASE
                        WHEN SH.[Key] IN (2, 3, 7, 8) THEN ISNULL(SHI.InterestAmount, 0) + ISNULL(SHI.PenaltyAmount, 0)
                        ELSE 0
                        END                                                        CreditAmount,
                    ''                                                             RelatedPeople
             FROM GNR.vwShred SH
                      INNER JOIN GNR.vwShredItem SHI
                                 ON SH.ShredID = SHI.ShredRef
             WHERE ([Key] IN (1, 2, 3, 6, 7, 8) OR ([Key] = 4 AND SHI.ReceiptRef IS NOT NULL))
               AND (@EntityType = 18 /*Shred*/ OR @EntityType = -1)
               AND (SH.ShredId = @EntityId OR @EntityId = -1)
               AND (SH.DLRef = @PartyRef OR @PartyRef = -1)
               AND (ISNULL(SHI.InterestAmount, 0) > 0 OR ISNULL(SHI.PenaltyAmount, 0) > 0)

             UNION ALL

-- قلم وام كارمندي

             SELECT SH.ShredId                           EntityID,
                    SH.DLCode                            PartyCode,
                    SH.DLTitle                           PartyName,
                    SH.DLRef                             PartyDLRef,
                    4                                    PartyRoleType,
                    ''                                   PartyRoleTypeTitle,
                    19 /*Shred*/                         EntityType,
                    ''                                   EntityTypeTitle,
                    SH.Number                            EntityNumber,
                    SH.Date                              HeaderDate,
                    CAST(SHI.RowNumber AS NVARCHAR(MAX)) ItemNumber,
                    SHI.PaidDesc                         ItemDescription,
                    L.Title                              ItemTitle,
                    NULL                                 ItemTitleCode,
                    ISNULL(SHI.Amount, 0)                ItemFee,
                    NULL                                 ItemQuantity,
                    ISNULL(SHI.Amount, 0)                DebitAmount,
                    0                                    CreditAmount,
                    ''                                   RelatedPeople
             FROM GNR.vwShred SH
                      INNER JOIN GNR.vwShredItem SHI
                                 ON SH.ShredID = SHI.ShredRef
                      INNER JOIN PAY.Loan L ON L.LoanId = SH.TargetRef
             WHERE (SH.[Key] = 4 AND SHI.ReceiptRef IS NOT NULL)
               AND (ISNULL(SHI.Amount, 0) <> 0)
               AND (@EntityType = 19 /*Shred*/ OR @EntityType = -1)
               AND (SH.ShredId = @EntityId OR @EntityId = -1)
               AND (SH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

-- قلم فاكتور خريد خدمات
             SELECT SIPI.InventoryPurchaseInvoiceID                           EntityID,
                    SIPI.DLCode                                               PartyCode,
                    SIPI.DLTitle                                              PartyName,
                    SIPI.VendorDLRef                                          PartyDLRef,
                    2 /*Vendor*/                                              PartyRoleType,
                    ''                                                        PartyRoleTypeTitle,
                    17 /*ServicePurchaseInvoice*/                             EntityType,
                    ''                                                        EntityTypeTitle,
                    SIPI.Number                                               EntityNumber,
                    SIPI.Date                                                 HeaderDate,
                    CAST(SIPII.ItemCode AS NVARCHAR(MAX))                     ItemNumber,
                    SIPII.Description                                         ItemDescription,
                    SIPII.ItemTitle                                           ItemTitle,
                    NULL                                                      ItemTitleCode,
                    SIPII.FeeInBaseCurrency                                   ItemFee,
                    SIPII.Quantity                                            ItemQuantity,
                    0                                                         DebitAmount,
                    ISNULL(SIPII.NetPriceInBaseCurrency, 0) - ISNULL(SIPII.InsuranceAmountInBaseCurrency, 0)
                        - ISNULL(SIPII.WithHoldingTaxAmountInBaseCurrency, 0) CreditAmount,
                    ''                                                        RelatedPeople
             FROM INV.vwServiceInventoryPurchaseInvoice SIPI
                      INNER JOIN INV.vwServiceInventoryPurchaseInvoiceItem SIPII
                                 ON SIPI.InventoryPurchaseInvoiceID = SIPII.InventoryPurchaseInvoiceRef
             WHERE (@EntityType = 17 /*ServicePurchaseInvoice*/ OR @EntityType = -1)
               AND (ISNULL(SIPII.NetPriceInBaseCurrency, 0) - ISNULL(SIPII.InsuranceAmountInBaseCurrency, 0)
                        - ISNULL(SIPII.WithHoldingTaxAmountInBaseCurrency, 0) <> 0)
               AND (SIPI.InventoryPurchaseInvoiceID = @EntityId OR @EntityId = -1)
               AND (SIPI.VendorDLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

             -- قلم رسيد انبار
             SELECT IR.InventoryReceiptID                                 EntityID,
                    IR.DelivererCode                                      PartyCode,
                    IR.DelivererTitle                                     PartyName,
                    IR.DelivererDLRef                                     PartyDLRef,
                    CASE IR.Type
                        WHEN 1 THEN 2 /*Vendor*/
                        WHEN 3 THEN 4 /*Other*/
                        END                                               PartyRoleType,
                    ''                                                    PartyRoleTypeTitle,
                    12                                                    EntityType,
                    ''                                                    EntityTypeTitle,
                    IR.Number                                             EntityNumber,
                    IR.Date                                               HeaderDate,
                    CAST(IRI.ItemCode AS NVARCHAR(MAX))                   ItemNumber,
                    IRI.Description                                       ItemDescription,
                    ItemTitle,
                    NULL                                                  ItemTitleCode,
                    IRI.Fee                                               ItemFee,
                    IRI.Quantity                                          ItemQuantity,
                    0                                                     DebitAmount,
                    (ISNULL(Price, 0) + ISNULL(Tax, 0) + ISNULL(Duty, 0)) CreditAmount,
                    ''                                                    RelatedPeople
             FROM INV.vwInventoryReceipt IR
                      INNER JOIN INV.vwInventoryReceiptItem IRI
                                 ON IR.InventoryReceiptID = IRI.InventoryReceiptRef
             WHERE (@EntityType = 12 /*InventoryReceipt*/ OR @EntityType = -1)
               AND (IR.InventoryReceiptID = @EntityId OR @EntityId = -1)
               AND IR.IsReturn = 0
               AND IR.BaseImportPurchaseInvoiceRef IS NULL
               AND (IR.Type = 1 /*Purchase*/ OR IR.Type = 3 /*Other*/)
               AND (IR.DelivererDLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

             -- قلم برگشت رسيد انبار
             SELECT IR.InventoryReceiptID         EntityID,
                    IR.DelivererCode              PartyCode,
                    IR.DelivererTitle             PartyName,
                    IR.DelivererDLRef             PartyDLRef,
                    CASE IR.Type
                        WHEN 1 THEN 2 /*Vendor*/
                        WHEN 3 THEN 4 /*Other*/
                        END                       PartyRoleType,
                    ''                            PartyRoleTypeTitle,
                    13                            EntityType,
                    ''                            EntityTypeTitle,
                    IR.Number                     EntityNumber,
                    IR.Date                       HeaderDate,
                    CAST(I.Code AS NVARCHAR(MAX)) ItemNumber,
                    IRI.Description               ItemDescription,
                    I.Title                       ItemTitle,
                    NULL                          ItemTitleCode,
                    IRI.ReturnedFee               ItemFee,
                    IRI.Quantity                  ItemQuantity,
                    ISNULL(IRI.ReturnedPrice, 0) + ISNULL(IRI.Tax, 0) + ISNULL(IRI.Duty, 0) +
                    ISNULL(IRI.TransportTax, 0) +
                    ISNULL(IRI.TransportDuty, 0)  DebitAmount,
                    0                             CreditAmount,
                    ''                            RelatedPeople
             FROM INV.vwInventoryReceiptReturn IR
                      INNER JOIN INV.InventoryReceiptItem IRI
                      JOIN INV.Item I ON IRI.ItemRef = I.ItemID
                           ON IR.InventoryReceiptID = IRI.InventoryReceiptRef
             WHERE IRI.IsReturn = 1
               AND (@EntityType = 13 /*ReturnedInventoryReceipt*/ OR @EntityType = -1)
               AND (IR.InventoryReceiptID = @EntityId OR @EntityId = -1)
               AND IR.IsReturn = 1
               AND (IR.Type = 1 /*Purchase*/ OR IR.Type = 3 /*Other*/)
               AND (IR.DelivererDLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

             -- قلم حمل رسيد انبار
             SELECT IR.InventoryReceiptID                                                                      EntityID
                     ,
                    IR.TransporterCode
                     ,
                    IR.TransporterTitle
                     ,
                    IR.TransporterDLRef
                     ,
                    CASE IR.Type
                        WHEN 3 /*Other*/ THEN 4 /*Other*/
                        WHEN 1 /*Purchase*/ THEN 2 /*Vendor*/
                        END                                                                                    PartyRoleType,
                    ''                                                                                         PartyRoleTypeTitle,
                    14                                                                                         EntityType,
                    ''                                                                                         EntityTypeTitle,
                    IR.Number                                                                                  EntityNumber,
                    IR.Date                                                                                    HeaderDate,
                    IRI.ItemCode                                                                               ItemNumber,
                    IRI.TransportDescription                                                                   ItemDescription,
                    ''                                                                                         ItemTitle,
                    13                                                                                         ItemTitleCode,
                    ISNULL(IRI.TransportDuty, 0) + ISNULL(IRI.TransportPrice, 0) + ISNULL(IRI.TransportTax, 0) ItemFee,
                    NULL                                                                                       ItemQuantity,
                    0,
                    ISNULL(IRI.TransportDuty, 0) + ISNULL(IRI.TransportPrice, 0) +
                    ISNULL(IRI.TransportTax, 0)                                                                CreditAmount,
                    ''                                                                                         RelatedPeople
             FROM INV.vwInventoryReceipt IR
                      INNER JOIN INV.vwInventoryReceiptItem IRI
                                 ON IR.InventoryReceiptID = IRI.InventoryReceiptRef
             WHERE (@EntityType = 14 /*TransportInventoryReceipt*/ OR @EntityType = -1)
               AND (IR.InventoryReceiptID = @EntityId OR @EntityId = -1)
               AND (--(IR.TransporterDLRef IS NULL AND IR.DelivererDLRef = @PartyRef) OR
                         IR.TransporterDLRef IS NOT NULL AND
                         (IR.TransporterDLRef = @PartyRef) OR @PartyRef = -1)
               AND ((ISNULL(IRI.TransportDuty, 0) + ISNULL(IRI.TransportPrice, 0) + ISNULL(IRI.TransportTax, 0)) <> 0)

             UNION ALL

-- قلم فاكتور خريد دارايي
             SELECT SIPI.InventoryPurchaseInvoiceID                           EntityID,
                    SIPI.DLCode                                               PartyCode,
                    SIPI.DLTitle                                              PartyName,
                    SIPI.VendorDLRef                                          PartyDLRef,
                    4 /*Other*/                                               PartyRoleType,
                    ''                                                        PartyRoleTypeTitle,
                    37 /*AssetPurchaseInvoice*/                               EntityType,
                    ''                                                        EntityTypeTitle,
                    SIPI.Number                                               EntityNumber,
                    SIPI.Date                                                 HeaderDate,
                    CAST(SIPII.ItemCode AS NVARCHAR(MAX))                     ItemNumber,
                    SIPII.Description                                         ItemDescription,
                    SIPII.ItemTitle                                           ItemTitle,
                    NULL                                                      ItemTitleCode,
                    SIPII.FeeInBaseCurrency                                   ItemFee,
                    SIPII.Quantity                                            ItemQuantity,
                    0                                                         DebitAmount,
                    ISNULL(SIPII.NetPriceInBaseCurrency, 0) - ISNULL(SIPII.InsuranceAmountInBaseCurrency, 0)
                        - ISNULL(SIPII.WithHoldingTaxAmountInBaseCurrency, 0) CreditAmount,
                    ''                                                        RelatedPeople
             FROM INV.vwAssetPurchaseInvoice SIPI
                      INNER JOIN INV.vwAssetPurchaseInvoiceItem SIPII
                                 ON SIPI.InventoryPurchaseInvoiceID = SIPII.InventoryPurchaseInvoiceRef
             WHERE (@EntityType = 37 /*ServicePurchaseInvoice*/ OR @EntityType = -1)
               AND (ISNULL(SIPII.NetPriceInBaseCurrency, 0) - ISNULL(SIPII.InsuranceAmountInBaseCurrency, 0)
                        - ISNULL(SIPII.WithHoldingTaxAmountInBaseCurrency, 0) <> 0)
               AND (SIPI.InventoryPurchaseInvoiceID = @EntityId OR @EntityId = -1)
               AND (SIPI.VendorDLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

             SELECT PI.PurchaseInvoiceID       EntityID
                  , PI.VendorDLCode            PartyCode
                  , PI.VendorDLTitle           PartyName
                  , PI.VendorDLRef             PartyDLRef
                  , 2 /*Vendor*/               PartyRoleType--??
                  , ''                         PartyRoleTypeTitle
                  , 39 /*PurchaseInvoice*/     EntityType--?
                  , ''                         EntityTypeTitle
                  , PI.Number                  EntityNumber
                  , PI.Date                    HeaderDate
                  , PII.ItemCode               ItemNumber
                  , PI.Description             ItemDescription
                  , PII.ItemTitle
                  , NULL                       ItemTitleCode
                  , PII.FeeInBaseCurrency      ItemFee
                  , PII.Quantity               ItemQuantity
                  , 0                          DebitAmount
                  , PII.NetPriceInBaseCurrency CreditAmount
                  , ''                         RelatedPeople
             FROM POM.vwPurchaseInvoice PI
                      INNER JOIN pom.vwPurchaseInvoiceItem PII
                                 ON PI.PurchaseInvoiceID = PII.PurchaseInvoiceRef
                      inner join pom.PurchaseCost PC
                                 ON PC.PurchaseInvoiceRef = PI.PurchaseInvoiceID
             WHERE (@EntityType = 39 /**/ OR @EntityType = -1)
               AND (PI.PurchaseInvoiceID = @EntityId OR @EntityId = -1)
               AND (PI.VendorDLRef = @PartyRef OR @PartyRef = -1)
               AND PI.IsInitial = 0
               AND PC.State = 1

             UNION ALL

             SELECT BL.BillOfLoadingID             EntityID
                  , BL.TransporterDLCode           PartyCode
                  , BL.TransporterDLTitle          PartyName
                  , BL.TransporterDLRef            PartyDLRef
                  , 2 /*Vendor*/                   PartyRoleType--??
                  , ''                             PartyRoleTypeTitle
                  , 40 /*BillOfLoading*/           EntityType--?
                  , ''                             EntityTypeTitle
                  , BL.Number                      EntityNumber
                  , BL.Date                        HeaderDate
                  , ''                             ItemNumber
                  , BL.Description                 ItemDescription
                  , ''                             ItemTitle
                  , 14                             ItemTitleCode
                  , 0                              ItemFee
                  , 0                              ItemQuantity
                  , 0                              DebitAmount
                  , BL.TotalNetPriceInBaseCurrency CreditAmount
                  , ''                             RelatedPeople
             FROM POM.vwBillOfLoading BL
             WHERE (@EntityType = 40 /**/ OR @EntityType = -1)
               AND (BL.BillOfLoadingID = @EntityId OR @EntityId = -1)
               AND (BL.TransporterDLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             SELECT IP.InsurancePolicyID           EntityID
                  , IP.AgencyDLCode                PartyCode
                  , IP.AgencyDLTitle               PartyName
                  , IP.AgencyDLRef                 PartyDLRef
                  , 2 /*Vendor*/                   PartyRoleType--??
                  , ''                             PartyRoleTypeTitle
                  , 41 /*PInsurancePolicy*/        EntityType--?
                  , ''                             EntityTypeTitle
                  , IP.Number                      EntityNumber
                  , IP.Date                        HeaderDate
                  , ''                             ItemNumber
                  , IP.Description                 ItemDescription
                  , ''                             ItemTitle
                  , 15                             ItemTitleCode
                  , 0                              ItemFee
                  , 0                              ItemQuantity
                  , 0                              DebitAmount
                  , IP.TotalNetPriceInBaseCurrency CreditAmount
                  , ''                             RelatedPeople
             FROM POM.vwInsurancePolicy IP
             WHERE (@EntityType = 41 /**/ OR @EntityType = -1)
               AND (IP.InsurancePolicyID = @EntityId OR @EntityId = -1)
               AND (IP.AgencyDLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             SELECT CO.CommercialOrderID    EntityID

                  , CO.DlCode               PartyCode
                  , CO.DlTitle              PartyName
                  , CO.DlRef                PartyDLRef
                  , 2 /*Vendor*/            PartyRoleType--??
                  , ''                      PartyRoleTypeTitle
                  , 42 /*PInsurancePolicy*/ EntityType--?
                  , ''                      EntityTypeTitle
                  , CO.Number               EntityNumber
                  , CO.Date                 HeaderDate
                  , ''                      ItemNumber
                  , CO.Description          ItemDescription
                  , ''                      ItemTitle
                  , 16                      ItemTitleCode
                  , 0                       ItemFee
                  , 0                       ItemQuantity
                  , 0                       DebitAmount
                  , CO.RegisterFee          CreditAmount
                  , ''                      RelatedPeople
             FROM POM.vwCommercialOrder CO
             WHERE (@EntityType = 42 /**/ OR @EntityType = -1)
               AND (CO.CommercialOrderID = @EntityId OR @EntityId = -1)
               AND (CO.DlRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             SELECT CC.CustomsClearanceID                                              EntityID

                  , CC.DlCode                                                          PartyCode
                  , CC.DlTitle                                                         PartyName
                  , CC.DlRef                                                           PartyDLRef
                  , 2 /*Vendor*/                                                       PartyRoleType--??
                  , ''                                                                 PartyRoleTypeTitle
                  , 43 /*PInsurancePolicy*/                                            EntityType--?
                  , ''                                                                 EntityTypeTitle
                  , CC.Number                                                          EntityNumber
                  , CC.Date                                                            HeaderDate
                  , ''                                                                 ItemNumber
                  , CC.Description                                                     ItemDescription
                  , ''                                                                 ItemTitle
                  , 17                                                                 ItemTitleCode
                  , 0                                                                  ItemFee
                  , 0                                                                  ItemQuantity
                  , 0                                                                  DebitAmount
                  , ISNULL(CC.CustomsCost, 0) + ISNULL(CC.Tax, 0) + ISNULL(CC.Duty, 0) CreditAmount
                  , ''                                                                 RelatedPeople
             FROM POM.vwCustomsClearance CC
             WHERE (@EntityType = 43 /**/ OR @EntityType = -1)
               AND (CC.CustomsClearanceID = @EntityId OR @EntityId = -1)
               AND (CC.DlRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --مبلغ نقد اعلاميه پرداخت
             SELECT PH.PaymentHeaderId      EntityID,
                    PH.DlCode               PartyCode,
                    PH.DlTitle              PartyName,
                    PH.DlRef                PartyDLRef,
                    CASE
                        WHEN PH.Type = 1 /*پرداخت به مشتري*/ THEN 1 /*Customer*/
                        WHEN PH.Type = 256 /*پرداخت به تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN PH.Type = 2 /*پرداخت به ساير*/ THEN 4 /*Other*/
                        WHEN PH.Type = 128 /*پرداخت به واسط*/ THEN 3 /*Broker*/
                        WHEN PH.Type = 2048 THEN 5
                        END                 PartyRoleType,
                    ''                      PartyRoleTypeTitle,
                    6                       EntityType,
                    ''                      EntityTypeTitle,
                    PH.Number               EntityNumber,
                    PH.Date                 HeaderDate,
                    '1'                     ItemNumber,
                    PH.Description          ItemDescription,
                    ''                      ItemTitle,
                    18                      ItemTitleCode,
                    PH.AmountInBaseCurrency ItemFee,
                    NULL                    ItemQuantity,
                    PH.AmountInBaseCurrency DebitAmount,
                    0                       CreditAmount,
                    ''                      RelatedPeople
             FROM RPA.vwPaymentHeader PH
             WHERE (PH.State <> 4)
               AND (ISNULL(PH.AmountInBaseCurrency, 0) <> 0)
               AND (@EntityType = 6 /*Payment*/OR @EntityType = -1)
               AND (PH.PaymentHeaderId = @EntityId OR @EntityId = -1)
               AND (PH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --مبلغ تخفيف اعلاميه پرداخت
             SELECT PH.PaymentHeaderId        EntityID,
                    PH.DlCode                 PartyCode,
                    PH.DlTitle                PartyName,
                    PH.DlRef                  PartyDLRef,
                    CASE
                        WHEN PH.Type = 1 /*پرداخت به مشتري*/ THEN 1 /*Customer*/
                        WHEN PH.Type = 256 /*پرداخت به تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN PH.Type = 2 /*پرداخت به ساير*/ THEN 4 /*Other*/
                        WHEN PH.Type = 128 /*پرداخت به واسط*/ THEN 3 /*Broker*/
                        WHEN PH.Type = 2048 THEN 5
                        END                   PartyRoleType,
                    ''                        PartyRoleTypeTitle,
                    6                         EntityType,
                    ''                        EntityTypeTitle,
                    PH.Number                 EntityNumber,
                    PH.Date                   HeaderDate,
                    '1'                       ItemNumber,
                    PH.Description            ItemDescription,
                    ''                        ItemTitle,
                    22                        ItemTitleCode,
                    PH.DiscountInBaseCurrency ItemFee,
                    NULL                      ItemQuantity,
                    PH.DiscountInBaseCurrency DebitAmount,
                    0                         CreditAmount,
                    ''                        RelatedPeople
             FROM RPA.vwPaymentHeader PH
             WHERE (PH.State <> 4)
               AND (DiscountInBaseCurrency > 0)
               AND (@EntityType = 6 /*Payment*/OR @EntityType = -1)
               AND (PH.PaymentHeaderId = @EntityId OR @EntityId = -1)
               AND (PH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --چكهاي اعلاميه پرداخت
             SELECT PH.PaymentHeaderId               EntityID,
                    PH.DlCode                        PartyCode,
                    PH.DlTitle                       PartyName,
                    PH.DlRef                         PartyDLRef,
                    CASE
                        WHEN PH.Type = 1 /*پرداخت به مشتري*/ THEN 1 /*Customer*/
                        WHEN PH.Type = 256 /*پرداخت به تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN PH.Type = 2 /*پرداخت به ساير*/ THEN 4 /*Other*/
                        WHEN PH.Type = 128 /*پرداخت به واسط*/ THEN 3 /*Broker*/
                        WHEN PH.Type = 2048 THEN 5
                        END                          PartyRoleType,
                    ''                               PartyRoleTypeTitle,
                    6 /*Payment*/                    EntityType,
                    ''                               EntityTypeTitle,
                    PH.Number                        EntityNumber,
                    PH.Date                          HeaderDate,
                    CAST(PC.Number AS NVARCHAR(MAX)) ItemNumber,
                    PC.Description                   ItemDescription,
                    ''                               ItemTitle,
                    19                               ItemTitleCode,
                    PC.AmountInBaseCurrency          ItemFee,
                    NULL                             ItemQuantity,
                    PC.AmountInBaseCurrency          DebitAmount,
                    0                                CreditAmount,
                    ''                               RelatedPeople
             FROM RPA.vwPaymentHeader PH
                      INNER JOIN RPA.PaymentCheque PC
                                 ON PH.PaymentHeaderId = PC.PaymentHeaderRef
             WHERE (PH.State <> 4)
               AND PC.State != 4 /*ابطال شده*/
               AND (@EntityType = 6 /*Payment*/OR @EntityType = -1)
               AND (PH.PaymentHeaderId = @EntityId OR @EntityId = -1)
               AND (PH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --حواله هاي اعلاميه پرداخت
             SELECT PH.PaymentHeaderId               EntityID,
                    PH.DlCode                        PartyCode,
                    PH.DlTitle                       PartyName,
                    PH.DlRef                         PartyDLRef,
                    CASE
                        WHEN PH.Type = 1 /*پرداخت به مشتري*/ THEN 1 /*Customer*/
                        WHEN PH.Type = 256 /*پرداخت به تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN PH.Type = 2 /*پرداخت به ساير*/ THEN 4 /*Other*/
                        WHEN PH.Type = 128 /*پرداخت به واسط*/ THEN 3 /*Broker*/
                        WHEN PH.Type = 2048 THEN 5
                        END                          PartyRoleType,
                    ''                               PartyRoleTyeTitle,
                    6                                EntityType,
                    ''                               EntityTypeTitle,
                    PH.Number                        EntityNumber,
                    PH.Date                          HeaderDate,
                    PD.Number                        ItemNumber,
                    PD.Description                   ItemDescription,
                    ''                               ItemTitle,
                    20                               ItemTitleCode,
                    PD.AmountInBaseCurrency          ItemFee,
                    NULL                             ItemQuantity,
                    PD.AmountInBaseCurrency          DebitAmount,
                    0                                CreditAmount,
                    ''                               RelatedPeople
             FROM RPA.vwPaymentHeader PH
                      INNER JOIN RPA.PaymentDraft PD
                                 ON PH.PaymentHeaderId = PD.PaymentHeaderRef
             WHERE (PH.State <> 4)
               AND (@EntityType = 6 /*Payment*/OR @EntityType = -1)
               AND (PH.PaymentHeaderId = @EntityId OR @EntityId = -1)
               AND (PH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --چك هاي خرج شده
             SELECT PH.PaymentHeaderID       EntityID
                  , PH.DlCode                PartyCode
                  , PH.DLTitle               PartyName
                  , PH.DlRef                 PartyDLRef
                  , CASE
                        WHEN PH.Type = 1 /*پرداخت به مشتري*/ THEN 1 /*Customer*/
                        WHEN PH.Type = 256 /*پرداخت به تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN PH.Type = 2 /*پرداخت به ساير*/ THEN 4 /*Other*/
                        WHEN PH.Type = 128 /*پرداخت به واسط*/ THEN 3 /*Broker*/
                        WHEN PH.Type = 2048 THEN 5
                 END                         PartyRoleType
                  , ''                       PartyRoleTyeTitle
                  , 6                        EntityType
                  , ''                       EntityTypeTitle
                  , PH.Number                EntityNumber
                  , PH.Date                  HeaderDate
                  , POC.Number               ItemNumber
                  , POC.Description          ItemDescription
                  , ''                       ItemTitle
                  , 21                       ItemTitleCode
                  , POC.AmountInBaseCurrency
                  , NULL                     ItemQuantity
                  , POC.AmountInBaseCurrency DebitAmount
                  , 0                        CreditAmount
                  , ''                       RelatedPeople
             FROM RPA.vwPaymentHeader PH
                      JOIN RPA.vwPaymentChequeOther POC ON POC.PaymentHeaderRef = PH.PaymentHeaderId
                      JOIN RPA.vwReceiptCheque RC ON RC.ReceiptChequeId = POC.ReceiptChequeRef
             WHERE (@EntityType = 6 /*Payment*/ OR @EntityType = -1)
               AND (PH.PaymentHeaderID = @EntityID OR @EntityID = -1)
               AND (PH.DLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

             SELECT EntityID           = RefundChequeId
                  , PartyCode          = DL.Code
                  , PartyName          = DL.Title
                  , PartyDLRef         = DL.DLId
                  , PartyRoleType      = CASE
                                             WHEN PH.Type = 1 THEN 1
                                             WHEN PH.Type = 256 THEN 2
                                             WHEN PH.Type = 2 THEN 4
                                             WHEN PH.Type = 128 THEN 3
                                             WHEN PH.Type = 2048 THEN 5
                                             END
                  , PartyRoleTypeTitle = ''
                  , EntityType         = 7
                  , EntityTypeTitle    = ''
                  ,                      RFC.Number
                  ,                      RFC.Date
                  , ItemNumber         = PC.Number
                  , ItemDescription    = RCI.RefundDescription
                  ,                      '' ItemTitle
                  ,                      23 ItemTitleCode
                  , ItemFee            = PC.Amount
                  , ItemQuantity       = NULL
                  , DebitAmount        = 0
                  , CreditAmount       = PC.AmountInBaseCurrency
                  , ''                   RelatedPeople
             FROM RPA.RefundChequeItem RCI
                      JOIN RPA.RefundCheque RFC ON RCI.RefundChequeRef = RFC.RefundChequeId
                      JOIN ACC.DL DL ON DL.DLId = RFC.DlRef
                      JOIN RPA.PaymentCheque PC ON PC.PaymentChequeId = RCI.PaymentChequeRef
                      JOIN RPA.PaymentHeader PH ON PH.PaymentHeaderId = PC.PaymentHeaderRef
             WHERE (RFC.Type = 2 AND PH.State = 4)
               AND (@EntityType = 7 OR @EntityType = -1)
               AND (RFC.RefundChequeId = @EntityId OR @EntityId = -1)
               AND (RCI.RefundChequeItemID = @EntityItemID OR @EntityItemID = -1)
               AND (RFC.DlRef = @PartyRef OR @PartyRef = -1)

             UNION ALL
             --استرداد چكهاي اعلاميه پرداخت
             SELECT RC.RefundChequeId                EntityID,
                    PH.DlCode                        PartyCode,
                    PH.DlTitle                       PartyName,
                    PH.DlRef                         PartyDLRef,
                    CASE
                        WHEN PH.Type = 1 /*پرداخت به مشتري*/ THEN 1 /*Customer*/
                        WHEN PH.Type = 256 /*پرداخت به تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN PH.Type = 2 /*پرداخت به ساير*/ THEN 4 /*Other*/
                        WHEN PH.Type = 128 /*پرداخت به واسط*/ THEN 3 /*Broker*/
                        WHEN PH.Type = 2048 THEN 5
                        END                          PartyRoleType,
                    ''                               PartyRoleTypeTitle,
                    9 /*Payment*/                    EntityType,
                    ''                               EntityTypeTitle,
                    RC.Number                        EntityNumber,
                    RC.Date                          HeaderDate,
                    CAST(PC.Number AS NVARCHAR(MAX)) ItemNumber,
                    RCI.RefundDescription            ItemDescription,
                    ''                               ItemTitle,
                    23                               ItemTitleCode,
                    PC.AmountInBaseCurrency          ItemFee,
                    NULL                             ItemQuantity,
                    0                                DebitAmount,
                    PC.AmountInBaseCurrency          CreditAmount,
                    ''                               RelatedPeople
             FROM RPA.vwPaymentHeader PH
                      INNER JOIN RPA.PaymentCheque PC
                                 ON PH.PaymentHeaderId = PC.PaymentHeaderRef
                      INNER JOIN RPA.RefundChequeItem RCI ON RCI.PaymentChequeRef = PC.PaymentChequeId
                      INNER JOIN RPA.RefundCheque RC ON RC.RefundChequeId = RCI.RefundChequeRef
             WHERE (PH.State <> 4)
               AND (@EntityType = 9 /*Payment*/OR @EntityType = -1)
               AND (RC.RefundChequeId = @EntityId OR @EntityId = -1)
               AND (RCI.RefundChequeItemId = @EntityItemId OR @EntityItemId = -1)
               AND (PH.DLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

             --مبلغ نقد رسيد دريافت
             SELECT RH.ReceiptHeaderId      EntityID,
                    RH.DlCode               PartyCode,
                    RH.DlTitle              PartyName,
                    RH.DlRef                PartyDLRef,
                    CASE
                        WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1 /*Customer*/
                        WHEN RH.Type = 16 /*دريافت از تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN RH.Type = 2 /*ساير دريافت ها*/ THEN 4 /*Other*/
                        WHEN RH.Type = 8 /*واسط*/ THEN 3 /*Broker*/
                        WHEN RH.Type = 64 THEN 5
                        END                 PartyRoleType,
                    ''                      PartyRoleTypeTitle,
                    3 /*Receipt*/           EntityType,
                    ''                      EntityTypeTitle,
                    RH.Number               EntityNumber,
                    RH.Date                 HeaderDate,
                    '1'                     ItemNumber,
                    RH.Description          ItemDescription,
                    ''                      ItemTitle,
                    18                      ItemTitleCode,
                    RH.AmountInBaseCurrency ItemFee,
                    NULL                    ItemQuantity,
                    0                       DebitAmount,
                    RH.AmountInBaseCurrency CreditAmount,
                    ''                      RelatedPeople
             FROM RPA.vwReceiptHeader RH
             WHERE (RH.State <> 4)
               AND (ISNULL(RH.AmountInBaseCurrency, 0) <> 0)
               AND (@EntityType = 3 /*Receipt*/OR @EntityType = -1)
               AND (RH.ReceiptHeaderId = @EntityId OR @EntityId = -1)
               AND (RH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --مبلغ تخفيف رسيد دريافت
             SELECT RH.ReceiptHeaderId        EntityID,
                    RH.DlCode                 PartyCode,
                    RH.DlTitle                PartyName,
                    RH.DlRef                  PartyDLRef,
                    CASE
                        WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1 /*Customer*/
                        WHEN RH.Type = 16 /*دريافت از تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN RH.Type = 2 /*ساير دريافت ها*/ THEN 4 /*Other*/
                        WHEN RH.Type = 8 /*واسط*/ THEN 3 /*Broker*/
                        WHEN RH.Type = 64 THEN 5
                        END                   PartyRoleType,
                    ''                        PartyRoleTypeTitle,
                    3 /*Receipt*/             EntityType,
                    ''                        EntityTypeTitle,
                    RH.Number                 EntityNumber,
                    RH.Date                   HeaderDate,
                    '1'                       ItemNumber,
                    RH.Description            ItemDescription,
                    ''                        ItemTitle,
                    25                        ItemTitleCode,
                    RH.DiscountInBaseCurrency ItemFee,
                    NULL                      ItemQuantity,
                    0                         DebitAmount,
                    RH.DiscountInBaseCurrency CreditAmount,
                    ''                        RelatedPeople
             FROM RPA.vwReceiptHeader RH
             WHERE (RH.State <> 4)
               AND (ISNULL(RH.DiscountInBaseCurrency, 0) <> 0)
               AND (@EntityType = 3 /*Receipt*/OR @EntityType = -1)
               AND (RH.ReceiptHeaderId = @EntityId OR @EntityId = -1)
               AND (RH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --چك هاي رسيد دريافت
             SELECT RH.ReceiptHeaderId               EntityID,
                    RH.DlCode                        PartyCode,
                    RH.DlTitle                       PartyName,
                    RH.DlRef                         PartyDLRef,
                    CASE
                        WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1 /*Customer*/
                        WHEN RH.Type = 16 /*دريافت از تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN RH.Type = 2 /*ساير دريافت ها*/ THEN 4 /*Other*/
                        WHEN RH.Type = 8 /*واسط*/ THEN 3 /*Broker*/
                        WHEN RH.Type = 64 THEN 5
                        END                          PartyRoleType,
                    ''                               PartyRoleTypeTitle,
                    3 /*Receipt*/                    EntityType,
                    ''                               EntityTypeTitle,
                    RH.Number                        EntityNumber,
                    RH.Date                          HeaderDate,
                    CAST(RC.Number AS NVARCHAR(MAX)) ItemNumber,
                    RC.Description                   ItemDescription,
                    ''                               ItemTitle,
                    19                               ItemTitleCode,
                    RC.AmountInBaseCurrency          ItemFee,
                    NULL                             ItemQuantity,
                    CASE
                        WHEN RH.State <> 4 THEN 0
                        ELSE RC.AmountInBaseCurrency
                        END                          DebitAmount,
                    CASE
                        WHEN RH.State <> 4 THEN RC.AmountInBaseCurrency
                        ELSE 0
                        END                          CreditAmount,
                    ''                               RelatedPeople
             FROM RPA.vwReceiptHeader RH
                      INNER JOIN RPA.ReceiptCheque RC
                                 ON RH.ReceiptHeaderId = RC.ReceiptHeaderRef
             WHERE (
                     (RH.State <> 4
                         AND (
                              (@ContainsCheque = 1 /*با احتساب چك هاي دريافتي*/
                                  AND (RC.State = 1 /*نزد صندوق*/
                                      OR RC.State = 2 /*واگذار به بانك*/
                                      OR RC.State = 4 /*وصول*/
                                      OR RC.State = 8 /*واخواست*/
                                      OR RC.State = 16 /*نقد شده*/
                                      OR RC.State = 32 /*خرج شده*/
                                      OR RC.State = 64 /*استرداد شده*/
                                   )
                                  )
                              OR
                              (@ContainsCheque = 0
                                  AND (RC.State = 4 /*وصول*/
                                      OR RC.State = 16 /*نقد شده*/
                                      OR RC.State = 32 /*خرج شده*/
                                      OR RC.State = 64 /*استرداد شده*/)
                                  )
                          )
                         )
                     OR
                     (RH.State = 4
                         AND @ContainsCheque = 0
                         AND (RC.State = 1 /*نزد صندوق*/
                             OR RC.State = 2 /*واگذار به بانك*/
                             OR RC.State = 8 /*واخواست*/
                          )
                         )
                 )
               AND (@EntityType = 3 /*Receipt*/OR @EntityType = -1)
               AND (RH.ReceiptHeaderId = @EntityId OR @EntityId = -1)
               AND (RH.DLRef = @PartyRef OR @PartyRef = -1)


             UNION ALL

             --حواله هاي رسيد دريافت
             SELECT RH.ReceiptHeaderId               EntityID,
                    RH.DlCode                        PartyCode,
                    RH.DlTitle                       PartyName,
                    RH.DlRef                         PartyDLRef,
                    CASE
                        WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1 /*Customer*/
                        WHEN RH.Type = 16 /*دريافت از تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN RH.Type = 2 /*ساير دريافت ها*/ THEN 4 /*Other*/
                        WHEN RH.Type = 8 /*واسط*/ THEN 3 /*Broker*/
                        WHEN RH.Type = 64 THEN 5
                        END                          PartyRoleType,
                    ''                               PartyRoleTypeTitle,
                    3 /*Receipt*/                    EntityType,
                    ''                               EntityTypeTitle,
                    RH.Number                        EntityNumber,
                    RH.Date                          HeaderDate,
                    CAST(RD.Number AS NVARCHAR(MAX)) ItemNumber,
                    RD.Description                   ItemDescription,
                    ''                               ItemTitle,
                    20                               ItemTitleCode,
                    RD.AmountInBaseCurrency          ItemFee,
                    NULL                             ItemQuantity,
                    0                                DebitAmount,
                    RD.AmountInBaseCurrency          CreditAmount,
                    ''                               RelatedPeople
             FROM RPA.vwReceiptHeader RH
                      INNER JOIN RPA.ReceiptDraft RD
                                 ON RH.ReceiptHeaderId = RD.ReceiptHeaderRef
             WHERE (RH.State <> 4)
               AND (@EntityType = 3 /*Receipt*/ OR @EntityType = -1)
               AND (RH.ReceiptHeaderId = @EntityId OR @EntityId = -1)
               AND (RH.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             --كارتخوانهاي رسيد دريافت
             SELECT RH.ReceiptHeaderId      EntityID,
                    RH.DlCode               PartyCode,
                    RH.DlTitle              PartyName,
                    RH.DlRef                PartyDLRef,
                    CASE
                        WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1 /*Customer*/
                        WHEN RH.Type = 16 /*دريافت از تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN RH.Type = 2 /*ساير دريافت ها*/ THEN 4 /*Other*/
                        WHEN RH.Type = 8 /*واسط*/ THEN 3 /*Broker*/
                        WHEN RH.Type = 64 THEN 5
                        END                 PartyRoleType,
                    ''                      PartyRoleTypeTitle,
                    3 /*Receipt*/           EntityType,
                    ''                      EntityTypeTitle,
                    RH.Number               EntityNumber,
                    RH.Date                 HeaderDate,
                    ''                      ItemNumber,
                    NULL                    ItemDescription,
                    ''                      ItemTitle,
                    24                      ItemTitleCode,
                    RP.AmountInBaseCurrency ItemFee,
                    NULL                    ItemQuantity,
                    0                       DebitAmount,
                    RP.AmountInBaseCurrency CreditAmount,
                    ''                      RelatedPeople
             FROM RPA.vwReceiptHeader RH
                      INNER JOIN RPA.ReceiptPos RP
                                 ON RH.ReceiptHeaderId = RP.ReceiptHeaderRef
             WHERE (RH.State <> 4)
               AND (@EntityType = 3 /*Receipt*/OR @EntityType = -1)
               AND (RH.ReceiptHeaderId = @EntityId OR @EntityId = -1)
               AND (RH.DLRef = @PartyRef OR @PartyRef = -1)

               UNION ALL

             --شارژ تنخواه
             SELECT RH.ReceiptHeaderId      EntityID,
                    RH.DlCode				PartyCode,
                    RH.DLTitle				PartyName,
                    RH.DLRef			    PartyDLRef,
                    CASE
						WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1 /*Customer*/
						WHEN RH.Type = 16 /*دريافت از تامين كننده*/ THEN 2 /*Vendor*/
						WHEN RH.Type = 2 /*ساير دريافت ها*/ THEN 4 /*Other*/
						WHEN RH.Type = 8 /*واسط*/ THEN 3 /*Broker*/
						WHEN RH.Type = 64 THEN 5
					END						PartyRoleType,
                    ''                      PartyRoleTypeTitle,
                    3 /*Receipt*/			EntityType,
                    ''                      EntityTypeTitle,
                    RH.Number               EntityNumber,
                    RH.Date                 HeaderDate,
                    ''                      ItemNumber,
                    NULL                    ItemDescription,
                    ''                      ItemTitle,
                    31                      ItemTitleCode,
                    RPC.AmountInBaseCurrency ItemFee,
                    NULL                    ItemQuantity,
                    0						DebitAmount,
                    RPC.AmountInBaseCurrency CreditAmount,
                    ''                      RelatedPeople
             FROM RPA.vwReceiptHeader RH
                      INNER JOIN RPA.ReceiptPettyCash RPC
                                 ON RH.ReceiptHeaderId = RPC.ReceiptHeaderRef
					  INNER JOIN RPA.PettyCash PC
                                 ON RPC.PettyCashRef = PC.PettyCashId
					  INNER JOIN GNR.VWParty P
								 ON P.PartyId = PC.PartyRef
             WHERE (RH.State <> 4)
               AND (@EntityType = 3 OR @EntityType = -1)  
               AND (RH.ReceiptHeaderId = @EntityId OR @EntityId = -1)  
               AND (RH.DLRef = @PartyRef OR @PartyRef = -1)

			 UNION ALL 

			 SELECT RH.ReceiptHeaderId      EntityID,
                    P.DLCode				PartyCode,
                    P.DLTitle				PartyName,
                    P.DLRef					PartyDLRef,
                    5						PartyRoleType,
                    ''                      PartyRoleTypeTitle,
                    46 /*PettyCharge*/      EntityType,
                    ''                      EntityTypeTitle,
                    RH.Number               EntityNumber,
                    RH.Date                 HeaderDate,
                    ''                      ItemNumber,
                    NULL                    ItemDescription,
                    ''                      ItemTitle,
                    31                      ItemTitleCode,
                    RPC.AmountInBaseCurrency ItemFee,
                    NULL                    ItemQuantity,
                    RPC.AmountInBaseCurrency DebitAmount,
                    0						CreditAmount,
                    ''                      RelatedPeople
             FROM RPA.vwReceiptHeader RH
                      INNER JOIN RPA.ReceiptPettyCash RPC
                                 ON RH.ReceiptHeaderId = RPC.ReceiptHeaderRef
					  INNER JOIN RPA.PettyCash PC
                                 ON RPC.PettyCashRef = PC.PettyCashId
					  INNER JOIN GNR.VWParty P
								 ON P.PartyId = PC.PartyRef
             WHERE (RH.State <> 4)
               AND (@EntityType = 46 OR @EntityType = -1)  
               AND (RH.ReceiptHeaderId = @EntityId OR @EntityId = -1)  
               AND (P.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             SELECT EntityID           = RefundChequeId
                  , PartyCode          = DL.Code
                  , PartyName          = DL.Title
                  , PartyDLRef         = DL.DLId
                  , PartyRoleType      = CASE
                                             WHEN RH.Type = 1 THEN 1
                                             WHEN RH.Type = 16 THEN 2
                                             WHEN RH.Type = 2 THEN 4
                                             WHEN RH.Type = 8 THEN 3
                                             WHEN RH.Type = 64 THEN 5
                                             END
                  , PartyRoleTypeTitle = ''
                  , EntityType         = 5
                  , EntityTypeTitle    = ''
                  ,                      RFC.Number
                  ,                      RFC.Date
                  , ItemNumber         = RC.Number
                  , ItemDescription    = RCI.RefundDescription
                  , ItemTitle          = ''
                  ,                      26 ItemTitleCode
                  , ItemFee            = RC.Amount
                  , ItemQuantity       = NULL
                  , DebitAmount        = RC.AmountInBaseCurrency
                  , CreditAmount       = 0,
                  ''                     RelatedPeople
             FROM RPA.RefundChequeItem RCI
                      JOIN RPA.RefundCheque RFC ON RCI.RefundChequeRef = RFC.RefundChequeId
                      JOIN ACC.DL DL ON DL.DLId = RFC.DlRef
                      JOIN RPA.ReceiptCheque RC ON RC.ReceiptChequeId = RCI.ReceiptChequeRef
                      JOIN RPA.ReceiptHeader RH ON RH.ReceiptHeaderId = RC.ReceiptHeaderRef
             WHERE (RFC.Type = 1 AND RH.State = 4)
               AND (@EntityType = 5 OR @EntityType = -1)
               AND (RFC.RefundChequeId = @EntityId OR @EntityId = -1)
               AND (RCI.RefundChequeItemID = @EntityItemID OR @EntityItemID = -1)
               AND (RFC.DlRef = @PartyRef OR @PartyRef = -1)


             UNION ALL
             --استرداد چكهاي رسيد دريافت

             SELECT RFC.RefundChequeId               EntityID,
                    RH.DlCode                        PartyCode,
                    RH.DlTitle                       PartyName,
                    RH.DlRef                         PartyDLRef,
                    CASE

                        WHEN RH.Type = 1 /*دريافت از مشتري*/ THEN 1 /*Customer*/
                        WHEN RH.Type = 16 /*دريافت از تامين كننده*/ THEN 2 /*Vendor*/
                        WHEN RH.Type = 2 /*ساير دريافت ها*/ THEN 4 /*Other*/
                        WHEN RH.Type = 8 /*واسط*/ THEN 3 /*Broker*/
                        WHEN RH.Type = 64 THEN 5
                        END                          PartyRoleType,

                    ''                               PartyRoleTypeTitle,
                    8 /*RefundReceiptCheque*/
                                                     EntityType,
                    ''                               EntityTypeTitle,
                    RFC.Number                       EntityNumber,
                    RFC.Date                         HeaderDate,
                    CAST(RC.Number AS NVARCHAR(MAX)) ItemNumber,
                    RCI.RefundDescription            ItemDescription,
                    ''                               ItemTitle,
                    26                               ItemTitleCode,
                    RC.AmountInBaseCurrency          ItemFee,
                    NULL                             ItemQuantity,
                    RC.AmountInBaseCurrency          DebitAmount,
                    0                                CreditAmount,
                    ''                               RelatedPeople
             FROM RPA.vwReceiptHeader RH
                      INNER JOIN RPA.ReceiptCheque RC
                                 ON RH.ReceiptHeaderId = RC.ReceiptHeaderRef
                      INNER JOIN RPA.RefundChequeItem RCI
                                 ON RCI.ReceiptChequeRef = RC.ReceiptChequeId
                      INNER JOIN RPA.RefundCheque RFC
                                 ON RFC.RefundChequeId = RCI.RefundChequeRef
             WHERE RH.State <> 4
               AND RFC.Type = 1
               AND (@EntityType = 8 /*RefundReceiptCheque*/
                 OR @EntityType = -1)
               AND (RFC.RefundChequeId = @EntityId OR @EntityId = -1)
               AND (RCI.RefundChequeItemId = @EntityItemId OR @EntityItemId = -1)
               AND (RH.DLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL
             --استرداد برگشت چك هاي خرج شده
             SELECT                 a.EntityId
                  ,                 a.PartyCode
                  ,                 a.PartyName
                  ,                 a.PartyDLRef
                  , PartyRoleType = CASE
                                        WHEN a.PaymentType = 1 THEN 1
                                        WHEN a.PaymentType = 256 THEN 2
                                        WHEN a.PaymentType = 2 THEN 4
                                        WHEN a.PaymentType = 128 THEN 3
                                        WHEN a.PaymentType = 2048 THEN 5
                                        END
                  ,                 a.PartyRoleTypeTitle
                  ,                 a.EntityType
                  ,                 a.EntityTypeTitle
                  ,                 a.EntityNumber
                  ,                 a.HeaderDate
                  ,                 a.ItemNumber
                  ,                 a.ItemDescription
                  ,                 a.ItemTitle
                  ,                 a.ItemTitleCode
                  ,                 a.ItemFee
                  ,                 a.ItemQuantity
                  ,                 a.DebitAmount
                  ,                 a.CreditAmount,
                  ''                RelatedPeople
             FROM (
                      SELECT           RFC.RefundChequeId               EntityID,
                                       RFC.DlCode                       PartyCode,
                                       RFC.DlTitle                      PartyName,
                                       RFC.DlRef                        PartyDLRef,
                          PaymentType =(
                                           SELECT PH.Type
                                           FROM RPA.ReceiptChequeHistory RCH
                                                    JOIN RPA.ReceiptChequeHistory PRCH
                                                         ON PRCH.ReceiptChequeHistoryId = RCH.ReceiptChequeHistoryRef
                                                    JOIN RPA.PaymentChequeOther PCO
                                                         ON PCO.PaymentChequeOtherId = PRCH.PaymentChequeOtherRef
                                                    JOIN RPA.PaymentHeader PH ON PH.PaymentHeaderId = PCO.PaymentHeaderRef
                                           WHERE RCH.ReceiptChequeRef = RCI.ReceiptChequeRef
                                             AND RCH.RefundChequeItemRef = RCI.RefundChequeItemID
                                       ),
                                       ''                               PartyRoleTypeTitle,
                                       4 /*ReturnChequeOther*/
                                                                        EntityType,
                                       ''                               EntityTypeTitle,
                                       RFC.Number                       EntityNumber,
                                       RFC.Date                         HeaderDate,
                                       CAST(RC.Number AS NVARCHAR(MAX)) ItemNumber,
                                       RCI.RefundDescription            ItemDescription,
                                       ''                               ItemTitle,
                                       27                               ItemTitleCode,
                                       RC.AmountInBaseCurrency          ItemFee,
                                       NULL                             ItemQuantity,
                                       0                                DebitAmount,
                                       RC.AmountInBaseCurrency          CreditAmount
                      FROM RPA.vwReceiptHeader RH
                               JOIN RPA.ReceiptCheque RC ON RH.ReceiptHeaderId = RC.ReceiptHeaderRef
                               JOIN RPA.RefundChequeItem RCI ON RCI.ReceiptChequeRef = RC.ReceiptChequeId
                               JOIN RPA.vwRefundCheque RFC ON RFC.RefundChequeId = RCI.RefundChequeRef
                      WHERE RFC.Type = 4
                        AND (@EntityType = 4 /*ReturnChequeOther*/
                          OR @EntityType = -1)
                        AND (RFC.RefundChequeId = @EntityId OR @EntityId = -1)
                        AND (RCI.RefundChequeItemId = @EntityItemID OR @EntityItemID = -1)
                        AND (RFC.DLRef = @PartyRef OR @PartyRef = -1)
                  ) a
             UNION ALL
--قلم فاكتور فروش
             SELECT I.InvoiceId                        EntityID,
                    I.CustomerPartyDLCode              PartyCode,
                    I.CustomerPartyName                PartyName,
                    I.CustomerPartyDLRef               PartyDLRef,
                    1 /*Customer*/                     PartyRoleType,
                    ''                                 PartyRoleTypeTitle,
                    1 /*Invoice*/                      EntityType,
                    ''                                 EntityTypeTitle,
                    I.Number                           EntityNumber,
                    I.Date                             HeaderDate,
                    CAST(II.ItemCode AS NVARCHAR(MAX)) ItemNumber,
                    II.Description                     ItemDescription,
                    ItemTitle,
                    null                               ItemTitleCode,
                    II.Fee                             ItemFee,
                    II.Quantity                        ItemQuantity,
                    (II.NetPriceInBaseCurrency)        DebitAmount,
                    0                                  CreditAmount,
                    ''                                 RelatedPeople
             FROM SLS.vwInvoice I
                      INNER JOIN SLS.vwInvoiceItem II
                                 ON I.InvoiceId = II.InvoiceRef
             WHERE I.State = 1
               AND (@EntityType = 1 /*Invoice*/ OR @EntityType = -1)
               AND (I.InvoiceId = @EntityId OR @EntityId = -1)
               AND (I.CustomerPartyDLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL
--قلم واسط فاكتور فروش
             SELECT I.InvoiceId                 EntityID,
                    DL.Code                     PartyCode,
                    DL.Title                    PartyName,
                    DL.DLId                     PartyDLRef,
                    3 /*Broker*/                PartyRoleType,
                    ''                          PartyRoleTypeTitle,
                    15 /*InvoiceBroker*/        EntityType,
                    ''                          EntittyTypeTitle,
                    I.Number                    EntityNumber,
                    I.Date                      HeaderDate,
                    ''                          ItemNumber,
                    NULL                        ItemDescription,
                    ''                          ItemTitle,
                    28                          ItemTitleCode,
                    IB.CommissionInBaseCurrency ItemFee,
                    NULL                        ItemQuantity,
                    0                           DebitAmount,
                    IB.CommissionInBaseCurrency CreditAmount,
                    ''                          RelatedPeople
             FROM SLS.vwInvoice I
                      INNER JOIN SLS.InvoiceBroker IB ON I.InvoiceId = IB.InvoiceRef
                      INNER JOIN GNR.Party P ON P.PartyId = IB.PartyRef
                      INNER JOIN ACC.DL DL ON P.DlRef = DL.DLId
             WHERE I.State = 1
               AND (@EntityType = 15 /*InvoiceBroker*/ OR @EntityType = -1)
               AND (I.InvoiceId = @EntityId OR @EntityId = -1)
               AND (P.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             SELECT             cc.CommissionCalculationID EntityID,
                                DL.Code                    PartyCode,
                                DL.Title                   PartyName,
                                DL.DLId                    PartyDLRef,
                                3 /*Broker*/               PartyRoleType,
                                ''                         PartyRoleTypeTitle,
                                33 /*CommissionBroker*/    EntityType,
                                ''                         EntittyTypeTitle,
                 EntityNumber = NULL,
                                cc.ToDate                  HeaderDate,
                                ''                         ItemNumber,
                                NULL                       ItemDescription,
                                ''                         ItemTitle,
                                NULL                       ItemTitleCode,
                                cci.Amount                 ItemFee,
                                NULL                       ItemQuantity,
                                0                          DebitAmount,
                                cci.Amount                 CreditAmount,
                                ''                         RelatedPeople
             FROM SLS.vwCommissionCalculationItem cci
                      INNER JOIN SLS.vwCommissionCalculation cc
                                 ON cc.CommissionCalculationId = cci.CommissionCalculationRef
                      INNER JOIN GNR.Party P ON P.PartyId = cc.BrokerPartyRef
                      INNER JOIN ACC.DL DL ON P.DlRef = DL.DLId
             WHERE (@EntityType = 33 /*CommissionBroker*/ OR @EntityType = -1)
               AND (cc.CommissionCalculationID = @EntityId OR @EntityId = -1)
               AND (P.DLRef = @PartyRef OR @PartyRef = -1)

             UNION ALL

             -- قلم فاكتور برگشتي
             SELECT RI.ReturnedInvoiceId                EntityID,
                    RI.CustomerPartyDLCode              PartyCode,
                    RI.CustomerPartyName                PartyName,
                    RI.CustomerPartyDLRef               PartyDLRef,
                    1 /*Customer*/                      PartyRoleType,
                    ''                                  PartyRoleTypeTitle,
                    2 /*ReturnedInvoice*/               EntityType,
                    ''                                  EntityTypeTitle,
                    RI.Number                           EntityNumber,
                    RI.Date                             HeaderDate,
                    CAST(RII.ItemCode AS NVARCHAR(MAX)) ItemNumber,
                    RII.Description                     ItemDescription,
                    ItemTitle                           ItemTitle,
                    NULL                                ItemTitleCode,
                    RII.Fee                             ItemFee,
                    RII.Quantity                        ItemQuantity,
                    0                                   DebitAmount,
                    RII.NetPriceInBaseCurrency          CreditAmount,
                    ''                                  RelatedPeople
             FROM SLS.vwReturnedInvoice RI
                      INNER JOIN SLS.vwReturnedInvoiceItem RII
                                 ON RI.ReturnedInvoiceId = RII.ReturnedInvoiceRef
             WHERE (@EntityType = 2 /*ReturnedInvoice*/ OR @EntityType = -1)
               AND (RI.ReturnedInvoiceId = @EntityId OR @EntityId = -1)
               AND (RI.CustomerPartyDLRef = @PartyRef OR @PartyRef = -1)
             UNION ALL

--قلم واسط فاكتور برگشتي
             SELECT RI.ReturnedInvoiceId         EntityID,
                    DL.Code                      PartyCode,
                    DL.Title                     PartyName,
                    DL.DLId                      PartyDLRef,
                    3 /*Broker*/                 PartyRoleType,
                    ''                           PartyRoleTypeTitle,
                    16 /*ReturnedInvoiceBroker*/ EntityType,
                    ''                           EntittyTypeTitle,
                    RI.Number                    EntityNumber,
                    RI.Date                      HeaderDate,
                    ''                           ItemNumber,
                    NULL                         ItemDescription,
                    ''                           ItemTitle,
                    29                           ItemTitleCode,
                    RIB.CommissionInBaseCurrency ItemFee,
                    NULL                         ItemQuantity,
                    RIB.CommissionInBaseCurrency DebitAmount,
                    0                            CreditAmount,
                    ''                           RelatedPeople
             FROM SLS.vwReturnedInvoice RI
                      INNER JOIN SLS.ReturnedInvoiceBroker RIB ON RI.ReturnedInvoiceId = RIB.ReturnedInvoiceRef
                      INNER JOIN GNR.Party P ON P.PartyId = RIB.PartyRef
                      INNER JOIN ACC.DL DL ON DL.DLId = P.DLRef
             WHERE (@EntityType = 16 OR @EntityType = -1)
               AND (RI.ReturnedInvoiceId = @EntityId OR @EntityId = -1)
               AND (P.DLRef = @PartyRef OR @PartyRef = -1) 
             UNION ALL

            -- petty cash bill
            SELECT PCB.PettyCashBillId       EntityID,
                DL.Code                      PartyCode,
                DL.Title                     PartyName,
                DL.DLId                      PartyDLRef,
                5                            PartyRoleType,
                ''                           PartyRoleTypeTitle,
                45                           EntityType,
                ''                           EntittyTypeTitle,
                PCB.Number                   EntityNumber,
                PCB.Date                     HeaderDate,
                PCBI.RelatedNumbers          ItemNumber,
                PCBI.Description             ItemDescription,
                ''                           ItemTitle,
                30                           ItemTitleCode,
                PCBI.AmountInBaseCurrency    ItemFee,
                NULL                         ItemQuantity,
                0                            DebitAmount,
                PCBI.AmountInBaseCurrency    CreditAmount,
                PCBI.RelatedPeople           RelatedPeople
            FROM RPA.PettyCashBill PCB
                INNER JOIN RPA.PettyCashBillItem PCBI ON PCB.PettyCashBillId = PCBI.PettyCashBillRef
                INNER JOIN RPA.PettyCash PC ON PCB.PettyCashRef = PC.PettyCashId
                INNER JOIN GNR.Party P ON P.PartyId = PC.PartyRef
                INNER JOIN ACC.DL DL ON DL.DLId = P.DLRef
            WHERE (@EntityType = 45 OR @EntityType = -1)
                AND (PCB.PettyCashBillId = @EntityID OR @EntityID = -1)
                AND (P.DLRef = @PartyRef OR @PartyRef = -1)
                AND PCB.[State] = 2
         
         ) a

END	 