If Object_ID('PAY.vwLeave') Is Not Null
	Drop View PAY.vwLeave
GO
CREATE VIEW PAY.vwLeave
AS
SELECT     PAY.Leave.LeaveId, PAY.Leave.PersonnelRef, PAY.Leave.Date, PAY.Leave.SystemRemainder, PAY.Leave.UserRemainder, PAY.vwPersonnel.DLTitle, 
                      PAY.vwPersonnel.DLTitle_En, PAY.vwPersonnel.DLCode, PAY.Leave.Version, PAY.Leave.Creator, PAY.Leave.CreationDate, PAY.Leave.LastModifier, 
                      PAY.Leave.LastModificationDate, PAY.Leave.Solaryear, PAY.Leave.Month
FROM         PAY.Leave INNER JOIN
                      PAY.vwPersonnel ON PAY.Leave.PersonnelRef = PAY.vwPersonnel.PersonnelId

