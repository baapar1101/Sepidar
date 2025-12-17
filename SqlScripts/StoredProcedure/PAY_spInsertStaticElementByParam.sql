IF OBJECT_ID('PAY.spInsertStaticElementByParam') IS NOT NULL
	DROP PROCEDURE PAY.spInsertStaticElementByParam
GO
CREATE PROCEDURE PAY.spInsertStaticElementByParam @elementId int, @titlePersian nvarchar(250), @titleEnglish nvarchar(250), @Class int, @Taxable bit
AS
BEGIN

declare @Creator int
Set @Creator = (Select UserID from Fmk.[user] where UserName = 'Admin')
if (@Creator is null)
begin
	RaisError('There is no Admin User in Database',16, 1 )
end

IF NOT EXISTS (SELECT 1	FROM Pay.Element WHERE ElementId = @elementId)
	INSERT INTO Pay.Element (ElementId, Title, Title_En, Class, Type, NormalType, AccountRef, DlType, InsuranceCoverage, Taxable, UnrelatedToWorkingTime, CalculateForMinWorkingTime, CalculateForMinBase, Coefficient, FixPoint, DenominatorsType, Denominators, SavingRemainder, IsActive, DisplayOrder, Version, Creator, CreationDate, LastModifier, LastModificationDate, ElementTaxType)
	VALUES (@elementId, @titlePersian, @titleEnglish, @Class, 6, 1, NULL, 0, NULL, @Taxable, NULL, NULL, NULL, 1.0000,	0.0000,	NULL, NULL, NULL, 1, @elementId * (-1),	1, @Creator, getdate(), @Creator, getdate(), 0)
ELSE
	UPDATE Pay.Element SET Title = @titlePersian, Title_En = @titleEnglish WHERE ElementId = @elementId
END

