CREATE OR ALTER PROCEDURE AddPlanetToSolarSystem2(@PlanetNamme VARCHAR(50), @PlanetAge FLOAT, @PlanetSize FLOAT)
AS
	DECLARE @maxId INT
	SET @maxId = (SELECT MAX(P.Id) FROM Planet P)
	SET @maxId = @maxId + 1
	IF (@PlanetNamme = null)
	BEGIN
		RAISERROR('Planet name mmust not be null', 16, 1);
	END
	IF (@PlanetSize = null)
	BEGIN
		RAISERROR('Planet size mmust not be null', 16, 1);
	END
	IF (@PlanetAge = null)
	BEGIN
		RAISERROR('Planet age mmust not be null', 16, 1);
	END
	IF (@maxId = null)
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
	IF (@CometName = null)
	BEGIN
		RAISERROR('Comet name mmust not be null', 16, 1);
	END
	IF (@CometSize = null)
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
	IF (@cometID = null)
	BEGIN
		RAISERROR('Comet does not exist', 16, 1);
	END
	IF (@planetId = null)
	BEGIN
		RAISERROR('Planet does not exist', 16, 1);
	END
	IF (@Distance = null) 
	BEGIN
		RAISERROR('Distace must not be nnull', 16, 1);
	END
	INSERT INTO CometVisibleFromPlanet(PlanetID, CometID, DistanceBetweenThem) VALUES (@planetId, @cometID, @Distance)
GO

CREATE OR ALTER PROCEDURE addRollbackScenario
AS
	BEGIN TRAN
	BEGIN TRY
		EXEC AddPlanetToSolarSystem2 'Planeta X', 12, 5
		EXEC AddComet 'Cometa Johnny Bravo', 23
		EXEC AddCometVisibleFromPlanet 'dasfd', 'Planeta X', 5412
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		RETURN
	END CATCH
	COMMIT TRAN
GO

EXEC addRollbackScenario

SELECT * FROM Comet
SELECT * FROM Planet
SELECT * FROM CometVisibleFromPlanet