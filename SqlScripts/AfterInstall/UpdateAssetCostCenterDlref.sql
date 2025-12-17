
DECLARE @SQLString nvarchar(500)
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.AcquisitionReceiptItem') AND
				[name] = 'CostCenterRef')
AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.AcquisitionReceiptItem') AND
				[name] = 'CostCenterDlRef')
BEGIN

SET @SQLString = '
Update [AST].[AcquisitionReceiptItem] 
SET CostCenterDlref = (select Dlref  from Gnr.CostCenter Where  CostCenterID = CostCenterRef)
WHERE CostcenterRef Is NOT NULL
ANd CostcenterDlref IS NULL'

EXEC sp_executesql @SQLString 

END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Asset') AND
				[name] = 'CostCenterRef')
AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.Asset') AND
				[name] = 'CostCenterDlRef')
BEGIN

SET @SQLString = '
	Update [AST].[Asset]
	SET CostCenterDlref = (select Dlref  from Gnr.CostCenter Where  CostCenterID = CostCenterRef)
	WHERE CostcenterRef Is NOT NULL
	ANd CostcenterDlref IS NULL'

EXEC sp_executesql @SQLString 
END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'CostCenterRef')
AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'CostCenterDlRef')
BEGIN

SET @SQLString = '
	Update [AST].[TransferItem]
	SET CostCenterDlref = (select Dlref  from Gnr.CostCenter Where  CostCenterID = CostCenterRef )
	WHERE CostcenterRef Is NOT NULL
	ANd CostcenterDlref IS NULL'

EXEC sp_executesql @SQLString 
END
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'preCostCenterRef')
AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.TransferItem') AND
				[name] = 'PReCostCenterDlref')
BEGIN

SET @SQLString = '
	Update [AST].[TransferItem]
	SET PReCostCenterDlref = (select Dlref  from Gnr.CostCenter Where  CostCenterID = preCostCenterRef )
	WHERE preCostcenterRef Is NOT NULL
	ANd preCostcenterDlref IS NULL'

EXEC sp_executesql @SQLString 

END
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.AssetTransaction') AND
				[name] = 'CostCenterRef')
AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('AST.AssetTransaction') AND
				[name] = 'CostCenterDlref')
BEGIN

SET @SQLString = '
	Update [AST].[AssetTransaction]
	SET CostCenterDlref = (select Dlref  from Gnr.CostCenter Where  CostCenterID = CostCenterRef )
	WHERE CostcenterRef Is NOT NULL
	ANd CostcenterDlref IS NULL'

EXEC sp_executesql @SQLString 
END