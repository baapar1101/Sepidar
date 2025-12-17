If Object_ID('ACC.vwVoucher') Is Not Null
	Drop View ACC.vwVoucher
GO
CREATE VIEW ACC.vwVoucher
AS
    SELECT ACC.Voucher.VoucherId, ACC.Voucher.Number, ACC.Voucher.Date, ACC.Voucher.ReferenceNumber, ACC.Voucher.SecondaryNumber,
        ACC.Voucher.DailyNumber, ACC.Voucher.Type, ACC.Voucher.Description, ACC.Voucher.Description_En, ACC.Voucher.Version, ACC.Voucher.Creator,
        ACC.Voucher.CreationDate, ACC.Voucher.LastModifier, ACC.Voucher.LastModificationDate, ACC.Voucher.State, ACC.Voucher.FiscalYearRef, ACC.Voucher.MergedIssuerSystem,
        ACC.Voucher.IsMerged, ACC.Voucher.IssuerSystem, User_1.Name AS CreatorName, User_1.Name_En AS CreatorName_En, FMK.[User].Name AS LastModifierName, FMK.[User].Name_En AS LastModifierName_En,
        Totals.TotalCredit AS TotalAmount
    FROM ACC.Voucher
        INNER JOIN FMK.[User] AS User_1 ON ACC.Voucher.Creator = User_1.UserID
        INNER JOIN FMK.[User] ON ACC.Voucher.LastModifier = FMK.[User].UserID
        -- ACC.VoucherItem ON ACC.VoucherItem.VoucherRef = ACC.Voucher.VoucherId
    OUTER APPLY (
        SELECT SUM(VI.Credit) AS TotalCredit
        FROM ACC.VoucherItem VI
        WHERE VI.VoucherRef = Voucher.VoucherId
    ) Totals