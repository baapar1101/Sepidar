--To be deleted in Beta

UPDATE AST.CostPart                     SET MaxDepreciableBookValue = 5 WHERE ISNULL(MaxDepreciableBookValue,0) <> 5
UPDATE AST.CostPartTransaction          SET MaxDepreciableBookValue = 5 WHERE ISNULL(MaxDepreciableBookValue,0) <> 5
UPDATE AST.RepairItem                   SET MaxDepreciableBookValue = 5 WHERE ISNULL(MaxDepreciableBookValue,0) <> 5
UPDATE AST.AssetGroup                   SET MaxDepreciableBookValue = 5 WHERE ISNULL(MaxDepreciableBookValue,0) <> 5
UPDATE AST.AcquisitionReceiptItem       SET MaxDepreciableBookValue = 5 WHERE ISNULL(MaxDepreciableBookValue,0) <> 5
UPDATE AST.ChangeDepreciationMethodItem SET MaxDepreciableBookValue = 5 WHERE ISNULL(MaxDepreciableBookValue,0) <> 5
