EXEC AddPlanetToSolarSystem2 'Deadlock planet', 1, 2
EXEC AddComet 'Deadlock comet', 1
BEGIN TRAN
	EXEC addLogConcurrencyIssue 'deadlock1 - before update'

	UPDATE Comet
	SET Size = 999
	WHERE Name = 'Deadlock comet'

	EXEC addLogConcurrencyIssue 'deadlock1 - between updates'

	WAITFOR DELAY '00:00:10:000'

	UPDATE Planet
	SET Age = 999
	WHERE Name = 'Deadlock planet'

	EXEC addLogConcurrencyIssue 'deadlock1 - after updates'
COMMIT TRAN

SELECT * FROM Planet
SELECT * FROM Comet