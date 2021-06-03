USE AstronomicalObservatory GO

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN

	EXEC addLogConcurrencyIssue 'phantom read - before select'

	SELECT * FROM Planet

	EXEC addLogConcurrencyIssue ' phantom read - between select'

	WAITFOR DELAY '00:00:10:000'

	SELECT * FROM Planet

	EXEC addLogConcurrencyIssue 'phantom read - after select'

COMMIT TRAN