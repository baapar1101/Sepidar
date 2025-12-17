IF NOT EXISTS (SELECT 1 FROM Gnr.location  WHERE LocationID = 1)
begin
	declare @id int
	Exec Fmk.spGetNextID 'GNR.Location',@id output
	INSERT INTO Gnr.location (LocationId, Title, Title_En , Code, Parent, Type, Version)
	VALUES(1, 'محل هاي جغرافيايي', 'Geographical Locations', null, null, 0, 1  )
end