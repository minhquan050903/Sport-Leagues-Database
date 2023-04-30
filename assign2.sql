--Roasters:
--Insert
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE spRostersInsert(
    playerId rosters.playerId%type,
    teamId rosters.teamid%type,
    active rosters.isActive%type,
    jerseyNum rosters.jerseynumber%type,
    roasterId OUT rosters.rosterId%type,
    exitCode OUT number)
AS
BEGIN
    SELECT max(rosterID) + 1
    INTO roasterId
    FROM rosters;
 
    INSERT INTO rosters (rosterId, playerId, teamId, isActive, jerseynumber)
    VALUES (roasterId , playerId, teamId, active, jerseyNum);
    exitCode := 0;
EXCEPTION
 
 WHEN OTHERS
 THEN exitCode := -1;
END spRostersInsert;
--exe
/
DECLARE
roasterId rosters.rosterId%type;
exitCode number;
BEGIN
	spRostersInsert(1, 212, 1, 22, roasterId, exitCode);
	IF exitCode = 0 THEN
    	DBMS_OUTPUT.PUT_LINE('Added to Roasters Table : ' || roasterId);
	ELSE
    	DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
	END IF;
END;


                  


-- UPDATE
CREATE OR REPLACE PROCEDURE spRostersUpdate(
    rosId rosters.rosterId%type,
    playId rosters.playerId%type,
    teamId rosters.teamid%type,
    active rosters.isActive%type,
    jerseyNum rosters.jerseynumber%type,
    exitCode OUT number)
AS
BEGIN
    UPDATE rosters
    SET playerId = playID,
    teamId = teamId,
    isActive = active,
    jerseynumber = jerseyNum
    WHERE rosterID = rosId;
    exitCode := 0;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN exitCode := -1;
    WHEN OTHERS
    THEN exitCode := -3;
END spRostersUpdate;
/
DECLARE
	exitCode NUMBER;
    rosterId rosters.rosterId%type:=9;
BEGIN
	spRostersUpdate(rosterId, 1234567, 211, 1, 20,exitCode);
	IF exitCode = 0 THEN
    	DBMS_OUTPUT.PUT_LINE('Successfully Updated Roster: ' || rosterId);
	ELSIF exitCode = -1 THEN
    	DBMS_OUTPUT.PUT_LINE('Rosters Does Not Exist');
	ELSE
     	DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
	END IF;
END;



-- DELETE
CREATE OR REPLACE PROCEDURE spRostersDelete(
    rosId rosters.rosterId%type,
    exitCode OUT number) AS
BEGIN
    DELETE FROM rosters
    WHERE rosterID = rosId;
     
    IF SQL%ROWCOUNT = 1 THEN 
        exitCode :=0;
    ELSIF SQL%ROWCOUNT = 0 THEN 
        exitCode :=-1;
    ELSE
        exitCode :=-4;
    END IF;   
END spRostersDelete;
/
DECLARE
    rosterId rosters.rosterId%type:=9;
    exitCode NUMBER ;
BEGIN
    spRostersDelete(rosterId , exitCode);
    
    IF exitCode = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Roster deleted successfully:'||rosterId );
    ELSIF exitCode =-1 THEN
         DBMS_OUTPUT.PUT_LINE('Roster Does Not Exist');
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured'|| exitCode);
        
    END IF;    
END;


-- SELECT
CREATE OR REPLACE PROCEDURE spRostersSelect(
    rosId rosters.rosterid%type,
    roster OUT rosters%rowtype,
    exitCode OUT number) AS
BEGIN
    SELECT *
    INTO roster 
    FROM rosters
    WHERE rosterID = rosId;
EXCEPTION
    WHEN NO_DATA_FOUND THEN exitCode := -1;
    WHEN OTHERS THEN exitCode := -3;
END spRostersSelect;
/
DECLARE
	roster rosters%rowtype;
	exitCode NUMBER;
BEGIN
	spRostersSelect(2, roster, exitCode);
	IF exitCode = -1 THEN
    		DBMS_OUTPUT.PUT_LINE('Roster Does Not Exist');
	ELSIF exitCode = -3 THEN
    	DBMS_OUTPUT.PUT_LINE('Roster Error Occured');
	ELSE
        DBMS_OUTPUT.PUT_LINE (roster.rosterid);
    	DBMS_OUTPUT.PUT_LINE (roster.playerid);
    	DBMS_OUTPUT.PUT_LINE (roster.teamid);
        DBMS_OUTPUT.PUT_LINE (roster.isactive);
        DBMS_OUTPUT.PUT_LINE (roster.jerseynumber);
	END IF;   
END;

--lOCATION

-- INSERT
CREATE OR REPLACE PROCEDURE spLocationsInsert(
    lName slLocations.locationname%type,
    fLength slLocations.fieldlength%type,
    active slLocations.isActive%type,
    locId OUT slLocations.locationId%type,
    exitCode OUT number)
AS
BEGIN
    SELECT max(locationId) + 1
    INTO locId
    FROM slLocations;
 
    INSERT INTO slLocations (locationId, locationName, fieldLength, isActive)
    VALUES (locId , lName, fLength, active);
    exitCode := 0;
EXCEPTION
    WHEN OTHERS THEN exitCode := -1;
END spLocationsInsert;

/
DECLARE
locationId slLocations.locationId%type;
exitCode NUMBER;
BEGIN
	spLocationsInsert('Seneca', 110, 1,locationId, exitCode);
	IF exitCode = 0 THEN
    	DBMS_OUTPUT.PUT_LINE('Added to Roasters Table : ' || locationId);
	ELSE
    	DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
	END IF;
END;

    

-- UPDATE
CREATE OR REPLACE PROCEDURE spLocationsUpdate(
    locId  slLocations.locationid%type,
    lName slLocations.locationname%type,
    fLength slLocations.fieldlength%type,
    active slLocations.isActive%type,
    exitCode OUT number)
AS
BEGIN
    exitCode:=0;
    UPDATE slLocations
    SET locationName = lName,
    fieldLength = fLength,
    isActive = active
    WHERE locationid = locId;
 
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN exitCode := -1;
    WHEN OTHERS
    THEN exitCode := -3;
    END spLocationsUpdate;
/
DECLARE
	exitCode NUMBER;
    locationId slLocations.locationid%type:=38;
BEGIN
	spLocationsUpdate(locationId, 'Seneca dasd', 111, 1, exitCode);
	IF exitCode = 0 THEN
    	DBMS_OUTPUT.PUT_LINE('Successfully Updated Location: ' || locationId);
	ELSIF exitCode = -1 THEN
    	DBMS_OUTPUT.PUT_LINE('Location Does Not Exist');
	ELSE
     	DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
	END IF;
END;

-- DELETE
CREATE OR REPLACE PROCEDURE spLocationsDelete(
    locId numeric,
    exitCode OUT number) AS
BEGIN
 DELETE FROM slLocations
 WHERE locationID = locId;
    exitCode :=0;
    IF SQL%ROWCOUNT = 1 THEN 
        exitCode :=0;
    ELSIF SQL%ROWCOUNT = 0 THEN 
        exitCode :=-1;
    ELSE
        exitCode :=-4;
    END IF; 
END spLocationsDelete;
/
DECLARE
    locationId  slLocations.locationid%type:=9;
    exitCode NUMBER ;
BEGIN
    spLocationsDelete( locationId , exitCode);
    
    IF exitCode = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Roster deleted successfully:'||locationId );
    ELSIF exitCode =-1 THEN
        DBMS_OUTPUT.PUT_LINE('Location  Not Found');
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
        
    END IF;    
END;

-- SELECT
CREATE OR REPLACE PROCEDURE spLocationsSelect(
 locId IN slLocations.locationid%type,
 locations OUT sllocations%rowtype,
 exitCode OUT number ) AS
BEGIN
 exitCode:=0;
 SELECT *
 INTO locations
 FROM sllocations
 WHERE locationid = locId;

EXCEPTION
 WHEN NO_DATA_FOUND
 THEN exitCode := -1;
 WHEN OTHERS
 THEN exitCode := -3;
END spLocationsSelect;
/
DECLARE
	locations sllocations%rowtype;
	exitCode NUMBER;
	locationId slLocations.locationid%type:=3;
BEGIN
	spLocationsSelect(locationId, locations, exitCode);
	IF exitCode = -1 THEN
    	DBMS_OUTPUT.PUT_LINE('Location Does Not Exist');
	ELSIF exitCode = -3 THEN
    	DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
	ELSE
    	DBMS_OUTPUT.PUT_LINE ('ID:'||locations.locationid);
    	DBMS_OUTPUT.PUT_LINE ('Name:'||locations.locationname);
        DBMS_OUTPUT.PUT_LINE ('Field Length'||locations.fieldlength);
        DBMS_OUTPUT.PUT_LINE ('Active :'||locations.isactive);
        
	END IF;   
END;

CREATE OR REPLACE PROCEDURE spRosters(exitCode OUT number) AS 
CURSOR r IS 
    SELECT * 
    FROM Rosters;
    roster rosters%rowtype;
BEGIN DBMS_OUTPUT.PUT_LINE(
  RPAD('RosterID', 10)|| ' ' || RPAD('PlayerID', 10)|| ' ' || RPAD('TeamID', 8)|| ' ' || RPAD('isActive', 10)|| ' ' || RPAD('JerseyNumber', 15)
);
OPEN r;
LOOP FETCH r INTO roster;
EXIT WHEN r % notfound;
DBMS_OUTPUT.PUT_LINE(
  RPAD(roster.rosterId, 10)|| ' ' || RPAD(roster.playerId, 10)|| ' ' || RPAD(roster.teamId, 8)|| ' ' || RPAD(roster.isActive, 10)|| ' ' || RPAD(roster.jerseyNumber, 15)
);
END LOOP;
CLOSE r;
EXCEPTION 
WHEN OTHERS THEN exitCode := -1;
END spRosters;
/
DECLARE 
    exitCode NUMBER;
BEGIN
    spRosters(exitCode);
    IF exitCode = -1 THEN DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
    END IF;
END;    

-- slLocations
CREATE OR REPLACE PROCEDURE spSlLocations(exitCode OUT NUMBER) AS 
    CURSOR l IS 
    SELECT * 
    FROM slLocations;
    locations slLocations%rowtype;
BEGIN DBMS_OUTPUT.PUT_LINE(
  RPAD('LocationID', 10)|| ' ' || RPAD('LocationName', 35)|| ' ' || RPAD('FieldLength', 15)|| ' ' || RPAD('isActive', 10)
);
OPEN l;
LOOP FETCH l INTO locations;
EXIT WHEN l%notfound;
DBMS_OUTPUT.PUT_LINE(
  RPAD(locations.locationId, 10)|| ' ' || RPAD(locations.LocationName, 35)|| ' ' || RPAD(locations.fieldLength, 15)|| ' ' || RPAD(locations.isActive, 10)
);
END LOOP;
CLOSE l;
EXCEPTION 
WHEN OTHERS THEN exitCode := -1;
END spSlLocations;
/
DECLARE 
    exitCode NUMBER;
BEGIN
    spSlLocations(exitCode);
    IF exitCode = -1 THEN DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
    END IF;
END;


CREATE OR REPLACE PROCEDURE spSchedUpcomingGames(
    n IN NUMERIC,
    exitCode OUT number
) AS
 game games%rowtype;
 CURSOR g IS
 SELECT *
 FROM games
 WHERE trunc(gamedatetime) BETWEEN trunc(SYSDATE + 1) AND trunc(SYSDATE + n);
BEGIN
DBMS_OUTPUT.PUT_LINE(RPAD('GameID', 10) || RPAD('GameNum', 10) || RPAD('GameDate', 10) || RPAD('HomeTeam ID', 10) || RPAD('VisitTeam ID', 10)  || RPAD('LocationID', 12));
 OPEN g;
 LOOP
 FETCH g INTO game;
 EXIT WHEN g%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE(RPAD(game.gameid, 10) || RPAD(game.gamenum, 10) || 
RPAD(game.gamedatetime, 10) || RPAD(game.hometeam, 10)  || 
RPAD(game.visitteam, 10)  || RPAD(game.locationid, 12) ); 
 END LOOP;
 CLOSE g;
 EXCEPTION WHEN OTHERS THEN exitCode := -1;
END spSchedUpcomingGames;
/
DECLARE 
    exitCode NUMBER;
BEGIN
    spSchedUpcomingGames(100,exitCode);
    IF exitCode = -1 THEN DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
    END IF;
END;


 
--Q10
CREATE OR REPLACE PROCEDURE spSchedPastGames(
     n IN NUMBER,
    exitCode OUT number
) AS
 game games%rowtype;
 CURSOR g IS
 SELECT *
 FROM games
 WHERE trunc(gamedatetime) BETWEEN trunc(SYSDATE - n) AND trunc(SYSDATE -1);
BEGIN
DBMS_OUTPUT.PUT_LINE(RPAD('GameID', 10) || RPAD('GameNum', 10) || RPAD('GameDate', 10) || RPAD('HomeTeam ID', 10) || RPAD('VisitTeam ID', 10)  || RPAD('LocationID', 12));
 OPEN g;
 LOOP
 FETCH g INTO game;
 EXIT WHEN g%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE(RPAD(game.gameid, 10) || RPAD(game.gamenum, 10) || 
RPAD(game.gamedatetime, 10) || RPAD(game.hometeam, 10)  || 
RPAD(game.visitteam, 10)  || RPAD(game.locationid, 12) ); 
 END LOOP;
 CLOSE g;
 EXCEPTION WHEN OTHERS THEN exitCode := -1;
END spSchedPastGames;
/
DECLARE 
    exitCode NUMBER;
BEGIN
    spSchedPastGames(100,exitCode);
    IF exitCode = -1 THEN DBMS_OUTPUT.PUT_LINE('An Unknown Error Occured');
    END IF;
END;









