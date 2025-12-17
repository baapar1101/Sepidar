If Object_ID('GNR.vwReminder') Is Not Null
	Drop View GNR.vwReminder
GO

CREATE VIEW GNR.vwReminder
AS
SELECT
    [ReminderID],
    [EntityRef],
    [Type],
    [Title],
    [Title_En],
    [Description],
    [Description_En],
    [DueDate],
    0 AS [State]
FROM GNR.Reminder
