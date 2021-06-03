USE AstronomicalObservatory
GO

DELETE FROM Planet WHERE ID = 99

BEGIN TRAN
	EXEC addLogConcurrencyIssue 'phantom read - before insert'

	INSERT INTO Planet (ID, Name) VALUES (99, 'Marcel the phantom')

	EXEC addLogConcurrencyIssue 'phantom read - after insert'

COMMIT TRAN

