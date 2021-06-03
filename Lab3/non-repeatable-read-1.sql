USE AstronomicalObservatory

SET TRANSACTION ISOLATION LEVEL READ COMMITTED 

-- SOLUTION
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
	
	EXEC addLogConcurrencyIssue 'non-repeatable read - before select'

	SELECT * FROM Planet

	EXEC addLogConcurrencyIssue 'non-repeatable read - between select'

	WAITFOR DELAY '00:00:10:000'

	SELECT * FROM Planet

	EXEC addLogConcurrencyIssue 'non-repeatable read - after select'

COMMIT TRAN

SELECT @@TRANCOUNT

