DELETE FROM MRP.ObjectDependency WHERE FactTableName = 'MRP.SaleFacts'
INSERT INTO MRP.ObjectDependency (FactTableName, DependentView, DateBased) VALUES
    ('MRP.SaleFacts', 'MRP.vwReturnedSaleInvoiceVersion', 1),
    ('MRP.SaleFacts', 'MRP.vwSaleInvoiceVersion', 1),
	('MRP.SaleFacts', 'MRP.vwItemVersion', 0);
GO

DELETE FROM MRP.ObjectDependency WHERE FactTableName = 'MRP.ItemTransactionsFact'
INSERT INTO MRP.ObjectDependency (FactTableName, DependentView, DateBased) VALUES
    ('MRP.ItemTransactionsFact', 'MRP.vwInventoryDeliveryVersion', 1),
    ('MRP.ItemTransactionsFact', 'MRP.vwInventoryReceiptVersion', 1),
	('MRP.ItemTransactionsFact', 'MRP.vwItemVersion', 0);
GO

DELETE FROM MRP.ObjectDependency WHERE FactTableName = 'MRP.ReceivableCommitmentsFact'
INSERT INTO MRP.ObjectDependency (FactTableName, DependentView, DateBased) VALUES
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwShredItemVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwStatusVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwReceiptChequeVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwReceiptChequeBankingVersion', 1),
    -- for GNR.fnGetPartyCustomerTransactions:
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwDebitCreditNoteVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwPartyOpeningBalanceVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwRefundChequeVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwReceiptHeaderVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwReturnedSaleInvoiceVersion', 1),
    ('MRP.ReceivableCommitmentsFact', 'MRP.vwSaleInvoiceVersion', 1);
GO