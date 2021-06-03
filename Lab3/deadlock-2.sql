
BEGIN TRAN
	EXEC addLogConcurrencyIssue 'deadlock2 - before update'

	UPDATE Planet
	SET Age = 888
	WHERE Name = 'Deadlock planet'

	EXEC addLogConcurrencyIssue 'deadlock2 - between updates'

	WAITFOR DELAY '00:00:10:000'

	UPDATE Comet
	SET Size = 888
	WHERE Name = 'Deadlock comet'

	EXEC addLogConcurrencyIssue 'deadlock2 - after updates'
COMMIT TRAN