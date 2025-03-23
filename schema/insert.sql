--CUSTOMER ACCOUNT INFO
BULK INSERT CustomerAccountInfo FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\customers.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a'
);
SELECT *FROM CustomerAccountInfo;

--OWNED BOARD GAMES 
BULK INSERT OwnedBoardGames FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\owned_board_games.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
);
SELECT *FROM OwnedBoardGames;

-- WORKERS 
BULK INSERT Workers FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\workers.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001'
);
SELECT *FROM Workers;

--TOURNAMENTS 
BULK INSERT Tournaments FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\tournaments.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Tournaments;

--TOURNAMENT PARTICIPANTS 
BULK INSERT TournamentParticipants FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\tournament_participants.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM TournamentParticipants;

-- RENTS
BULK INSERT Rents FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\rents.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Rents;

--POSTERS 
BULK INSERT Posters FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\posters.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Posters;