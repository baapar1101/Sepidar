UPDATE c
SET EndDate = cc.EndDate
FROM Pay.Contract c,
(
SELECT c.ContractID, IssueDate, PersonnelRef, --c.EndDate,
	(SELECT MIN(EndDate) 
		FROM Pay.Contract cc 
		WHERE cc.IssueDate > c.IssueDate 
		  AND c.PersonnelRef = cc.PersonnelRef 
		  AND cc.EndDate IS NOT NULL) EndDate
FROM Pay.Contract c
WHERE c.EndDate IS NULL
) cc 
WHERE c.ContractID = cc.ContractID
 AND cc.EndDate IS NOT NULL
