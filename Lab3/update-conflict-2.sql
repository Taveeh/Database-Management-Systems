BEGIN TRAN
	EXEC addLogConcurrencyIssue 'update conflict2 - before update'

	UPDATE Planet
	SET Size = 777
	WHERE Name = 'Deadlock planet'

	WAITFOR DELAY '00:00:10:000'

	EXEC addLogConcurrencyIssue 'update conflict2 - after update'

COMMIT TRAN
