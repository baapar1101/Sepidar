DECLARE @id INT, @adminID INT

IF NOT EXISTS (SELECT 1 FROM GNR.DeliveryLocation
 --WHERE Title=N'آدرس مشتري' AND Title_En='Customer Address'
)
BEGIN
	exec FMK.spGetNextId 'GNR.DeliveryLocation', @id
	SELECT @adminID=[UserID] FROM [FMK].[User] WHERE [UserName]='Admin'
	INSERT INTO GNR.DeliveryLocation
		(DeliveryLocationID,[Title],Title_En,[Version],[Creator], CreationDate, LastModifier, LastModificationDate)
		VALUES (1, N'آدرس مشتري', 'Customer Address', 1, @adminID, GETDATE(), @adminID, GETDATE())
END