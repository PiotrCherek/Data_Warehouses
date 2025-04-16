--CUSTOMER ACCOUNT INFO
BULK INSERT CustomerAccountInfo FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\customers_T1.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
);
SELECT *FROM CustomerAccountInfo;

--OWNED BOARD GAMES 
BULK INSERT OwnedBoardGames FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\owned_board_games_T1.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
);
SELECT *FROM OwnedBoardGames;

--WORKERS

BULK INSERT Workers
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\workers_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);
SELECT *FROM Workers;
--TOURNAMENTS 
BULK INSERT Tournaments FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\tournaments_T1.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Tournaments;

--TOURNAMENT PARTICIPANTS 
BULK INSERT TournamentParticipants FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\tournament_participants_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM TournamentParticipants;

-- RENTS
BULK INSERT Rents FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\rents_T1.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Rents;

--POSTERS 
BULK INSERT Posters FROM 'C:\Users\Piotrullo\Documents\GitHub\Data_Warehouses\posters_T1.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Posters;
