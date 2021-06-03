USE AstronomicalObservatory
GO
ALTER DATABASE AstronomicalObservatory
SET ALLOW_SNAPSHOT_ISOLATION ON

SET TRANSACTION ISOLATION LEVEL SNAPSHOT

BEGIN TRAN
	EXEC addLogConcurrencyIssue 'update conflict1 - before select'

	SELECT * FROM Planet

	EXEC addLogConcurrencyIssue 'update conflict - between'

	WAITFOR DELAY '00:00:10:000'

	UPDATE Planet
	SET Size = 666
	WHERE Name = 'Deadlock planet'

	EXEC addLogConcurrencyIssue 'update conflict - after update'
COMMIT TRAN