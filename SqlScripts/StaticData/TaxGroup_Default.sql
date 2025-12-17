/* SD.DefineDefaultUser */ /* this line is for dependancey order of scripts*/
declare @Creator int, @modifyDate smalldatetime
SET @modifyDate = getdate()
SET @Creator = (SELECT UserID FROM Fmk.[user] WHERE UserName ='Admin')
IF (@Creator is null)
BEGIN
	RAISERROR('There is no Admin User in Database',16, 1 )
END

declare @TaxGroupId int
if not exists (Select 1 from Pay.TaxGroup Where Title = 'گروه هاي مالياتي عادي (100%)')
begin
	Exec FMK.spGetNextId 'Pay.TaxGroup', @TaxGroupId out, 1

	Insert into Pay.TaxGroup(TaxGroupId, Title, Title_En,  Type, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	values( @TaxGroupId, 'گروه هاي مالياتي عادي (100%)', 'Normal Taxable (100%)', 0, 1, @Creator, @modifyDate, @Creator, @modifyDate)

end


if not exists (Select 1 from Pay.TaxGroup Where Title = 'مناطق محروم (50%)')
begin
	
	Exec FMK.spGetNextId 'Pay.TaxGroup', @TaxGroupId out, 1

	Insert into Pay.TaxGroup(TaxGroupId, Title, Title_En,  Type, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	values( @TaxGroupId, 'مناطق محروم (50%)', 'Leakage Area (50%)', 1, 1, @Creator, @modifyDate, @Creator, @modifyDate)

end
if not exists (Select 1 from Pay.TaxGroup Where Title = 'معاف (0%)')
begin	
	Exec FMK.spGetNextId 'Pay.TaxGroup', @TaxGroupId out, 1

	Insert into Pay.TaxGroup(TaxGroupId, Title, Title_En,  Type, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	values( @TaxGroupId, 'معاف (0%)', 'NonTaxable (0%)', 6, 1, @Creator, @modifyDate, @Creator, @modifyDate)

end
