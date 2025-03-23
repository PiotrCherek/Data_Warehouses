
--CUSTOMER ACCOUNT INFO
BULK INSERT CustomerAccountInfo FROM 'C:\Users\ksawery1\Desktop\datawarehouse_project\customers_T2.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
);
SELECT *FROM CustomerAccountInfo;

--OWNED BOARD GAMES 
BULK INSERT OwnedBoardGames FROM 'C:\Users\ksawery1\Desktop\datawarehouse_project\owned_board_games.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
);
SELECT *FROM OwnedBoardGames;

--WORKERS

BULK INSERT Workers
FROM 'C:\Users\ksawery1\Desktop\datawarehouse_project\workers_T2.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);
SELECT *FROM Workers;

--TOURNAMENTS 
BULK INSERT Tournaments FROM 'C:\Users\ksawery1\Desktop\datawarehouse_project\tournaments_T2.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Tournaments;

--TOURNAMENT PARTICIPANTS 
BULK INSERT TournamentParticipants FROM 'C:\Users\ksawery1\Desktop\datawarehouse_project\tournament_participants_T2.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM TournamentParticipants;

-- RENTS
BULK INSERT Rents FROM 'C:\Users\ksawery1\Desktop\datawarehouse_project\rents_T2.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Rents;

--POSTERS 
BULK INSERT Posters FROM 'C:\Users\ksawery1\Desktop\datawarehouse_project\posters_T2.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
SELECT *FROM Posters;
