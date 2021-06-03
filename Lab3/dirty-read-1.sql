USE AstronomicalObservatory
GO

DECLARE @tempTable TABLE (
	currentTime DATETIME,
	info VARCHAR(100),
	resource_type VARCHAR(100),
	request_mode  VARCHAR(100), 
	request_type  VARCHAR(100), 
	request_status  VARCHAR(100),
	request_session_id INT 
)



BEGIN TRAN
INSERT INTO @tempTable(currentTime, info, resource_type, request_mode, request_type, request_status, request_session_id)
SELECT GETDATE(), 'dirty read - before update', resource_type, request_mode, request_type, request_status, request_session_id 
FROM sys.dm_tran_locks
WHERE request_owner_type='TRANSACTION'

UPDATE Planet SET Name = 'Dirty Planet' WHERE Name = 'Planeta X' 

INSERT INTO @tempTable
SELECT GETDATE(), 'dirty read - after update', resource_type, request_mode, request_type, request_status, request_session_id 
FROM sys.dm_tran_locks
WHERE request_owner_type='TRANSACTION'

WAITFOR DELAY '00:00:10:000'

ROLLBACK TRAN

SELECT * FROM @tempTable
INSERT INTO LogConcurrencyIssues
SELECT * FROM @tempTable

SELECT * FROM LogConcurrencyIssues