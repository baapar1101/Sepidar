Insert into Rpa.AccountType(AccountTypeId, Title, Title_En, [Type],[HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'جاري', 'جاري' , 2 , 1 ,  1 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'جاري')


Insert into Rpa.AccountType(AccountTypeId, Title, Title_En, [Type],[HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'سيبا', 'سيبا' , 3 , 1 ,  1 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'سيبا')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En,[Type], [HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'مهر', 'مهر' , 4 , 1 ,  1 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'مهر')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En,[Type], [HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'سپهر', 'سپهر' , 5 , 1 ,  1 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'سپهر')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En,[Type], [HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'جاري طلايي', 'جاري طلايي' , 6 , 1 ,  1 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'جاري طلايي')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En, [Type],[HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'جام', 'جام' ,7,1,  1 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'جام')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En,[Type], [HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'قرض الحسنه', 'قرض الحسنه' , 8 , 0 ,  1 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'قرض الحسنه')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En, [Type],[HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'سپرده سرمايه گذاري كوتاه مدت', 'سپرده سرمايه گذاري كوتاه مدت' , 9 , 0 ,  0 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'سپرده سرمايه گذاري كوتاه مدت')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En, [Type],[HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'سپرده سرمايه گذاري بلند مدت', 'سپرده سرمايه گذاري بلند مدت' , 10 , 0 ,  0 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'سپرده سرمايه گذاري بلند مدت')

Insert into Rpa.AccountType(AccountTypeId, Title, Title_En, [Type],[HasChequeBook], Version)
Select (Select IsNull(Max(AccountTypeId), 0) + 1 from Rpa.AccountType), 'عابر بانك', 'عابر بانك' ,11 , 0 ,  0 
Where not exists (Select 1 from Rpa.AccountType Where Title = 'عابر بانك')


declare @Creator int, @modifyDate smalldatetime
SET @modifyDate = getdate()
SET @Creator = (SELECT UserID FROM Fmk.[user] WHERE UserName ='Admin')
IF (@Creator is null)
BEGIN
	RAISERROR('There is no Admin User in Database',16, 1 )
END


UPDATE Rpa.AccountType 
SET Creator = @Creator, 
	LastModifier = @Creator,
	CreationDate = GetDate(), 
	LastModificationDate = GetDate()

declare @dummyId int
Exec FMK.spGetNextId'Rpa.AccountType', @dummyId out, 40
Go

UPDATE Rpa.AccountType
SET [Type] = 2
WHERE Title = 'جاري' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 3
WHERE Title = 'سيبا' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 4
WHERE Title = 'مهر' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 5
Where Title = 'سپهر' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 6
Where Title = 'جاري طلايي' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 7
Where Title = 'جام' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 8
Where Title = 'قرض الحسنه' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 9
Where Title = 'سپرده سرمايه گذاري كوتاه مدت' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 10
Where Title = 'سپرده سرمايه گذاري بلند مدت' AND [Type] = 0

UPDATE Rpa.AccountType
SET [Type] = 11
Where Title = 'عابر بانك' AND [Type] = 0