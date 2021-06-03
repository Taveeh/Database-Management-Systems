USE AstronomicalObservatory
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- SOLUTION
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN

EXEC addLogConcurrencyIssue 'dirty read - before select'

SELECT * FROM Planet

EXEC addLogConcurrencyIssue 'dirty read - after select'

COMMIT TRAN

