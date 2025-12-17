IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('PAY.Branch') AND
				[name] = 'CostCenterRef')
AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('PAY.Branch') AND
				[name] = 'CostCenterDlRef')
BEGIN
	update  PAY.Branch
	Set CostCenterDlref = (Select Dlref From Gnr.CostCenter Where CostCenterID = CostCenterRef)
	Where CostCenterRef Is NOT NULL
	AND CostCenterDLRef Is  NULL
END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('PAY.Contract') AND
				[name] = 'CostCenterRef')
AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('PAY.Contract') AND
				[name] = 'CostCenterDlRef')
BEGIN
update  PAY.[Contract]
	Set CostCenterDlref = (Select Dlref From Gnr.CostCenter Where CostCenterID = CostCenterRef)
	Where CostCenterRef Is NOT NULL
	AND CostCenterDLRef Is  NULL
END