
declare @Creator int, @modifyDate smalldatetime
SET @modifyDate = getdate()
SET @Creator = (SELECT UserID FROM Fmk.[user] WHERE UserName ='Admin')
IF (@Creator is null)
BEGIN
	RAISERROR('There is no Admin User in Database',16, 1 )
END

Declare @taxGroupID int
declare @TaxTableId int
declare @TaxTableItemId int

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1391
		-- اين قسمت فقط براي جداول مالياتي سال 1391 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1391 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		DECLARE @Year SMALLINT,@Month SMALLINT,@Day SMALLINT , @result BIT 
		DECLARE @StartDate DateTime
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1391
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2012-03-20 00:00:00.000') AS DateTime)
		
	--/////////////////////////////////////////////////////////////////	

	IF NOT EXISTS(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2009-03-21' and Date < '2010-03-21') OR (Title = 'جدول ماليات سال 88'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 88', 'Taxable (100%) Year 88', @TaxGroupId, '2009-03-21 05:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId , 1.0000, 4166667.0000,	0.00,	@TaxTableId,	0.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId , 4166668.0000, 7666667.0000, 10.00, @TaxTableId, 350000.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  7666668.0000, 12500000.0000,	20.00, @TaxTableId, 1316666.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  12500001.0000, 25000000.0000, 25.00, @TaxTableId	,4441666.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  25000001, 87500000, 30.00, 	@TaxTableId, 23191666.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId , 	87500001.0000,	99999999999.0000,	35.00,	@TaxTableId, 34992566665.0000)
	end

	if Not Exists(Select 1 from Pay.TaxTable where 
			(TaxGroupRef = @taxGroupId and Date >= '2010-03-21' and Date < '2011-03-21') OR (Title = 'جدول ماليات سال 89'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 89', 'Taxable (100%) Year 89', @TaxGroupId, '2010-03-21 00:00:00.000', 3, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 4375000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 4375001.0000 ,  7875000.0000  ,10.00 , @TaxTableId, 350000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 7875001.0000 ,  12708333.0000 ,20.00 , @TaxTableId, 1316666.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 12708334.0000,  25208333.0000 ,25.00 , @TaxTableId, 4441666.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 25208334.0000,  87708333.0000 ,30.00 , @TaxTableId, 23191666.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 87708334.0000,  999999999.0000,35.00 , @TaxTableId, 342493748.0)

	end
	----------------گروه هاي مالياتي عادي سال 90
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2011-03-21' and Date < '2012-03-20') OR (Title = 'جدول ماليات سال 90'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 90', 'Taxable (100%) Year 90', @TaxGroupId, '2011-03-21 00:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 4850000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 4850001.0000 ,  8350000.0000  ,10.00 , @TaxTableId, 350000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 8350001.0000 ,  13183333.0000 ,20.00 , @TaxTableId, 1316666.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 13183334.0000,  25683333.0000 ,25.00 , @TaxTableId, 4441666.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 25683334.0000,  88183333.0000 ,30.00 , @TaxTableId, 23191666.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 88183334.0000,  999999999.0000,35.00 , @TaxTableId, 342327499.0)

	end
	----------------گروه هاي مالياتي عادي سال 1391
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2012-03-20' and Date < '2013-03-20') OR (Title = 'جدول ماليات سال 91'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 91', 'Taxable (100%) Year 91', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 5500000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 5500001.0000 ,  9000000.0000  ,10.00 , @TaxTableId, 350000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 9000001.0000 ,  13833333.0000 ,20.00 , @TaxTableId, 1316666.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 13833334.0000,  26333333.0000 ,25.00 , @TaxTableId, 4441666.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 26333334.0000,  88833333.0000 ,30.00 , @TaxTableId, 23191666.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 88833334.0000,  999999999.0000,35.00 , @TaxTableId, 318908333.0)

	end
	----------------
end


Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'
	
if (@taxGroupId is not null)
begin
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2009-03-21' and Date < '2010-03-21') OR (Title = 'جدول ماليات سال 88 مناطق محروم'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 88 مناطق محروم', 'Leakage Area (50%) Year 88', @TaxGroupId, '2009-03-21 05:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  1.0000,	4166667.0000,	0.00,	@TaxTableId	,0.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  4166668.0000,	7666667.0000,	5.00,	@TaxTableId,	175000.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  7666668.0000,	12500000.0000,	10.00,	@TaxTableId,	658333.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  12500001.0000,	25000000.0000,	12.50,	@TaxTableId,	2220833.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  25000001.0000,	87500000.0000,	15.00,	@TaxTableId	,11595833.0000)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId ,  87500001.0000,	99999999999.0000,	17.50,	@TaxTableId,	17496283333.0000)
	end
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2010-03-21' and Date < '2011-03-21') OR (Title = 'جدول ماليات 50 درصدي سال 1389'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1389', 'Leakage Area (50%) Year 89', @TaxGroupId, '2010-03-21 00:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000       ,  4375000.0000  ,0.00  , @TaxTableId, 0.0000     )

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 4375001.0000 ,  7875000.0000  ,5.00  , @TaxTableId, 175000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 7875001.0000 ,  12708333.0000 ,10.00 , @TaxTableId, 658333.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 12708334.0000,  25208333.0000 ,12.50 , @TaxTableId, 2220833.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 25208334.0000,  87708333.0000 ,15.00 , @TaxTableId, 11595833.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 87708334.0000,  999999999.0000,17.50 , @TaxTableId, 171246874.0)

    end
    -------------------مناطق محروم سال 90
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2011-03-21' and Date < '2012-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1390'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1390', 'Leakage Area (50%) Year 90', @TaxGroupId, '2011-03-21 00:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000,  4850000.0000  ,0.00  , @TaxTableId, 0.0000     )

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 4850001.0000 ,  8350000.0000  ,5.00  , @TaxTableId, 175000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 8350001.0000 ,  13183333.0000 ,10.00 , @TaxTableId, 658333.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 13183334.0000,  25683333.0000 ,12.50 , @TaxTableId, 2220833.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 25683334.0000,  88183333.0000 ,15.00 , @TaxTableId, 11595833.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 88183334.0000,  999999999.0000,17.50 , @TaxTableId, 171163749.0)

    end
    -------------------مناطق محروم سال 91
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2012-03-20' and Date < '2013-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1391'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1391', 'Leakage Area (50%) Year 91', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000,  5500000.0000  ,0.00  , @TaxTableId, 0.0000     )

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 5500001.0000 ,  9000000.0000  ,5.00  , @TaxTableId, 175000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 9000001.0000 ,  13833333.0000 ,10.00 , @TaxTableId, 658333.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 13833334.0000,  26333333.0000 ,12.50 , @TaxTableId, 2220833.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 26333334.0000,  88833333.0000 ,15.00 , @TaxTableId, 11595833.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 88833334.0000,  999999999.0000,17.50 , @TaxTableId, 171049999.0)

    end
    ------------------
end


Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2009-03-21' and Date < '2010-03-21') OR (Title = 'جدول ماليات سال 88 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 88 معاف', 'NonTaxable (0%) Year 88', @TaxGroupId, '2009-03-21 05:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end

    if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2010-03-21' and Date < '2011-03-21') OR (Title = 'جدول ماليات سال 89 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 89 معاف', 'NonTaxable (0%) Year 89', @TaxGroupId, '2010-03-21 05:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	-----------------معاف سال 90
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2011-03-21' and Date < '2012-03-20') OR (Title = 'جدول ماليات سال 90 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 90 معاف', 'NonTaxable (0%) Year 90', @TaxGroupId, '2011-03-21 05:00:00.000', 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	-----------------معاف سال 91
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2012-03-20' and Date < '2013-03-20') OR (Title = 'جدول ماليات سال 91 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 91 معاف', 'NonTaxable (0%) Year 91', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end

----------------------------جدول مالياتي  سال 92---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1392
		-- اين قسمت فقط براي جداول مالياتي سال 1392 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1392 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1392
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2013-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1392
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2013-03-21' and Date < '2014-03-20') OR (Title = 'جدول ماليات سال 92'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 92', 'Taxable (100%) Year 92', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 8333333.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 8333334.0000 ,  11833333.0000  ,10.00 , @TaxTableId, 350000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 11833334.0000 ,  16666666.0000 ,20.00 , @TaxTableId, 1316667.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 16666667.0000,  29166667.0000 ,25.00 , @TaxTableId, 4441667.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 29166668.0000,  91666667.0000 ,30.00 , @TaxTableId, 23191667.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 91666668.0000,  999999999.0000,35.00 , @TaxTableId, 341108333.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 92
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2013-03-21' and Date < '2014-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1392'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1392', 'Leakage Area (50%) Year 92', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 8333333.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 8333334.0000 ,  11833333.0000  ,5.00 , @TaxTableId, 175000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 11833334.0000 ,  16666666.0000 ,10.00 , @TaxTableId, 658333.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 16666667.0000,  29166667.0000 ,12.50 , @TaxTableId, 2220833.000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 29166668.0000,  91666667.0000 ,15.00 , @TaxTableId, 11595833.00)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 91666668.0000,  999999999.0000,17.50 , @TaxTableId, 170554166.0)
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 92
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2013-03-21' and Date < '2014-03-20') OR (Title = 'جدول ماليات سال 92 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 92 معاف', 'NonTaxable (0%) Year 92', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end

---------------------------- جدول مالياتي  سال 93---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1393
		-- اين قسمت فقط براي جداول مالياتي سال 1393 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1393 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1393
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2014-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1393
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2014-03-21' and Date < '2015-03-20') OR (Title = 'جدول ماليات سال 93'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 93', 'Taxable (100%) Year 93', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 10000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 10000001.0000 ,  70000000.0000  ,10.00 , @TaxTableId, 6000000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 70000001.0000,  999999999.0000, 20.00 , @TaxTableId, 192000000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 93
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2014-03-21' and Date < '2015-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1393'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1393', 'Leakage Area (50%) Year 93', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 10000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 10000001.0000 ,  70000000.0000  ,5.00 , @TaxTableId, 3000000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 70000001.0000 ,  999999999.0000 ,10.00 , @TaxTableId, 96000000.000)
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 93
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2014-03-21' and Date < '2015-03-20') OR (Title = 'جدول ماليات سال 93 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 93 معاف', 'NonTaxable (0%) Year 93', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end


---------------------------- جدول مالياتي  سال 94---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1394
		-- اين قسمت فقط براي جداول مالياتي سال 1394 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1394 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1394
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2015-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1394
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2015-03-21' and Date < '2016-03-20') OR (Title = 'جدول ماليات سال 94'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 94', 'Taxable (100%) Year 94', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 11500000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 11500001.0000 ,  92000000.0000  ,10.00 , @TaxTableId, 8050000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 92000001.0000,  9999999999.0000, 20.00 , @TaxTableId, 1989650000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 94
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2015-03-21' and Date < '2016-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1394'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1394', 'Leakage Area (50%) Year 94', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 11500000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 11500001.0000 ,  92000000.0000  ,5.00 , @TaxTableId, 4025000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 92000001.0000 ,  9999999999.0000 ,10.00 , @TaxTableId, 994825000.000)
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 94
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2015-03-21' and Date < '2016-03-20') OR (Title = 'جدول ماليات سال 94 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 94 معاف', 'NonTaxable (0%) Year 94', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end

---------------------------- جدول مالياتي  سال 95---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1395
		-- اين قسمت فقط براي جداول مالياتي سال 1395 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1395 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1395
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2016-03-20 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1395
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2016-03-20' and Date < '2017-03-21') OR (Title = 'جدول ماليات سال 1395'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1395', 'Taxable (100%) Year 95', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 13000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 13000001.0000 ,  91000000.0000  ,10.00 , @TaxTableId, 7800000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 91000001.0000,  9999999999.0000, 20.00 , @TaxTableId, 1989600000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 95
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2016-03-20' and Date < '2017-03-21') OR (Title = 'جدول ماليات 50 درصدي سال 1395'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1395', 'Leakage Area (50%) Year 95', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 13000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 13000001.0000 ,  91000000.0000  ,5.00 , @TaxTableId, 3900000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 91000001.0000 ,  9999999999.0000 ,10.00 , @TaxTableId, 994800000.000)
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 95
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2016-03-20' and Date < '2017-03-21') OR (Title = 'جدول ماليات سال 95 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1395 معاف', 'NonTaxable (0%) Year 95', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end



---------------------------- جدول مالياتي  سال 96---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1396
		-- اين قسمت فقط براي جداول مالياتي سال 1396 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1396 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1396
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2017-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1396
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2017-03-21' and Date < '2018-03-21') OR (Title = 'جدول ماليات سال 1396'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1396', 'Taxable (100%) Year 96', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 20000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 20000001.0000 ,  100000000.0000  ,10.00 , @TaxTableId, 8000000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 100000001.0000,  9999999999.0000, 20.00 , @TaxTableId, 1988000000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 96
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2017-03-21' and Date < '2018-03-21') OR (Title = 'جدول ماليات 50 درصدي سال 1396'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1396', 'Leakage Area (50%) Year 96', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 20000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 20000001.0000 ,  100000000.0000  ,5.00 , @TaxTableId, 4000000.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 100000001.0000 ,  9999999999.0000 ,10.00 , @TaxTableId, 994000000.000)
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 96
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2017-03-21' and Date < '2018-03-21') OR (Title = 'جدول ماليات سال 96 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1396 معاف', 'NonTaxable (0%) Year 96', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end






---------------------------- جدول مالياتي  سال 97---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1397
		-- اين قسمت فقط براي جداول مالياتي سال 1397 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1397 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1397
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2018-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1397
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2018-03-21' and Date < '2019-03-21') OR (Title = 'جدول ماليات سال 1397'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1397', 'Taxable (100%) Year 97', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 23000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 23000001.0000 ,  92000000.0000  ,10.00 , @TaxTableId, 6900000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 92000001.0000,  115000000.0000, 15.00 , @TaxTableId, 10350000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 115000001.0000,  161000000.0000, 25.00 , @TaxTableId, 21850000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 161000001.0000,  9999999999.0000, 35.00 , @TaxTableId, 3465500000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 97
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2018-03-21' and Date < '2019-03-21') OR (Title = 'جدول ماليات 50 درصدي سال 1397'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1397', 'Leakage Area (50%) Year 97', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 23000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 23000001.0000 ,  92000000.0000  ,5.00 , @TaxTableId, 3450000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 92000001.0000,  115000000.0000, 7.50 , @TaxTableId, 5175000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 115000001.0000,  161000000.0000, 12.50 , @TaxTableId, 10925000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 161000001.0000,  9999999999.0000, 17.50 , @TaxTableId, 1732750000.0)
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 97
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2018-03-21' and Date < '2019-03-21') OR (Title = 'جدول ماليات سال 97 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1397 معاف', 'NonTaxable (0%) Year 97', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end

---------------------------- جدول مالياتي  سال 98---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1398
		-- اين قسمت فقط براي جداول مالياتي سال 1398 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1398 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1398
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2019-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1398
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2019-03-21' and Date < '2020-03-20') OR (Title = 'جدول ماليات سال 1398'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1398', 'Taxable (100%) Year 98', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 27500000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 27500001.0000 ,  68750000.0000  ,10.00 , @TaxTableId, 4125000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 68750001.0000,  96250000.0000, 15.00 , @TaxTableId, 8250000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 96250001.0000,  137500000.0000, 20.00 , @TaxTableId, 16500000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 137500001.0000,  192500000.0000, 25.00 , @TaxTableId, 30249999.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 192500001.0000,  99999999999.0000, 35.00 , @TaxTableId, 34962874999.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 98
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2019-03-21' and Date < '2020-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1398'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1398', 'Leakage Area (50%) Year 98', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 27500000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 27500001.0000 ,  68750000.0000  ,5.00 , @TaxTableId, 2062500.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 68750001.0000,  96250000.0000, 7.50 , @TaxTableId, 4125000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 96250001.0000,  137500000.0000, 10.00 , @TaxTableId, 8250000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 137500001.0000,  192500000.0000, 12.50 , @TaxTableId, 15125000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 192500001.0000,  99999999999.0000, 17.50 , @TaxTableId, 17481437500.0)
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 98
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2019-03-21' and Date < '2020-03-20') OR (Title = 'جدول ماليات سال 1398 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1398 معاف', 'NonTaxable (0%) Year 98', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
END
---------------------------- جدول مالياتي  سال 99---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1399
		-- اين قسمت فقط براي جداول مالياتي سال 1399 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1399 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1399
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2020-03-20 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1399
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2020-03-20' and Date < '2021-03-21') OR (Title = 'جدول ماليات سال 1399'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1399', 'Taxable (100%) Year 99', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 30000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 30000001.0000 ,  75000000.0000  ,10.00 , @TaxTableId, 4500000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 75000001.0000,  105000000.0000, 15.00 , @TaxTableId, 9000000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 105000001.0000,  150000000.0000, 20.00 , @TaxTableId, 18000000.0)
			
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 150000001.0000,  99999999999.0000, 25.00 , @TaxTableId, 24980500000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 99
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2020-03-20' and Date < '2021-03-21') OR (Title = 'جدول ماليات 50 درصدي سال 1399'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1399', 'Leakage Area (50%) Year 99', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 30000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 30000001.0000 ,  75000000.0000  ,5.00 , @TaxTableId, 2250000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 75000001.0000,  105000000.0000, 7.50 , @TaxTableId, 4500000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 105000001.0000,  150000000.0000, 10.00 , @TaxTableId, 9000000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 150000001.0000,  99999999999.0000, 12.50 , @TaxTableId, 12490250000.0)
		
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 99
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2020-03-20' and Date < '2021-03-21') OR (Title = 'جدول ماليات سال 99 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1399 معاف', 'NonTaxable (0%) Year 99', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end
---------------------------- جدول مالياتي  سال 1400---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1400
		-- اين قسمت فقط براي جداول مالياتي سال 1400 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1400 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1400
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2021-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1400
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2021-03-21' and Date < '2022-03-20') OR (Title = 'جدول ماليات سال 1400'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1400', 'Taxable (100%) Year 1400', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 40000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 40000001.0000 ,  80000000.0000  ,10.00 , @TaxTableId, 4000000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 80000001.0000,  120000000.0000, 15.00 , @TaxTableId, 10000000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 120000001.0000,  180000000.0000, 20.00 , @TaxTableId, 22000000.0)
			
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 180000001.0000,  240000000.0000, 25.00 , @TaxTableId, 37000000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 240000001.0000,  320000000.0000, 30.00 , @TaxTableId, 61000000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 320000001.0000,  99999999999.0000, 35.00 , @TaxTableId, 34949000000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 1400
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2021-03-21' and Date < '2022-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1400'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1400', 'Leakage Area (50%) Year 1400', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 40000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 40000001.0000 ,  80000000.0000  ,5.00 , @TaxTableId, 2000000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 80000001.0000,  120000000.0000, 7.50 , @TaxTableId, 5000000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 120000001.0000,  180000000.0000, 10.00 , @TaxTableId, 11000000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 180000001.0000,  240000000.0000, 12.50 , @TaxTableId, 18500000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 240000001.0000,  320000000.0000, 15.00 , @TaxTableId, 30500000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 320000001.0000,  99999999999.0000, 17.50 , @TaxTableId, 17474500000.0)
		
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 1400
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2021-03-21' and Date < '2022-03-20') OR (Title = 'جدول ماليات سال 1400 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1400 معاف', 'NonTaxable (0%) Year 1400', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end

---------------------------- جدول مالياتي  سال1401---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1401
		-- اين قسمت فقط براي جداول مالياتي سال 1401 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1401 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1401
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2022-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1401
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2022-03-21' and Date < '2023-03-20') OR (Title = 'جدول ماليات سال 1401'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1401', 'Taxable (100%) Year 1401', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 56000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 56000001.0000 ,  150000000.0000  ,10.00 , @TaxTableId, 9400000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 150000001.0000,  250000000.0000, 15.00 , @TaxTableId, 24400000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 250000001.0000,  350000000.0000, 20.00 , @TaxTableId, 44400000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 350000001.0000,  99999999999.0000, 30.00 , @TaxTableId, 29939400000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم سال 1401
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2022-03-21' and Date < '2023-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1401'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1401', 'Leakage Area (50%) Year 1401', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate


        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 56000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 56000001.0000 ,  150000000.0000  ,5.00 , @TaxTableId, 4700000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 150000001.0000,  250000000.0000, 7.50 , @TaxTableId, 12200000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 250000001.0000,  350000000.0000, 10.00 , @TaxTableId, 22200000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 350000001.0000,  99999999999.0000, 15.00 , @TaxTableId, 14969700000.0)
		
    end
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 1401
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2022-03-21' and Date < '2023-03-20') OR (Title = 'جدول ماليات سال 1401 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1401 معاف', 'NonTaxable (0%) Year 1401', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end
---------------------------- جدول مالياتي عيدي سال1401---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي عيدي سال 1401
		-- اين قسمت فقط براي جداول مالياتي عيدي سال 1401 مي باشد		
		-- اگر محاسباتي در سيستم حقوق عيدي براي سال 1401 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1401 AND [Type]= 6
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2022-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin

	----------------گروه هاي مالياتي عادي عيدي سال 1401
  IF NOT EXISTS(SELECT 1 FROM PAY.Calculation c
WHERE c.Year = 1401 AND c.Month = 12 AND c.Type = 6) 
BEGIN
	if Not Exists(Select 1 from Pay.TaxTable where
			((TaxGroupRef = @taxGroupId and Date >= '2022-03-21' and Date < '2023-03-20') OR (Title = 'جدول ماليات عيدي سال 1401')) AND TaxType=2)
	begin		
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date  , TaxType , Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات عيدي سال 1401', 'New Year Taxable (100%) Year 1401', @TaxGroupId, @StartDate ,2, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 56000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 56000001.0000 ,  448000000.0000  ,10.00 , @TaxTableId, 39200000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 448000001.0000,  99999999999.0000, 20.00 , @TaxTableId, 199949600000.0)
  END
END
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم عيدي سال 1401
    IF NOT EXISTS(SELECT 1 FROM PAY.Calculation c
WHERE c.Year = 1401 AND c.Month = 12 AND c.Type = 6) 
BEGIN 
    if Not Exists(Select 1 from Pay.TaxTable where 
				((TaxGroupRef = @taxGroupId and Date >= '2022-03-21' and Date < '2023-03-20') OR (Title = 'جدول ماليات  عيدي 50 درصدي سال 1401')) AND TaxType=2)
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date,TaxType, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات  عيدي 50 درصدي سال 1401', 'Leakage Area New Year (50%) Year 1401', @TaxGroupId, @StartDate,2, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 56000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 56000001.0000 ,  448000000.0000  ,5.00 , @TaxTableId, 19600000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 448000001.0000,  99999999999.0000, 10.00 , @TaxTableId, 99974800000.0)
  END	
END
    ------------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف عيدي سال 1401
  IF NOT EXISTS(SELECT 1 FROM PAY.Calculation c
WHERE c.Year = 1401 AND c.Month = 12 AND c.Type = 6) 
BEGIN 
	if Not Exists(Select 1 from Pay.TaxTable where 
		((TaxGroupRef = @taxGroupId and Date >= '2022-03-21' and Date < '2023-03-20') OR (Title = 'جدول ماليات عيدي سال 1401 معاف')) AND TaxType=2)
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date,TaxType, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات عيدي سال 1401 معاف', 'NonTaxable New Year (0%) Year 1401', @TaxGroupId, @StartDate,2, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
    END
END
	------------------
end

---------------------------- جدول مالياتي  سال1402---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1402
		-- اين قسمت فقط براي جداول مالياتي سال 1402 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1402 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1402
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2023-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'

if (@taxGroupId is not null)
begin
	----------------گروه هاي مالياتي عادي سال 1402
	if Not Exists(Select 1 from Pay.TaxTable where
			(TaxGroupRef = @taxGroupId and Date >= '2023-03-21' and Date < '2024-03-20') OR (Title = 'جدول ماليات سال 1402'))
	begin						
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات سال 1402', 'Taxable (100%) Year 1402', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 100000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 100000001.0000 ,  140000000.0000  ,10.00 , @TaxTableId, 4000000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 140000001.0000,  230000000.0000, 15.00 , @TaxTableId, 17500000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 230000001.0000,  340000000.0000, 20.00 , @TaxTableId, 39500000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 340000001.0000,  99999999999.0000, 30.00 , @TaxTableId, 29937499999.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
-------------------مناطق محروم سال 1402
    if Not Exists(Select 1 from Pay.TaxTable where 
				(TaxGroupRef = @taxGroupId and Date >= '2023-03-21' and Date < '2024-03-20') OR (Title = 'جدول ماليات 50 درصدي سال 1402'))
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات 50 درصدي سال 1402', 'Leakage Area (50%) Year 1402', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 100000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 100000001.0000 ,  140000000.0000  ,5.00 , @TaxTableId, 2000000.0)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 140000001.0000,  230000000.0000, 7.50 , @TaxTableId, 8750000.0)
		
		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 230000001.0000,  340000000.0000, 10.00 , @TaxTableId, 19750000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 340000001.0000,  99999999999.0000, 15.00 , @TaxTableId, 14968749999.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف سال 1402
	if Not Exists(Select 1 from Pay.TaxTable where 
		(TaxGroupRef = @taxGroupId and Date >= '2023-03-21' and Date < '2024-03-20') OR (Title = 'جدول ماليات سال 1402 معاف'))
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات سال 1402 معاف', 'NonTaxable (0%) Year 1402', @TaxGroupId, @StartDate, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	99999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end

---------------------------- جدول مالياتي عيدي سال1402---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي عيدي سال 1402
		-- اين قسمت فقط براي جداول مالياتي عيدي سال 1402 مي باشد		
		-- اگر محاسباتي در سيستم حقوق عيدي براي سال 1402 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1402 AND [Type]= 6
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS Varchar) + '-' + CAST(@Month AS Varchar) + '-' + CAST(@Day AS Varchar) + ' 00:00:00.000') AS DateTime)
			END
		ELSE
			SET @StartDate = CAST(('2023-03-21 00:00:00.000') AS DateTime)

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'گروه هاي مالياتي عادي%'
	
if (@taxGroupId is not null)
begin

	----------------گروه هاي مالياتي عادي عيدي سال 1402
	if Not Exists(Select 1 from Pay.TaxTable where
			((TaxGroupRef = @taxGroupId and Date >= '2023-03-21' and Date < '2024-03-20') OR (Title = 'جدول ماليات عيدي سال 1402')) AND TaxType=2)
	begin		
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date  , TaxType , Version, Creator, CreationDate, LastModifier, LastModificationDate)
		Select @TaxTableId, 'جدول ماليات عيدي سال 1402', 'New Year Taxable (100%) Year 1402', @TaxGroupId, @StartDate ,2, 1, @Creator, @modifyDate, @Creator, @modifyDate

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 100000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 100000001.0000 ,  800000000.0000  ,10.00 , @TaxTableId, 70000000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 800000001.0000,  99999999999.0000, 20.00 , @TaxTableId, 19910000000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'مناطق محروم%'

if (@taxGroupId is not null)
begin
    -------------------مناطق محروم عيدي سال 1402
    if Not Exists(Select 1 from Pay.TaxTable where 
				((TaxGroupRef = @taxGroupId and Date >= '2023-03-21' and Date < '2024-03-20') OR (Title = 'جدول ماليات  عيدي 50 درصدي سال 1402')) AND TaxType=2)
	begin

		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1
		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date,TaxType, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات  عيدي 50 درصدي سال 1402', 'Leakage Area New Year (50%) Year 1402', @TaxGroupId, @StartDate,2, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 1.0000, 100000000.0000, 0.00 , @TaxTableId, 0.0000)

        Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 100000001.0000 ,  800000000.0000  ,5.00 , @TaxTableId, 35000000.0)

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values( @TaxTableItemId, 800000001.0000,  99999999999.0000, 10.00 , @TaxTableId, 9955000000.0)

	end
	----------------
end

Select top 1 @taxGroupId = TaxGroupID from Pay.TaxGroup
Where Title like 'معاف%'
	
if (@taxGroupId is not null)
begin
	-----------------معاف عيدي سال 1402
	if Not Exists(Select 1 from Pay.TaxTable where 
		((TaxGroupRef = @taxGroupId and Date >= '2023-03-21' and Date < '2024-03-20') OR (Title = 'جدول ماليات عيدي سال 1402 معاف')) AND TaxType=2)
	begin
		Exec FMK.spGetNextId 'Pay.TaxTable', @TaxTableId out, 1

		Insert into Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, Date,TaxType, Version, Creator, CreationDate, LastModifier, LastModificationDate)
	    Select @TaxTableId, 'جدول ماليات عيدي سال 1402 معاف', 'NonTaxable New Year (0%) Year 1402', @TaxGroupId, @StartDate,2, 1, @Creator, @modifyDate, @Creator, @modifyDate

		Exec FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId out, 1
		Insert Into Pay.TaxTableItem (TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		values(@TaxTableItemId, 1.0000,	99999999999.0000,	0.00, @TaxTableId, 0.0000)
	end
	------------------
end




---------------------------- جدول مالياتي  سال1403---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1403
		-- اين قسمت فقط براي جداول مالياتي سال 1403 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1403 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1403
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS VARCHAR) + '-' + CAST(@Month AS VARCHAR) + '-' + CAST(@Day AS VARCHAR) + ' 00:00:00.000') AS DATETIME)
			END
		ELSE
			SET @StartDate = CAST(('2024-03-20 00:00:00.000') AS DateTime)

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'گروه هاي مالياتي عادي%'
	
IF (@taxGroupId is not null)
BEGIN
	----------------گروه هاي مالياتي عادي سال 1403
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE
			(TaxGroupRef = @taxGroupId and [Date] >= '2024-03-20' and [Date] < '2025-03-21') OR (Title = 'جدول ماليات سال 1403'))
	BEGIN						
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date], [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
		SELECT @TaxTableId, 'جدول ماليات سال 1403', 'Taxable (100%) Year 1403', @TaxGroupId, @StartDate, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 120000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 120000001.0000 ,  165000000.0000  ,10.00 , @TaxTableId, 4500000.0)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 165000001.0000,  270000000.0000, 15.00 , @TaxTableId, 20250000.0)
		
		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 270000001.0000,  400000000.0000, 20.00 , @TaxTableId, 46250000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 400000001.0000,  99999999999.0000, 30.00 , @TaxTableId, 29926250000.0)

	END
	----------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'مناطق محروم%'

IF (@taxGroupId is not null)
BEGIN
    -------------------مناطق محروم سال 1403
    IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
				(TaxGroupRef = @taxGroupId and [Date] >= '2024-03-20' and [Date] < '2025-03-21') OR (Title = 'جدول ماليات 50 درصدي سال 1403'))
	BEGIN
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date], [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات 50 درصدي سال 1403', 'Leakage Area (50%) Year 1403', @TaxGroupId, @StartDate, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

		 EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 120000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 120000001.0000 ,  165000000.0000  ,5.00 , @TaxTableId, 2250000.0)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 165000001.0000,  270000000.0000, 7.50 , @TaxTableId, 10125000.0)
		
		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 270000001.0000,  400000000.0000, 10.00 , @TaxTableId, 23125000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 400000001.0000,  99999999999.0000, 15.00 , @TaxTableId, 14963125000.0)
		
    END
    ------------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'معاف%'
	
IF (@taxGroupId is not null)
BEGIN
	-----------------معاف سال 1403
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
		(TaxGroupRef = @taxGroupId and [Date] >= '2024-03-20' and [Date] < '2025-03-21') OR (Title = 'جدول ماليات سال 1403 معاف'))
	BEGIN
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1

		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date], [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات سال 1403 معاف', 'NonTaxable (0%) Year 1403', @TaxGroupId, @StartDate, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES(@TaxTableItemId, 1.0000,	9999999999.0000,	0.00, @TaxTableId, 0.0000)
	END
	------------------
END

---------------------------- جدول مالياتي عيدي سال1403---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي عيدي سال 1403
		-- اين قسمت فقط براي جداول مالياتي عيدي سال 1403 مي باشد		
		-- اگر محاسباتي در سيستم حقوق عيدي براي سال 1403 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1403 AND [Type]= 6
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS VARCHAR) + '-' + CAST(@Month AS VARCHAR) + '-' + CAST(@Day AS VARCHAR) + ' 00:00:00.000') AS DATETIME)
			END
		ELSE
			SET @StartDate = CAST(('2024-03-20 00:00:00.000') AS DATETIME)

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'گروه هاي مالياتي عادي%'
	
IF (@taxGroupId is not null)
BEGIN

	----------------گروه هاي مالياتي عادي عيدي سال 1403
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE
			((TaxGroupRef = @taxGroupId and [Date] >= '2024-03-20' and [Date] < '2025-03-21') OR (Title = 'جدول ماليات عيدي سال 1403')) AND TaxType=2)
	BEGIN		
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date]  , TaxType , [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
		SELECT @TaxTableId, 'جدول ماليات عيدي سال 1403', 'New Year Taxable (100%) Year 1403', @TaxGroupId, @StartDate ,2, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 120000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 120000001.0000 ,  960000000.0000  ,10.00 , @TaxTableId, 84000000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 960000001.0000,  99999999999.0000, 20.00 , @TaxTableId, 19892000000.0)

	END
	----------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'مناطق محروم%'

IF (@taxGroupId is not null)
BEGIN
    -------------------مناطق محروم عيدي سال 1403
    IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
				((TaxGroupRef = @taxGroupId and [Date] >= '2024-03-20' and [Date] < '2025-03-21') OR (Title = 'جدول ماليات  عيدي 50 درصدي سال 1403')) AND TaxType=2)
	BEGIN

		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date],TaxType, [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات  عيدي 50 درصدي سال 1403', 'Leakage Area New Year (50%) Year 1403', @TaxGroupId, @StartDate,2, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 120000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 120000001.0000 ,  960000000.0000  ,5.00 , @TaxTableId, 42000000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 960000001.0000,  99999999999.0000, 10.00 , @TaxTableId, 9946000000.0)

	END
	----------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'معاف%'
	
IF (@taxGroupId is not null)
BEGIN
	-----------------معاف عيدي سال 1403
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
		((TaxGroupRef = @taxGroupId and [Date] >= '2024-03-20' and [Date] < '2025-03-21') OR (Title = 'جدول ماليات عيدي سال 1403 معاف')) AND TaxType=2)
	BEGIN
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1

		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date],TaxType, [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات عيدي سال 1403 معاف', 'NonTaxable New Year (0%) Year 1403', @TaxGroupId, @StartDate,2, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES(@TaxTableItemId, 1.0000,	99999999999.0000,	0.00, @TaxTableId, 0.0000)
	END
	------------------
END

    -------------------مناطق محروم عيدي سال 1403 اصلاحيه
UPDATE Pay.TaxTableItem
SET InLineAmount = 9946000000.0
WHERE InLineAmount = 49519999999.0 AND  ToAmount = 99999999999.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات  عيدي 50 درصدي سال 1403')

	----------------گروه هاي مالياتي عادي عيدي سال 1403 اصلاحيه
UPDATE Pay.TaxTableItem
SET InLineAmount = 19892000000.0
WHERE InLineAmount = 99039999999.0 AND  ToAmount = 99999999999.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات عيدي سال 1403')

    -------------------مناطق محروم سال 1403 اصلاحيه
UPDATE Pay.TaxTableItem
SET InLineAmount = 14963125000.0
WHERE InLineAmount = 49823124999.0 AND ToAmount = 99999999999.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات 50 درصدي سال 1403')

	----------------گروه هاي مالياتي عادي سال 1403 اصلاحيه
UPDATE Pay.TaxTableItem
SET InLineAmount = 29926250000.0
WHERE InLineAmount = 99646249999.0 AND ToAmount = 99999999999.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات سال 1403')

---------------------------- جدول مالياتي سال 1404---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي سال 1404
		-- اين قسمت فقط براي جداول مالياتي سال 1404 مي باشد		
		-- اگر محاسباتي در سيستم حقوق براي سال 1404 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد
		
		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1404
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS VARCHAR) + '-' + CAST(@Month AS VARCHAR) + '-' + CAST(@Day AS VARCHAR) + ' 00:00:00.000') AS DATETIME)
			END
		ELSE
			SET @StartDate = CAST(('2025-03-21 00:00:00.000') AS DateTime)

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'گروه هاي مالياتي عادي%'
	
IF (@taxGroupId is not null)
BEGIN
	----------------گروه هاي مالياتي عادي سال 1404
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE
			(TaxGroupRef = @taxGroupId and [Date] >= '2025-03-21' and [Date] < '2026-03-21') OR (Title = 'جدول ماليات سال 1404'))
	BEGIN						
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date], [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
		SELECT @TaxTableId, 'جدول ماليات سال 1404', 'Taxable (100%) Year 1404', @TaxGroupId, @StartDate, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 240000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 240000001.0000 ,  300000000.0000  ,10.00 , @TaxTableId, 6000000.0)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 300000001.0000,  380000000.0000, 15.00 , @TaxTableId, 18000000.0)
		
		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 380000001.0000,  500000000.0000, 20.00 , @TaxTableId, 42000000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 500000001.0000,  666666667.0000, 25.00 , @TaxTableId, 83666666.0)
		   
		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 666666668.0000,  999999999999.0000, 30.00 , @TaxTableId, 299883666665.0)
	 
	END
	----------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'مناطق محروم%'

IF (@taxGroupId is not null)
BEGIN
    -------------------مناطق محروم سال 1404
    IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
				(TaxGroupRef = @taxGroupId and [Date] >= '2025-03-21' and [Date] < '2026-03-21') OR (Title = 'جدول ماليات 50 درصدي سال 1404'))
	BEGIN
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date], [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات 50 درصدي سال 1404', 'Leakage Area (50%) Year 1404', @TaxGroupId, @StartDate, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 240000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 240000001.0000 ,  300000000.0000  ,5.00 , @TaxTableId, 3000000.0)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 300000001.0000,  380000000.0000, 7.50 , @TaxTableId, 9000000.0)
		
		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 380000001.0000,  500000000.0000, 10.00 , @TaxTableId, 21000000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 500000001.0000,  666666667.0000, 12.50 , @TaxTableId, 41833333.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 666666668.0000,  999999999999.0000, 15.00 , @TaxTableId, 149941833333.0)

    END
    ------------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'معاف%'
	
IF (@taxGroupId is not null)
BEGIN
	-----------------معاف سال 1404
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
		(TaxGroupRef = @taxGroupId and [Date] >= '2025-03-21' and [Date] < '2026-03-21') OR (Title = 'جدول ماليات سال 1404 معاف'))
	BEGIN
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1

		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date], [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات سال 1404 معاف', 'NonTaxable (0%) Year 1404', @TaxGroupId, @StartDate, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES(@TaxTableItemId, 1.0000,	999999999999.0000,	0.00, @TaxTableId, 0.0000)
	END
	------------------
END


---------------------------- جدول مالياتي عيدي سال 1404---------------------------
	--////////////////////////////////////////////////////
		-- محاسبه تاريخ شروع اعمال جدول مالياتي عيدي سال 1404
		-- اين قسمت فقط براي جداول مالياتي عيدي سال 1404 مي باشد		
		-- اگر محاسباتي در سيستم حقوق عيدي براي سال 1404 وجود داشته باشد،جدول مالياتي از يك ماه بعد از آخرين محاسبه اعمال خواهد شد

		SET @Year = 0
		SET @Month = 0
		SET @Day = 0
		SET @result = 0
		
		SELECT TOP 1 @Year = [Year],@Month = [Month] 
			FROM Pay.Calculation 
				WHERE [Year] = 1404 AND [Type] = 6
					ORDER BY [Date] DESC -- Fetch Last Calc Date

		IF (@Year <> 0 AND @Month  <> 0)
			BEGIN
				IF (@Month = 12)
					BEGIN
						SET @Year = @Year + 1
						SET @Month = 1
					END
				ELSE
					SET @Month = @Month +  1
					
				SET @Day = 1
				
				EXEC FMK.spDateShamsiToMiladi @Year OUT ,@Month OUT,@Day OUT, @result OUT
			END
			
		IF(@result <> 0)	
			BEGIN
				SET @StartDate = CAST((CAST(@Year AS VARCHAR) + '-' + CAST(@Month AS VARCHAR) + '-' + CAST(@Day AS VARCHAR) + ' 00:00:00.000') AS DATETIME)
			END
		ELSE
			SET @StartDate = CAST(('2025-03-21 00:00:00.000') AS DATETIME)

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'گروه هاي مالياتي عادي%'
	
IF (@taxGroupId is not null)
BEGIN

	----------------گروه هاي مالياتي عادي عيدي سال 1404
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE
			((TaxGroupRef = @taxGroupId and [Date] >= '2025-03-21' and [Date] < '2026-03-21') OR (Title = 'جدول ماليات عيدي سال 1404')) AND TaxType=2)
	BEGIN		
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date]  , TaxType , [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
		SELECT @TaxTableId, 'جدول ماليات عيدي سال 1404', 'New Year Taxable (100%) Year 1404', @TaxGroupId, @StartDate ,2, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 240000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 240000001.0000 ,  1920000000.0000  ,10.00 , @TaxTableId, 168000000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1920000001.0000,  999999999999.0000, 20.00 , @TaxTableId, 19784000000.0)

	END
	----------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'مناطق محروم%'

IF (@taxGroupId is not null)
BEGIN
    -------------------مناطق محروم عيدي سال 1404
    IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
				((TaxGroupRef = @taxGroupId and [Date] >= '2025-03-21' and [Date] < '2026-03-21') OR (Title = 'جدول ماليات  عيدي 50 درصدي سال 1404')) AND TaxType=2)
	BEGIN

		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1
		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date],TaxType, [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات  عيدي 50 درصدي سال 1404', 'Leakage Area New Year (50%) Year 1404', @TaxGroupId, @StartDate,2, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1.0000, 240000000.0000, 0.00 , @TaxTableId, 0.0000)

        EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 240000001.0000 ,  1920000000.0000  ,5.00 , @TaxTableId, 84000000.0)

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES( @TaxTableItemId, 1920000001.0000,  999999999999.0000, 10.00 , @TaxTableId, 99892000000.0)

	END
	----------------
END

SELECT TOP 1 @taxGroupId = TaxGroupID FROM Pay.TaxGroup
WHERE Title like 'معاف%'
	
IF (@taxGroupId is not null)
BEGIN
	-----------------معاف عيدي سال 1404
	IF Not Exists(SELECT 1 FROM Pay.TaxTable WHERE 
		((TaxGroupRef = @taxGroupId and [Date] >= '2025-03-21' and [Date] < '2026-03-21') OR (Title = 'جدول ماليات عيدي سال 1404 معاف')) AND TaxType=2)
	BEGIN
		EXEC FMK.spGetNextId 'Pay.TaxTable', @TaxTableId OUT, 1

		INSERT INTO Pay.TaxTable(TaxTableId, Title, Title_En, TaxGroupRef, [Date],TaxType, [Version], Creator, CreationDate, LastModIFier, LastModIFicationDate)
	    SELECT @TaxTableId, 'جدول ماليات عيدي سال 1404 معاف', 'NonTaxable New Year (0%) Year 1404', @TaxGroupId, @StartDate,2, 1, @Creator, @modIFyDate, @Creator, @modIFyDate

		EXEC FMK.spGetNextId 'Pay.TaxTableItem', @TaxTableItemId OUT, 1
		INSERT INTO Pay.TaxTableItem (TaxTableItemId, FROMAmount, ToAmount, Rate, TaxTableRef, InLineAmount)
		VALUES(@TaxTableItemId, 1.0000,	999999999999.0000,	0.00, @TaxTableId, 0.0000)
	END
	------------------
END

    -------------------مناطق محروم سال 1404 اصلاحيه

UPDATE Pay.TaxTableItem
SET InLineAmount = 41833333.0 , ToAmount = 666666667
WHERE InLineAmount = 41000000.0 AND ToAmount = 660000000.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات 50 درصدي سال 1404')
UPDATE Pay.TaxTableItem
SET InLineAmount = 149941833333.0 , FromAmount = 666666668
WHERE InLineAmount = 149941999999.0 AND ToAmount = 999999999999.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات 50 درصدي سال 1404')

	----------------گروه هاي مالياتي عادي سال 1404 اصلاحيه


UPDATE Pay.TaxTableItem
SET InLineAmount = 83666666.0 , ToAmount = 666666667
WHERE InLineAmount = 81999999.0 AND ToAmount = 660000000.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات سال 1404')
UPDATE Pay.TaxTableItem
SET InLineAmount = 299883666665.0 , FromAmount = 666666668
WHERE InLineAmount = 299883999999.0 AND ToAmount = 999999999999.0000 AND TaxTableRef IN (SELECT TaxTableId
																						FROM Pay.TaxTable 
																						WHERE Title = 'جدول ماليات سال 1404')
