IF EXISTS (SELECT 1 FROM FMK.Configuration WHERE [KEY] = 'TaxCoefficientSL' AND Value IS NOT NULL AND LTrim(RTrim(Value)) <> '' )
BEGIN
	Update CNT.Coefficient
	Set SLRef = (SELECT TOP 1 Value FROM FMK.Configuration WHERE [KEY] = 'TaxCoefficientSL')
	WHERE CoefficientID = -2
	
	DELETE FMK.Configuration WHERE [KEY] = 'TaxCoefficientSL'
END

IF EXISTS (SELECT 1 FROM FMK.Configuration WHERE [KEY] = 'VATCoefficientSL' AND Value IS NOT NULL AND LTrim(RTrim(Value)) <> '' )
BEGIN
	Update CNT.Coefficient
	Set SLRef = (SELECT TOP 1 Value FROM FMK.Configuration WHERE [KEY] = 'VATCoefficientSL')
	WHERE CoefficientID = -5
	
	DELETE FMK.Configuration WHERE [KEY] = 'VATCoefficientSL'
END

IF EXISTS (SELECT 1 FROM FMK.Configuration WHERE [KEY] = 'InsuranceCoefficientSL' AND Value IS NOT NULL AND LTrim(RTrim(Value)) <> '' )
BEGIN
	Update CNT.Coefficient
	Set SLRef = (SELECT TOP 1 Value FROM FMK.Configuration WHERE [KEY] = 'InsuranceCoefficientSL')
	WHERE CoefficientID = -4
	
	DELETE FMK.Configuration WHERE [KEY] = 'InsuranceCoefficientSL'
END

IF EXISTS (SELECT 1 FROM FMK.Configuration WHERE [KEY] = 'GoodJobCoefficientSL' AND Value IS NOT NULL AND LTrim(RTrim(Value)) <> '' )
BEGIN
	Update CNT.Coefficient
	Set SLRef = (SELECT TOP 1 Value FROM FMK.Configuration WHERE [KEY] = 'GoodJobCoefficientSL')
	WHERE CoefficientID = -1
	
	DELETE FMK.Configuration WHERE [KEY] = 'GoodJobCoefficientSL'
END

IF EXISTS (SELECT 1 FROM FMK.Configuration WHERE [KEY] = 'AdditiveCoefficientSL' AND Value IS NOT NULL AND LTrim(RTrim(Value)) <> '' )
BEGIN
	Update CNT.Coefficient
	Set SLRef = (SELECT TOP 1 Value FROM FMK.Configuration WHERE [KEY] = 'AdditiveCoefficientSL')
	WHERE CoefficientID > 0 AND [Type] = 1
	
	DELETE FMK.Configuration WHERE [KEY] = 'AdditiveCoefficientSL'
END

IF EXISTS (SELECT 1 FROM FMK.Configuration WHERE [KEY] = 'ReductiveCoefficientSL' AND Value IS NOT NULL AND LTrim(RTrim(Value)) <> '' )
BEGIN
	Update CNT.Coefficient
	Set SLRef = (SELECT TOP 1 Value FROM FMK.Configuration WHERE [KEY] = 'ReductiveCoefficientSL')
	WHERE CoefficientID > 0 AND [Type] = 2
	
	DELETE FMK.Configuration WHERE [KEY] = 'ReductiveCoefficientSL'
END

