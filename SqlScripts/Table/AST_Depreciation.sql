IF OBJECT_ID('AST.Depreciation') IS NULL
	CREATE TABLE [AST].[Depreciation](
		[DepreciationID] [int] NOT NULL,
		[Date] [datetime] NOT NULL,
		[AssetRef] [int] NOT NULL,
		[AssetTransactionRef] [int] NOT NULL,
		[LastAssetTransactionRef] [int] NOT NULL,
		[VoucherRef] [int] NULL,
		[FiscalYearRef] [int] NOT NULL,
		[Creator] [int] NOT NULL,
		[CreationDate] [datetime] NOT NULL,
		[LastModifier] [int] NOT NULL,
		[LastModificationDate] [datetime] NOT NULL,
		[Version] [int] NOT NULL,
	) ON [PRIMARY]
GO

IF COLUMNPROPERTY(OBJECT_ID('AST.Depreciation'), 'LastAssetTransactionRef' , 'AllowsNull') IS NULL
BEGIN
	ALTER TABLE AST.Depreciation ADD [LastAssetTransactionRef] [int] NULL
END
GO
IF COLUMNPROPERTY(OBJECT_ID('AST.Depreciation'), 'LastAssetTransactionRef' , 'AllowsNull') = 1
BEGIN
	UPDATE A SET 
	   LastAssetTransactionRef = B.AssetTransactionRef
	FROM       AST.Depreciation    A 
	LEFT JOIN AST.AssetTransaction B ON A.AssetTransactionRef = B.AssetTransactionID
	WHERE LastAssetTransactionRef IS NULL

   IF NOT EXISTS(SELECT 1 FROM AST.Depreciation where LastAssetTransactionRef IS NULL)
	   ALTER TABLE AST.Depreciation ALTER COLUMN [LastAssetTransactionRef] [int] NOT NULL
END
GO
IF OBJECT_ID('AST.PK_AST_Depreciation') IS NULL
	 ALTER TABLE [AST].[Depreciation] ADD CONSTRAINT 
	   [PK_AST_Depreciation] PRIMARY KEY CLUSTERED ([DepreciationID] ASC
	) ON [PRIMARY]
GO

IF OBJECT_ID('AST.FK_AST_Depreciation_AssetRef') IS NULL
	ALTER TABLE [AST].[Depreciation]  ADD CONSTRAINT 
	  [FK_AST_Depreciation_AssetRef] FOREIGN KEY([AssetRef]) REFERENCES [AST].[Asset] ([AssetID])
GO

IF OBJECT_ID('AST.FK_AST_Depreciation_AssetTransactionRef') IS NULL
	ALTER TABLE [AST].[Depreciation]  ADD CONSTRAINT 
	  [FK_AST_Depreciation_AssetTransactionRef] FOREIGN KEY([AssetTransactionRef]) REFERENCES [AST].[AssetTransaction] ([AssetTransactionID])
GO

IF OBJECT_ID('AST.FK_AST_Depreciation_LastAssetTransactionRef') IS NULL
	ALTER TABLE [AST].[Depreciation]  ADD CONSTRAINT 
	  [FK_AST_Depreciation_LastAssetTransactionRef] FOREIGN KEY([LastAssetTransactionRef]) REFERENCES [AST].[AssetTransaction] ([AssetTransactionID])
GO

IF OBJECT_ID('AST.FK_AST_Depreciation_FiscalYearRef') IS NULL
	ALTER TABLE [AST].[Depreciation]  ADD CONSTRAINT 
	  [FK_AST_Depreciation_FiscalYearRef] FOREIGN KEY([FiscalYearRef]) REFERENCES [FMK].[FiscalYear] ([FiscalYearID])
GO
IF OBJECT_ID('AST.FK_AST_Depreciation_VoucherRef') IS NULL
	ALTER TABLE [AST].[Depreciation]  ADD CONSTRAINT 
     [FK_AST_Depreciation_VoucherRef] FOREIGN KEY (VoucherRef) REFERENCES [ACC].[Voucher](VoucherID)
GO
