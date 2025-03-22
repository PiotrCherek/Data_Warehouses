
--CUSTOMER ACCOUNT INFO
BULK INSERT CustomerAccountInfo FROM 'C:\Users\User\Desktop\warehouse\customers.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
);
SELECT *FROM CustomerAccountInfo;

--OWNED BOARD GAMES 
BULK INSERT OwnedBoardGames FROM 'C:\Users\User\Desktop\warehouse\owned_board_games.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
);
--SELECT *FROM OwnedBoardGames;

-- WORKERS 
BULK INSERT Workers FROM 'C:\Users\User\Desktop\warehouse\workers.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
);
--SELECT *FROM Workers;

--TOURNAMENTS 
BULK INSERT Tournaments FROM 'C:\Users\User\Desktop\warehouse\tournaments.bulk'
WITH (
	FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
--SELECT *FROM Tournaments;

--TOURNAMENT PARTICIPANTS 
BULK INSERT TournamentParticipants FROM 'C:\Users\User\Desktop\warehouse\tournament_participants.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a' 
	);
--SELECT *FROM TournamentParticipants;

-- RENTS
BULK INSERT Rents FROM 'C:\Users\User\Desktop\warehouse\rents.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
--SELECT *FROM Rents;

--POSTERS 
BULK INSERT Posters FROM 'C:\Users\User\Desktop\warehouse\posters.bulk'
WITH (
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '0x0a' 
	);
--SELECT *FROM Posters;