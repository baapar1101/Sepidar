IF NOT EXISTS (SELECT * 
               FROM   cnt.guarantee 
               WHERE  oldcontractwarrantyitemid IS NOT NULL) 

  BEGIN 
      DECLARE @RecordCount INT = 0 
      DECLARE @ItemId INT 
      DECLARE @Step INT = 0 
      DECLARE @ID INT = 0 

      SELECT @RecordCount = Count(1) 
      FROM   cnt.contractwarrantyitem          

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.Guarantee', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO [CNT].[guarantee] 
                  ([guaranteeid], 
                   [date], 
                   [documentnumber], 
                   [tenderref], 
                   [contractref], 
                   [warrantyref], 
                   [regard], 
                   [dlref], 
                   [price], 
                   [duedate], 
                   [deliverydate], 
                   [furtherinfo], 
                   [description], 
                   [description_en], 
                   [state], 
                   [version], 
                   [creator], 
                   [creationdate], 
                   [lastmodifier], 
                   [lastmodificationdate], 
                   [fiscalyearref], 
                   [oldcontractwarrantyitemid],
                              [Nature]) 
      SELECT Row_number() OVER (ORDER BY contractwarrantyitemid) 
             + @ID, 
             C.date, 
             Row_number() 
               OVER( 
                 partition BY regard 
                 ORDER BY contractwarrantyitemid), 
             NULL, 
             CW.contractref, 
             warrantyref, 
             regard, 
             C.dlref, 
             price, 
             duedate, 
             deliverydate, 
             furtherinfo, 
             CW.description, 
             CW.description_en, 
             1, 
             C.version, 
             C.creator, 
             c.creationdate, 
             c.lastmodifier, 
             C.lastmodificationdate, 
             C.fiscalyearref, 
             contractwarrantyitemid,
                     1 Nature
      FROM   cnt.contractwarrantyitem CW 
             INNER JOIN cnt.contract C 
                     ON C.contractid = CW.contractref        
     
              UPDATE fmk.idgeneration 
              SET    lastid = (SELECT ISNULL(Max(guaranteeid), 0) 
                                                FROM   [CNT].[guarantee]) 
              WHERE  tablename = 'CNT.Guarantee' 
  END 


go 

IF NOT EXISTS (SELECT * 
               FROM   cnt.contract 
               WHERE  oldchangeid IS NOT NULL) 
  BEGIN 
      DECLARE @RecordCount INT = 0 
      DECLARE @ItemId INT 
      DECLARE @Step INT = 0 
      DECLARE @ID INT = 0 

      --------------- Contract 
      SELECT @RecordCount = Count(1) 
      FROM   cnt.changeitem 

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.Contract', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO [CNT].[contract] 
                  ([contractid], 
                   [projectref], 
                   [date], 
                   [title], 
                   [title_en], 
                   [contractorpartyref], 
                   [location], 
                   [startdate], 
                   [enddate], 
                   [cost], 
                   [dlref], 
                   [contracttyperef], 
                   [description], 
                   [description_en], 
                   [allowedchangepercent], 
                   [established], 
                   [estimatedcost], 
                   [onaccountsum], 
                   [depositsum], 
                   [materialsum], 
                   [onaccountdepreciationpercent], 
                   [depositdepreciationpercent], 
                   [documentnumber], 
                   [version], 
                   [creator], 
                   [creationdate], 
                   [lastmodifier], 
                   [lastmodificationdate], 
                   [fiscalyearref], 
                   [contractrownumber], 
                   [contractdltype], 
                   [needsbillserial], 
                   [tenderref], 
                   [canceldate], 
                   [type], 
                   [contractref], 
                   [affectedchange], 
                   [primaryfee], 
                   [changeamount], 
                   [changeamounttype], 
                   [rownumber], 
                   [annexdocumentnumber], 
                   [annexdate], 
                   [oldchangeid],
				   [Nature]) 
      SELECT Row_number() OVER (ORDER BY changeid) + @ID ContractID, 
             C.projectref                                ProjectRef, 
             C.date                                      Date, 
             C.title                                     Title, 
             C.title_en                                  Title_En, 
             C.contractorpartyref                        ContractorPartyRef, 
             C.location                                  Location, 
             C.startdate                                 StartDate, 
             C.enddate                                   EndDate, 
             C.cost                                      Cost, 
             C.dlref                                     DLRef, 
             C.contracttyperef                           ContractTypeRef, 
             CHI.description                             Description, 
             CHI.description_en                          Description_En, 
             C.allowedchangepercent                      AllowedChangePercent, 
             C.established                               Established, 
             C.estimatedcost                             EstimatedCost, 
             C.onaccountsum                              OnAccountSum, 
             C.depositsum                                DepositSum, 
             C.materialsum                               MaterialSum, 
             C.onaccountdepreciationpercent 
             OnAccountDepreciationPercent, 
             C.depositdepreciationpercent 
             DepositDepreciationPercent, 
             C.documentnumber                            DocumentNumber, 
             1                                           Version, 
             C.creator                                   Creator, 
             C.creationdate                              CreationDate, 
             C.lastmodifier                              LastModifier, 
             C.lastmodificationdate                      LastModificationDate, 
             C.fiscalyearref                             FiscalYearRef, 
             C.contractrownumber                         ContractRowNumber, 
             C.contractdltype                            ContractDLType, 
             C.needsbillserial                           NeedsBillSerial, 
             C.tenderref                                 TenderRef, 
             C.canceldate                                CancelDate, 
             CHI.type                                    Type, 
             CHI.contractref                             ContractRef, 
             2                                           AffectedChange, 
             CHI.primaryfee                              PrimaryFee, 
             CHI.changeamount                            ChangeAmount, 
             CHI.changeamounttype                        ChangeAmountType, 
             CHI.rownumber + 1                           RowNumber, 
             NULL                                        AnnexDocumentNumber, 
             CHI.date                                    AnnexDate, 
             CHI.changeid                                OldChangeID,
			 1											 Nature
      FROM   cnt.changeitem CHI 
             INNER JOIN cnt.contract C 
                     ON CHI.contractref = C.contractid 

      UPDATE fmk.idgeneration 
      SET    lastid = (SELECT ISNULL(Max(contractid), 0) 
                       FROM   [CNT].[contract]) 
      WHERE  tablename = 'CNT.Contract' 

      --------------- ContractCoefficientItem 
      SET @RecordCount = 0 
      SET @Step = 0 
      SET @ID = 0 

      SELECT @RecordCount = Count(1) 
      FROM   [CNT].[contractcoefficientitem] 

      SELECT @RecordCount = @RecordCount * Count(1) 
      FROM   cnt.contract 
      WHERE  oldchangeid IS NOT NULL 

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.ContractCoefficientItem', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO cnt.contractcoefficientitem 
                  (contractcoefficientid, 
                   rownumber, 
                   coefficientref, 
                   contractref, 
                   [percent]) 
      SELECT Row_number() OVER (ORDER BY contractcoefficientid) 
             + @ID, 
             CCI.rownumber, 
             CCI.coefficientref, 
             C2.contractid, 
             CCI.[percent] 
      FROM   cnt.contractcoefficientitem AS CCI 
             INNER JOIN cnt.contract AS C 
                     ON C.contractid = CCI.contractref 
             INNER JOIN cnt.contract AS C2 
                     ON C2.contractref = C.contractid 
      WHERE  ( C2.oldchangeid IS NOT NULL ) 

      UPDATE fmk.idgeneration 
      SET    lastid = (SELECT ISNULL(Max(contractcoefficientid), 0)
                       FROM   [CNT].[contractcoefficientitem]) 
      WHERE  tablename = 'CNT.ContractCoefficientItem' 

      --------------- ContractPreReceiptItem 
      SET @RecordCount = 0 
      SET @Step = 0 
      SET @ID = 0 

      SELECT @RecordCount = Count(1) 
      FROM   [CNT].[contractprereceiptitem] 

      SELECT @RecordCount = @RecordCount * Count(1) 
      FROM   cnt.contract 
      WHERE  oldchangeid IS NOT NULL 

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.ContractPreReceiptItem', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO [CNT].[contractprereceiptitem] 
                  ([prereceiptid], 
                   [receiptref], 
                   [receiptnumber], 
                   [contractref], 
                   [rownumber], 
                   [date], 
                   [price], 
                   [type], 
                   [description], 
                   [description_en]) 
      SELECT Row_number() OVER (ORDER BY prereceiptid) 
             + @ID, 
             CPI.receiptref, 
             CPI.receiptnumber, 
             C2.contractid, 
             CPI.rownumber, 
             CPI.date, 
             CPI.price, 
             CPI.type, 
             CPI.description, 
             CPI.description_en 
      FROM   cnt.contractprereceiptitem AS CPI 
             INNER JOIN cnt.contract AS C 
                     ON C.contractid = CPI.contractref 
             INNER JOIN cnt.contract AS C2 
                     ON C2.contractref = C.contractid 
      WHERE  ( C2.oldchangeid IS NOT NULL ) 

      UPDATE fmk.idgeneration 
      SET    lastid = (SELECT ISNULL(Max(prereceiptid), 0) 
                       FROM   [CNT].[contractprereceiptitem]) 
      WHERE  tablename = 'CNT.ContractPreReceiptItem' 

      --------------- ContractEmployerMaterialsItem 
      SET @RecordCount = 0 
      SET @Step = 0 
      SET @ID = 0 

      SELECT @RecordCount = Count(1) 
      FROM   [CNT].[contractemployermaterialsitem] 

      SELECT @RecordCount = @RecordCount * Count(1) 
      FROM   cnt.contract 
      WHERE  oldchangeid IS NOT NULL 

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.ContractEmployerMaterialsItem', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO [CNT].[contractemployermaterialsitem] 
                  ([employermaterialsid], 
                   [contractref], 
                   [rownumber], 
                   [date], 
                   [stockref], 
                   [itemref], 
                   [quantity], 
                   [secondaryquantity], 
                   [fee], 
                   [receiptref], 
                   [receiptnumber], 
                   [description], 
                   [description_en], 
                   [tracingref]) 
      SELECT Row_number() OVER (ORDER BY employermaterialsid) 
             + @ID, 
             C2.contractid, 
             CEM.rownumber, 
             CEM.date, 
             CEM.stockref, 
             CEM.itemref, 
             CEM.quantity, 
             CEM.secondaryquantity, 
             CEM.fee, 
             CEM.receiptref, 
             CEM.receiptnumber, 
             CEM.description, 
             CEM.description_en, 
             CEM.tracingref 
      FROM   cnt.contractemployermaterialsitem AS CEM 
             INNER JOIN cnt.contract AS C 
                     ON C.contractid = CEM.contractref 
             INNER JOIN cnt.contract AS C2 
                     ON C2.contractref = C.contractid 
      WHERE  ( C2.oldchangeid IS NOT NULL ) 

      UPDATE fmk.idgeneration 
      SET    lastid = (SELECT ISNULL(Max(employermaterialsid), 0)
                       FROM   [CNT].[contractemployermaterialsitem]) 
      WHERE  tablename = 'CNT.ContractEmployerMaterialsItem' 

      --------------- ContractGuarantee 
      SET @RecordCount = 0 
      SET @Step = 0 
      SET @ID = 0 

      SELECT @RecordCount = Count(1) 
      FROM   cnt.vwcontractguarantee 

      SELECT @RecordCount = @RecordCount * Count(1) 
      FROM   cnt.contract 
      WHERE  oldchangeid IS NOT NULL 

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.Guarantee', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO [CNT].[guarantee] 
                  ([guaranteeid], 
                   [date], 
                   [documentnumber], 
                   [tenderref], 
                   [contractref], 
                   [warrantyref], 
                   [regard], 
                   [dlref], 
                   [price], 
                   [duedate], 
                   [deliverydate], 
                   [furtherinfo], 
                   [description], 
                   [description_en], 
                   [bankaccountref], 
                   [number],                    
                   [bankbranchref], 
                   [state], 
                   [voucherref], 
                   [paymentref], 
                   [version], 
                   [creator], 
                   [creationdate], 
                   [lastmodifier], 
                   [lastmodificationdate], 
                   [fiscalyearref], 
                   [oldcontractwarrantyitemid],
				   [Nature]) 
      SELECT Row_number() OVER (ORDER BY guaranteeid) 
             + @ID, 
             CG.date, 
             CG.documentnumber, 
             NULL, 
             C2.contractid, 
             CG.warrantyref, 
             CG.regard, 
             CG.dlref, 
             CG.price, 
             CG.duedate, 
             CG.deliverydate, 
             CG.furtherinfo, 
             CG.description, 
             CG.description_en, 
             CG.bankaccountref, 
             CG.number, 
             
             CG.bankbranchref, 
             CG.state, 
             CG.voucherref, 
             CG.paymentref, 
             1 [Version], 
             CG.creator, 
             CG.creationdate, 
             CG.lastmodifier, 
             CG.lastmodificationdate, 
             CG.fiscalyearref, 
             CG.oldcontractwarrantyitemid,
			 1 Nature 
      FROM   cnt.guarantee AS CG 
             INNER JOIN cnt.contract AS C 
                     ON C.contractid = CG.contractref 
             INNER JOIN cnt.contract AS C2 
                     ON C2.contractref = C.contractid 
      WHERE  ( C2.oldchangeid IS NOT NULL ) 
             AND CG.contractref IS NOT NULL 

      UPDATE fmk.idgeneration 
      SET    lastid = (SELECT ISNULL(Max(guaranteeid), 0)
                       FROM   [CNT].[guarantee]) 
      WHERE  tablename = 'CNT.Guarantee' 

      --------------- ContractWorkshopItem 
      SET @RecordCount = 0 
      SET @Step = 0 
      SET @ID = 0 

      SELECT @RecordCount = Count(1) 
      FROM   [CNT].[contractworkshopitem] 

      SELECT @RecordCount = @RecordCount * Count(1) 
      FROM   cnt.contract 
      WHERE  oldchangeid IS NOT NULL 

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.ContractWorkshopItem', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO [CNT].[contractworkshopitem] 
                  ([contractworkshopitemid], 
                   [rownumber], 
                   [contractref], 
                   [workshopref], 
                   [description], 
                   [description_en]) 
      SELECT Row_number() OVER (ORDER BY contractworkshopitemid) 
             + @ID, 
             CWI.rownumber, 
             C2.contractid, 
             CWI.workshopref, 
             CWI.description, 
             CWI.description_en 
      FROM   cnt.contractworkshopitem AS CWI 
             INNER JOIN cnt.contract AS C 
                     ON C.contractid = CWI.contractref 
             INNER JOIN cnt.contract AS C2 
                     ON C2.contractref = C.contractid 
      WHERE  ( C2.oldchangeid IS NOT NULL ) 

      UPDATE fmk.idgeneration 
      SET    lastid = (SELECT ISNULL(Max(contractworkshopitemid), 0)
                       FROM   [CNT].[contractworkshopitem]) 
      WHERE  tablename = 'CNT.ContractWorkshopItem' 

      --------------- ContractSupportingInsurance 
      SET @RecordCount = 0 
      SET @Step = 0 
      SET @ID = 0 

      SELECT @RecordCount = Count(1) 
      FROM   [CNT].[contractsupportinginsurance] 

      SELECT @RecordCount = @RecordCount * Count(1) 
      FROM   cnt.contract 
      WHERE  oldchangeid IS NOT NULL 

      EXEC [FMK].[Spgetnextid] 
        @tablename = 'CNT.ContractSupportingInsurance', 
        @id = @ItemId output, 
        @incvalue = @RecordCount 

      SET @Step = @ItemId - @RecordCount 

      SELECT @ID = @Step 

      INSERT INTO [CNT].[contractsupportinginsurance] 
                  ([contractsupportinginsuranceid], 
                   [contractref], 
                   [rownumber], 
                   [branchcode], 
                   [branchtitle], 
                   [branchtitle_en], 
                   [workshopcode], 
                   [description], 
                   [description_en]) 
      SELECT Row_number() OVER (ORDER BY contractsupportinginsuranceid) 
             + @ID, 
             C2.contractid, 
             CSI.rownumber, 
             CSI.branchcode, 
             CSI.branchtitle, 
             CSI.branchtitle_en, 
             CSI.workshopcode, 
             CSI.description, 
             CSI.description_en 
      FROM   cnt.contractsupportinginsurance AS CSI 
             INNER JOIN cnt.contract AS C 
                     ON C.contractid = CSI.contractref 
             INNER JOIN cnt.contract AS C2 
                     ON C2.contractref = C.contractid 
      WHERE  ( C2.oldchangeid IS NOT NULL ) 

      UPDATE fmk.idgeneration 
      SET    lastid = (SELECT ISNULL(Max(contractsupportinginsuranceid), 0)
                       FROM   [CNT].[contractsupportinginsurance]) 
      WHERE  tablename = 'CNT.ContractSupportingInsurance' 


		UPDATE fmk.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(contractid), 0) 
                       FROM   [CNT].[contract]) 
		WHERE  tablename = 'CNT.ContractHistory' 


		UPDATE CS
		SET CS.ContractRef = VWC.ContractId
		FROM CNT.CostStatement CS
		INNER JOIN CNT.vwContract VWC ON CS.ContractRef = VWC.ContractRef
		WHERE VWC.ContractRef IS NOT NULL


		UPDATE S
		SET S.ContractRef = VWC.ContractId
		FROM CNT.Status S
		INNER JOIN CNT.vwContract VWC ON S.ContractRef = VWC.ContractRef
		WHERE VWC.ContractRef IS NOT NULL

  END 
  GO
  

  IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('CNT.ContractEmployerMaterialsItem') AND
				[name] = 'TotalPrice')
	UPDATE CNT.ContractEmployerMaterialsItem SET TotalPrice = Fee * Quantity WHERE TotalPrice IS NULL

Go
  
  
  ------------Should be execute in second step
  ---------------Initialize
DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
DECLARE @CodeOther int, @AdminID int

--------------------------------------------------Step ONE

----Tax
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'Tax')
BEGIN

		--DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
		--DECLARE @CodeOther int, @AdminID int
		
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 
EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.Tax > 0)
	BEGIN
		
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 + ' + @ID + ', 
				 S.StatusID,
				 CCI.ContractCoefficientID,
				 null,
				 S.Tax
		  FROM   [CNT].[Status] S 
				 INNER JOIN cnt.contract AS C 
						 ON C.contractid = S.contractref 
				 INNER JOIN cnt.ContractCoefficientItem AS CCI 
						 ON CCI.contractref = C.contractid 
						   AND CCI.CoefficientRef = -2 /*Tax*/ 
		  WHERE  (S.Tax > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET Tax = 0
		WHERE StatusID IN (SELECT StatusID 
		                   FROM [CNT].[Status] S 
		                     INNER JOIN cnt.contract AS C 
		                        ON C.ContractID = S.ContractRef 
		                     INNER JOIN CNT.ContractCoefficientItem AS CCI 
		                        ON CCI.ContractRef = C.ContractID 
		                          AND CCI.CoefficientRef = -2
		                    WHERE  S.Tax > 0 )


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem'' 

	END
	')

END

----END Tax

----VAT
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'VAT')
BEGIN
		--DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
		--  DECLARE @CodeOther int, @AdminID int
		  
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.VAT > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 
EXECUTE 
('
	IF Exists (select 1 from CNT.Status S WHERE S.VAT > 0)
	BEGIN
		
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 +' +  @ID + ', 
				 S.StatusID,
				 CCI.ContractCoefficientID,
				 null,
				 S.VAT
		  FROM   [CNT].[Status] S 
				 INNER JOIN cnt.contract AS C 
						 ON C.contractid = S.contractref 
				 INNER JOIN cnt.ContractCoefficientItem AS CCI 
						 ON CCI.contractref = C.contractid 
						   AND CCI.CoefficientRef = -5 /*VAT*/ 
		  WHERE  (S.VAT > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET VAT = 0
		WHERE StatusID IN (SELECT StatusID 
		                   FROM [CNT].[Status] S 
		                     INNER JOIN cnt.contract AS C 
		                        ON C.ContractID = S.ContractRef 
		                     INNER JOIN CNT.ContractCoefficientItem AS CCI 
		                        ON CCI.ContractRef = C.ContractID 
		                          AND CCI.CoefficientRef = -5
		                    WHERE  S.VAT > 0 )


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem'' 

	END
	')

END
----END VAT

----Insurance
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'Insurance')
BEGIN

	
		  --DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
    --      DECLARE @CodeOther int, @AdminID int
		  
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.Insurance > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 

EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.Insurance > 0)
	BEGIN

		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 +' + @ID + ', 
				 S.StatusID,
				 CCI.ContractCoefficientID,
				 null,
				 S.Insurance
		  FROM   [CNT].[Status] S 
				 INNER JOIN cnt.contract AS C 
						 ON C.contractid = S.contractref 
				 INNER JOIN cnt.ContractCoefficientItem AS CCI 
						 ON CCI.contractref = C.contractid 
						   AND CCI.CoefficientRef = -4 /*Insurance*/
		  WHERE  (S.Insurance > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET Insurance = 0
		WHERE StatusID IN (SELECT StatusID 
		                   FROM [CNT].[Status] S 
		                     INNER JOIN cnt.contract AS C 
		                        ON C.ContractID = S.ContractRef 
		                     INNER JOIN CNT.ContractCoefficientItem AS CCI 
		                        ON CCI.ContractRef = C.ContractID 
		                          AND CCI.CoefficientRef = -4
		                    WHERE  S.Insurance > 0 )


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem''

	END
')

END
----END Insurance

----GoodJob
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'GoodJob')
BEGIN

		 --DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
		 -- DECLARE @CodeOther int, @AdminID int
		  
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.GoodJob > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 


EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.GoodJob > 0)
	BEGIN
		 
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 +' + @ID + ', 
				 S.StatusID,
				 CCI.ContractCoefficientID,
				 null,
				 S.GoodJob
		  FROM   [CNT].[Status] S 
				 INNER JOIN cnt.contract AS C 
						 ON C.contractid = S.contractref 
				 INNER JOIN cnt.ContractCoefficientItem AS CCI 
						 ON CCI.contractref = C.contractid 
						   AND CCI.CoefficientRef = -1 /*GoodJob*/  
		  WHERE  (S.GoodJob > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET GoodJob = 0
		WHERE StatusID IN (SELECT StatusID 
		                   FROM [CNT].[Status] S 
		                     INNER JOIN cnt.contract AS C 
		                        ON C.ContractID = S.ContractRef 
		                     INNER JOIN CNT.ContractCoefficientItem AS CCI 
		                        ON CCI.ContractRef = C.ContractID 
		                          AND CCI.CoefficientRef = -1
		                    WHERE  S.GoodJob > 0 )


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem''

	END
')
END
----END GoodJob



--------------------------------------------------Step Two
-----------If still there is s.Tax > 0
-----------It means that coefficient is deleted from contract after save the status

----Tax
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'Tax')
BEGIN

		 --DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
   --       DECLARE @CodeOther int, @AdminID int
		  		
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.Tax > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 


EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.Tax > 0)
	BEGIN
		 
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 + ' + @ID + ', 
				 S.StatusID,
				 null,
				 -2, /*Taxt ID*/
				 S.Tax
		  
		  FROM   [CNT].[Status] S 
		  
		  WHERE  (S.Tax > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET Tax = 0
		WHERE StatusID IN (SELECT StatusID 
		                   FROM [CNT].[Status] S 
		                     INNER JOIN cnt.contract AS C 
		                        ON C.ContractID = S.ContractRef 
		                     INNER JOIN CNT.ContractCoefficientItem AS CCI 
		                        ON CCI.ContractRef = C.ContractID 
		                    WHERE  S.Tax > 0 )


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem''

	END
')
END
----END Tax

----VAT
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'VAT')
BEGIN

	 --DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
  --        DECLARE @CodeOther int, @AdminID int
		  		
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.VAT > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 


EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.VAT > 0)
	BEGIN
		 
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 + ' + @ID + ', 
				 S.StatusID,
				 null,
				 -5, /*VAT ID*/
				 S.VAT
		  
		  FROM   [CNT].[Status] S 
	
		  WHERE  (S.VAT > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET VAT = 0
		WHERE StatusID IN (SELECT StatusID 
		                   FROM [CNT].[Status] S 
		                     INNER JOIN cnt.contract AS C 
		                        ON C.ContractID = S.ContractRef 
		                     INNER JOIN CNT.ContractCoefficientItem AS CCI 
		                        ON CCI.ContractRef = C.ContractID 
		                    WHERE  S.VAT > 0 )


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1 
		WHERE  tablename = ''CNT.StatusCoefficientItem'' 

	END
')
END
----END VAT

----Insurance
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'Insurance')
BEGIN

	 --DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
  --        DECLARE @CodeOther int, @AdminID int
		  		
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.Insurance > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 


EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.Insurance > 0)
	BEGIN
		 
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 +' + @ID + ', 
				 S.StatusID,
				 null,
				 -4, /*SocialInsurance ID*/
				 S.Insurance
		  
		  FROM   [CNT].[Status] S 
			
		  WHERE  (S.Insurance > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET Insurance = 0
		WHERE StatusID IN (SELECT StatusID 
		                   FROM [CNT].[Status] S 
		                     INNER JOIN cnt.contract AS C 
		                        ON C.ContractID = S.ContractRef 
		                     INNER JOIN CNT.ContractCoefficientItem AS CCI 
		                        ON CCI.ContractRef = C.ContractID 
		                    WHERE  S.Insurance > 0 )


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem'' 

	END
')
END
----END Insurance

----GoodJob
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'GoodJob')
BEGIN

	SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.GoodJob > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 


EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.GoodJob > 0)
	BEGIN
		
		  
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 +' + @ID + ', 
				 S.StatusID,
				 null,
				 -1, /*PerformanceBond ID*/
				 S.GoodJob
		  
		  FROM   [CNT].[Status] S
		  
		  WHERE  (S.GoodJob > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET GoodJob = 0
		WHERE GoodJob > 0 


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem'' 

	END
')
END
----END GoodJob

----IncCoef
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'IncCoef')
BEGIN

	SELECT TOP 1 @AdminID = UserID from fmk.[User] where UserName = 'Admin'
	SET @CodeOther = (SELECT ISNULL(MAX(Code), 6)+1 FROM CNT.Coefficient)


	--DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
 --         DECLARE @CodeOther int, @AdminID int
		  
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.IncCoef > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 

EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.IncCoef > 0)
	BEGIN
		
		-- create Coefficient

		IF NOT EXISTS(SELECT 1 FROM CNT.Coefficient WHERE CoefficientID = -1000)
			BEGIN
				
				INSERT INTO CNT.[Coefficient] (CoefficientID, Code, Title, Title_En, [Percent], [Type], Version, Creator, CreationDate, LastModifier, LastModificationDate)
				VALUES (-1000, ISNULL(' + @CodeOther + ', 7), N''<OtherIncrease>'', N''<OtherIncrease_2>'', 1, 1, 1, ISNULL(' + @AdminID + ', 1), GETDATE() , ISNULL(' + @AdminID + ', 1), GETDATE() )
			END

		-- Insert into

		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 + ' + @ID + ', 
				 S.StatusID,
				 null,
				 -1000, /*OtherIncrease Coefficient*/
				 S.IncCoef
		  FROM   [CNT].[Status] S
		  WHERE  (S.IncCoef > 0 )

		---------------Finalize
		UPDATE [CNT].[Status]
		SET IncCoef = 0
		WHERE IncCoef > 0 


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1
		WHERE  tablename = ''CNT.StatusCoefficientItem'' 

	END
')
END
----END IncCoef

----DecCoef
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('CNT.Status') and
				[name] = 'DecCoef')
BEGIN

	SELECT TOP 1 @AdminID = UserID from fmk.[User] where UserName = 'Admin'
	SET @CodeOther = (SELECT ISNULL(MAX(Code), 7)+1 FROM CNT.Coefficient)
	
	--DECLARE @RecordCount int, @Step int,@ID int, @ItemId int
 --         DECLARE @CodeOther int, @AdminID int
		  
		  SET @RecordCount = 1 
		  SET @Step = 0 
		  SET @ID = 0 

		  --SELECT @RecordCount = Count(1) 
		  --FROM   [CNT].[Status] S
		  --WHERE S.DecCoef > 0

		  EXEC [FMK].[Spgetnextid] 
			@tablename = 'CNT.StatusCoefficientItem', 
			@id = @ItemId output, 
			@incvalue = @RecordCount 

		  SET @Step = @ItemId - @RecordCount 

		  SELECT @ID = @Step 

	
EXECUTE
('
	IF Exists (select 1 from CNT.Status S WHERE S.DecCoef > 0)
	BEGIN
		-- create Coefficient

		IF NOT EXISTS(SELECT 1 FROM CNT.Coefficient WHERE CoefficientID = -1001)
			BEGIN
				
				INSERT INTO CNT.[Coefficient] (CoefficientID, Code, Title, Title_En, [Percent], [Type], Version, Creator, CreationDate, LastModifier, LastModificationDate)
				VALUES (-1001, ISNULL(' + @CodeOther + ', 8), N''<OtherDecrease>'', N''<OtherDecrease_2>'', 1, 2, 1, ISNULL(' + @AdminID + ', 1), GETDATE() , ISNULL(' + @AdminID + ', 1), GETDATE() )
			END

		-- Insert into
		  
		  INSERT INTO CNT.StatusCoefficientItem 
					(StatusCoefficientItemID, 
					 StatusRef, 
					 ContractCoefficientItemRef, 
					 CoefficientRef, 
					 Price)
		  SELECT Row_number() OVER (ORDER BY StatusId) 
				 + ' + @ID + ', 
				 S.StatusID,
				 null,
				 -1001, /*OtherDecrease Coefficient*/
				 S.DecCoef
		  FROM   [CNT].[Status] S
		  WHERE  (S.DecCoef > 0 )
		      
		      
		---------------Finalize
		UPDATE [CNT].[Status]
		SET DecCoef = 0
		WHERE DecCoef > 0 


		UPDATE FMK.idgeneration 
		SET    lastid = (SELECT ISNULL(Max(StatusCoefficientItemID), 0)
		                 FROM   [CNT].[StatusCoefficientItem]) + 1 
		WHERE  tablename = ''CNT.StatusCoefficientItem'' 

	END
')
END
----END DecCoef


--------------------------------------------------Step Three

--------DROP COLUMNS

-----Tax
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'Tax')
BEGIN
EXECUTE
('
	IF NOT Exists (SELECT 1 FROM CNT.Status S WHERE S.Tax > 0)
	BEGIN
		ALTER TABLE [CNT].[Status] DROP COLUMN Tax
	END
')
END

-----VAT
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'VAT')
BEGIN
EXECUTE
('
	IF NOT Exists (SELECT 1 FROM CNT.Status S WHERE S.VAT > 0)
	BEGIN
		ALTER TABLE [CNT].[Status] DROP COLUMN VAT
	END
')
END

------Insurance
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'Insurance')
BEGIN
EXECUTE
('
	IF NOT Exists (SELECT 1 FROM CNT.Status S WHERE S.Insurance > 0)
	BEGIN
		ALTER TABLE [CNT].[Status] DROP COLUMN Insurance
	END
')
END

------GoodJob
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'GoodJob')
BEGIN
EXECUTE
('
	IF NOT Exists (SELECT 1 FROM CNT.Status S WHERE S.GoodJob > 0)
	BEGIN
		ALTER TABLE [CNT].[Status] DROP COLUMN GoodJob
	END
')
END

------IncCoef
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'IncCoef')
BEGIN
EXECUTE
('
	IF NOT Exists (SELECT 1 FROM CNT.Status S WHERE S.IncCoef > 0)
	BEGIN
		ALTER TABLE [CNT].[Status] DROP COLUMN IncCoef
	END
')
END

-----DecCoef
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('CNT.Status') and
				[name] = 'DecCoef')
BEGIN
EXECUTE
('
	IF NOT Exists (SELECT 1 FROM CNT.Status S WHERE S.DecCoef > 0)
	BEGIN
		ALTER TABLE [CNT].[Status] DROP COLUMN DecCoef
	END
')
END



