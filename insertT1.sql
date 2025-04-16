USE Shop
GO 
---------------------------
-- CUSTOMER_ACCOUNT_INFO --
---------------------------
IF OBJECT_ID('TempCustomerAccountInfo') IS NOT NULL
    DROP TABLE TempCustomerAccountInfo;

CREATE TABLE TempCustomerAccountInfo (
    Customer_Code INT PRIMARY KEY,
    Customer_Name NVARCHAR(50) COLLATE Polish_CI_AS,
    Surname VARCHAR(50) COLLATE Polish_CI_AS,
    DateOfBirth DATE,
    IsSubscriber VARCHAR(6)
);

BULK INSERT TempCustomerAccountInfo
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\customers_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);

INSERT INTO CustomerAccountInfo (Customer_Code, Customer_Name, Surname, DateOfBirth, IsSubscriber)
SELECT TCAI.Customer_Code, TCAI.Customer_Name, TCAI.Surname, TCAI.DateOfBirth, TCAI.IsSubscriber
FROM TempCustomerAccountInfo TCAI
LEFT JOIN CustomerAccountInfo CAI ON TCAI.Customer_Code = CAI.Customer_Code
WHERE CAI.Customer_Code IS NULL;

SELECT * FROM CustomerAccountInfo;

DROP TABLE TempCustomerAccountInfo;
GO

-----------------------
-- OWNED_BOARD_GAMES --
-----------------------

IF OBJECT_ID('TempOwnedBoardGames') IS NOT NULL
    DROP TABLE TempOwnedBoardGames;

CREATE TABLE TempOwnedBoardGames (
    Game_ID SMALLINT PRIMARY KEY,
    Game_Name NVARCHAR(50) COLLATE Polish_CI_AS,
	Category NVARCHAR(50) COLLATE Polish_CI_AS,
    Number_Of_Copies TINYINT,
    Rent_Price TINYINT
);

BULK INSERT TempOwnedBoardGames
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\owned_board_games_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);

INSERT INTO OwnedBoardGames (Game_ID, Game_Name, Category, Number_Of_Copies, Rent_Price)
SELECT TOBD.Game_ID, TOBD.Game_Name, TOBD.Category, TOBD.Number_Of_Copies, TOBD.Rent_Price
FROM TempOwnedBoardGames TOBD
LEFT JOIN OwnedBoardGames OBG ON TOBD.Game_ID = OBG.Game_ID
WHERE OBG.Game_ID IS NULL;

SELECT * FROM OwnedBoardGames;

DROP TABLE TempOwnedBoardGames;
GO

-------------------
-- WORKERS --
-------------------

IF OBJECT_ID('TempWorkers') IS NOT NULL
    DROP TABLE TempWorkers;

CREATE TABLE TempWorkers (
      Pesel VARCHAR(12) PRIMARY KEY,
    Worker_Name NVARCHAR(50) COLLATE Polish_CI_AS,
    Surname NVARCHAR(55) COLLATE Polish_CI_AS
);

BULK INSERT TempWorkers
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\workers_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);

INSERT INTO Workers (Pesel, Worker_Name, Surname)
SELECT TW.Pesel, TW.Worker_Name, TW.Surname
FROM TempWorkers TW
LEFT JOIN Workers W ON TW.Pesel = W.Pesel
WHERE W.Pesel IS NULL;

SELECT * FROM Workers;

DROP TABLE TempWorkers;
GO

-------------------
-- TOURNAMENTS --
-------------------

IF OBJECT_ID('TempTournaments') IS NOT NULL
    DROP TABLE TempTournaments;

CREATE TABLE TempTournaments (
    Tournament_ID SMALLINT PRIMARY KEY,
    Game_ID SMALLINT,
    Tournament_Date DATE,
    Price_Pool DECIMAL(6, 2),
    Entry_Price DECIMAL(5, 2),
    Responsible_Worker VARCHAR(12),
    Number_of_winners TINYINT,
    CONSTRAINT FK_Worker_Temp FOREIGN KEY (Responsible_Worker) REFERENCES Workers(Pesel),
    CONSTRAINT FK_Game_Temp FOREIGN KEY (Game_ID) REFERENCES OwnedBoardGames(Game_ID) 
);

BULK INSERT TempTournaments
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\tournaments_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);

INSERT INTO Tournaments (Tournament_ID, Game_ID, Tournament_Date, Price_Pool, Entry_Price, Responsible_Worker, Number_of_winners)
SELECT TT.Tournament_ID, TT.Game_ID, TT.Tournament_Date, TT.Price_Pool, TT.Entry_Price, TT.Responsible_Worker, TT.Number_of_winners
FROM TempTournaments TT
LEFT JOIN Tournaments T ON TT.Tournament_ID = T.Tournament_ID
WHERE T.Tournament_ID IS NULL;

SELECT * FROM Tournaments;

DROP TABLE TempTournaments;
GO
-----------
-- RENTS --
-----------

IF OBJECT_ID('TempRents') IS NOT NULL
    DROP TABLE TempRents;

CREATE TABLE TempRents (
	Rent_ID INT PRIMARY KEY,
    Customer_ID INT,
    Game_ID SMALLINT,
    Date_Of_Rent DATE,
    CONSTRAINT FK_Rents_Temp_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES CustomerAccountInfo(Customer_Code),
    CONSTRAINT FK_Game_ID_Temp FOREIGN KEY (Game_ID) REFERENCES OwnedBoardGames(Game_ID)
);

BULK INSERT TempRents
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\rents_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);

INSERT INTO Rents (Rent_ID, Customer_ID, Game_ID, Date_Of_Rent)
SELECT TR.Rent_ID, TR.Customer_ID, TR.Game_ID, TR.Date_Of_Rent
FROM TempRents TR
LEFT JOIN Rents R ON TR.Rent_ID = R.Rent_ID
WHERE R.Rent_ID IS NULL;

SELECT * FROM Rents;

DROP TABLE TempRents;
GO

-----------------------------
-- TOURNAMENT PARTICIPANTS --
-----------------------------

IF OBJECT_ID('TempTournamentParticipants') IS NOT NULL
    DROP TABLE TempTournamentParticipants;

CREATE TABLE TempTournamentParticipants (
   Customer_ID INT,
    Tournament_ID SMALLINT,
    Placement INT,
    Price_Won DECIMAL(6, 2),
    PRIMARY KEY (Customer_ID, Tournament_ID),
    CONSTRAINT FK_TournamentParticipants_Customer_ID_Temp FOREIGN KEY (Customer_ID) REFERENCES CustomerAccountInfo(Customer_Code),
    CONSTRAINT FK_Tournament_ID_Temp FOREIGN KEY (Tournament_ID) REFERENCES Tournaments(Tournament_ID)
);

BULK INSERT TempTournamentParticipants
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\tournament_participants_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);

INSERT INTO TournamentParticipants (Customer_ID, Tournament_ID, Placement, Price_Won)
SELECT TTP.Customer_ID, TTP.Tournament_ID, TTP.Placement, TTP.Price_Won
FROM TempTournamentParticipants TTP
LEFT JOIN TournamentParticipants TP ON TTP.Customer_ID = TP.Customer_ID AND TTP.Tournament_ID = TP.Tournament_ID
WHERE TP.Customer_ID IS NULL AND TP.Tournament_ID IS NULL;

SELECT * FROM TournamentParticipants;

DROP TABLE TempTournamentParticipants;
GO


-------------
-- POSTERS --
-------------

IF OBJECT_ID('TempPosters') IS NOT NULL
    DROP TABLE TempPosters;

CREATE TABLE TempPosters (
    Tournament_ID SMALLINT,
    City_District NVARCHAR(50) COLLATE Polish_CI_AS,
    Number_Of_Posters TINYINT,
    PRIMARY KEY (Tournament_ID, City_District),
    CONSTRAINT FK_Posters_Tournament_ID_Temp FOREIGN KEY (Tournament_ID) REFERENCES Tournaments(Tournament_ID)
);

BULK INSERT TempPosters
FROM 'C:\Users\Piotrek\Documents\GitHub\Data_Warehouses\posters_T1.bulk'
WITH (
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a'
);

INSERT INTO Posters (Tournament_ID, City_District, Number_Of_Posters)
SELECT TP.Tournament_ID, TP.City_District, TP.Number_Of_Posters
FROM TempPosters TP
LEFT JOIN Posters P ON TP.Tournament_ID = P.Tournament_ID AND TP.City_District = P.City_District
WHERE P.Tournament_ID IS NULL AND P.City_District IS NULL;

SELECT * FROM Posters;

DROP TABLE TempPosters;
GO