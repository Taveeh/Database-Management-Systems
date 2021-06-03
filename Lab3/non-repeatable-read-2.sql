EXEC AddPlanetToSolarSystem2 'Planeta Test', 69, 420

BEGIN TRAN
	EXEC addLogConcurrencyIssue 'non-repeatable read - before update'

	UPDATE Planet 
	SET Name = 'Dirty planet'
	WHERE Name = 'Planeta Test'
	
	EXEC addLogConcurrencyIssue 'non-repeatable read - after update'

COMMIT TRAN

DELETE FROM Planet WHERE Name='Dirty Planet'

SELECT * FROM LogConcurrencyIssues

SELECT @@TRANCOUNT