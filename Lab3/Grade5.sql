DROP TABLE LogTable
CREATE TABLE LogTable (
	info varchar(100),
	error varchar(1000),
	logTime DATETIME
)
GO

CREATE OR ALTER PROCEDURE addLog (@info VARCHAR(100), @error VARCHAR(100)) AS
	INSERT INTO LogTable VALUES (@info, @error,GETDATE())
GO

CREATE OR ALTER PROCEDURE AddPlanetToSolarSystem2(@PlanetNamme VARCHAR(50), @PlanetAge FLOAT, @PlanetSize FLOAT)
AS
	DECLARE @maxId INT
	SET @maxId = (SELECT MAX(P.Id) FROM Planet P)
	SET @maxId = @maxId + 1
	PRINT @maxID
	IF (@PlanetNamme is null)
	BEGIN
		RAISERROR('Planet name mmust not be null', 16, 1);
	END
	IF (@PlanetSize is null)
	BEGIN
		RAISERROR('Planet size mmust not be null', 16, 1);
	END
	IF (@PlanetAge is null)
	BEGIN
		RAISERROR('Planet age mmust not be null', 16, 1);
	END
	IF (@maxId is null)
	BEGIN
		SET @maxId = 0
	END
	INSERT INTO Planet(ID, SolarSystemID, Name, Age, Size) VALUES (@maxId, 2, @PlanetNamme, @PlanetAge, @PlanetSize)
GO

EXEC AddPlanetToSolarSystem2 'Planeta Pluto', 3, 4

SELECT * FROM Comet;
GO

CREATE OR ALTER PROCEDURE AddComet(@CometName VARCHAR(50), @CometSize INT)
AS
	DECLARE @maxId INT
	SET @maxId = (SELECT MAX(C.id) FROM Comet C) 
	SET @maxId = @maxId + 1
	IF (@maxId = null)
	BEGIN
		SET @maxId = 0
	END
	PRINT @CometName
	IF (@CometName is null)
	BEGIN
		RAISERROR('Comet name mmust not be null', 16, 1);
	END
	IF (@CometSize is null)
	BEGIN
		RAISERROR('Comet size mmust not be null', 16, 1);
	END
	INSERT INTO Comet(ID, Name, Size) VALUES (@maxId, @CometName, @CometSize)
GO

CREATE OR ALTER PROCEDURE AddCometVisibleFromPlanet(@CometName VARCHAR(50) , @PlanetName VARCHAR(50), @Distance INT)
AS
	DECLARE @cometID INT
	SET @cometID = (SELECT C.ID FROM Comet C WHERE C.Name = @CometName)
	DECLARE @planetId INT
	SET @planetId = (SELECT C.ID FROM Planet C WHERE C.Name = @PlanetName)

	IF (@cometID is null)
	BEGIN
		RAISERROR('Comet does not exist', 16, 1);
	END
	IF (@planetId is null)
	BEGIN
		RAISERROR('Planet does not exist', 16, 1);
	END
	IF (@Distance is null) 
	BEGIN
		RAISERROR('Distace must not be nnull', 16, 1);
	END
	INSERT INTO CometVisibleFromPlanet(PlanetID, CometID, DistanceBetweenThem) VALUES (@planetId, @cometID, @Distance)
GO

CREATE OR ALTER PROCEDURE addRollbackScenario (
	@planetName VARCHAR(50), 
	@planetAge INT,
	@planetSize INT,
	@cometName VARCHAR(50),
	@cometSize INT,
	@distance INT
)
AS
	BEGIN TRAN
	BEGIN TRY
		EXEC AddPlanetToSolarSystem2 @planetName, @planetAge, @planetSize
		INSERT INTO LogTable VALUES ('Planet added', '', GETDATE())
		EXEC AddComet @cometName, @cometSize
		INSERT INTO LogTable VALUES ('Comet Added', '', GETDATE())
		EXEC AddCometVisibleFromPlanet @cometName, @planetName, @distance
		INSERT INTO LogTable VALUES ('CometVisibleFromPlanet added', '', GETDATE())
	END TRY
	BEGIN CATCH
		SELECT * FROM LogTable
		WAITFOR DELAY '00:00:10:000'
		ROLLBACK TRAN
		RETURN
	END CATCH
	COMMIT TRAN
GO

EXEC addRollbackScenario 'Planeta Y', 15, 30, null, 4, 5432

EXEC addRollbackScenario 'Planeta Y', 15, 30, 'Cometa Johhny Bravo', 4, 5432



SELECT* FROM LogTable
GO


CREATE OR ALTER PROCEDURE addRecoverPossible (
	@planetName VARCHAR(50), 
	@planetAge INT,
	@planetSize INT,
	@cometName VARCHAR(50),
	@cometSize INT,
	@distance INT
)
AS
	BEGIN TRAN
	DECLARE @error VARCHAR(100)
	BEGIN TRY
		EXEC AddPlanetToSolarSystem2 @planetName, @planetAge, @planetSize
		EXEC addLog 'Planet Added', ''
	END TRY
	BEGIN CATCH
		SELECT @error = ERROR_MESSAGE()
		EXEC addLog 'Planet not added', @error
		COMMIT TRAN
		RETURN
	END CATCH
	BEGIN TRY
		EXEC AddComet @cometName, @cometSize
		EXEC addLog 'Comet Added', ''
	END TRY
	BEGIN CATCH
		SELECT @error = ERROR_MESSAGE()
		EXEC addLog 'Comet not added', @error
		COMMIT TRAN
		RETURN
	END CATCH
	BEGIN TRY
		EXEC AddCometVisibleFromPlanet @cometName, @planetName, @distance
		EXEC addLog 'Comet visible from planet Added', ''
	END TRY
	BEGIN CATCH
		SELECT @error = ERROR_MESSAGE()
		EXEC addLog 'Comet visible from planet not added', @error
		COMMIT TRAN
		RETURN
	END CATCH
	EXEC addLog 'Everything was added', ''
	COMMIT TRAN
GO

DELETE FROM CometVisibleFromPlanet WHERE PlanetID = 11
DELETE FROM Planet WHERE Name = 'Planeta Y'
DELETE FROM Comet WHERE Name is NULL
EXEC addRecoverPossible 'Planeta Y', 15, 30, null, 4, 5432

EXEC addRecoverPossible 'Planeta Y', 15, 30, 'Cometa Johhny Bravo', 4, 5432

SELECT * FROM LogTable

SELECT * FROM Comet
SELECT * FROM Planet
SELECT * FROM CometVisibleFromPlanet