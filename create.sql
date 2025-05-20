USE Shop
GO
-- Tabela: Customer account info
CREATE TABLE CustomerAccountInfo (
    Customer_Code INT PRIMARY KEY,
    Customer_Name NVARCHAR(50) COLLATE Polish_CI_AS,
    Surname NVARCHAR(55) COLLATE Polish_CI_AS,
    DateOfBirth DATE,
    IsSubscriber VARCHAR(6)
);

-- Tabela: Owned board games
CREATE TABLE OwnedBoardGames (
    Game_ID SMALLINT PRIMARY KEY,
    Game_Name NVARCHAR(50) COLLATE Polish_CI_AS,
	Category NVARCHAR(50) COLLATE Polish_CI_AS,
    Number_Of_Copies TINYINT,
    Rent_Price TINYINT
);

-- Tabela: Workers
CREATE TABLE Workers (
    Pesel VARCHAR(12) PRIMARY KEY,
    Worker_Name NVARCHAR(50) COLLATE Polish_CI_AS,
    Surname NVARCHAR(55) COLLATE Polish_CI_AS
);

-- Tabela: Tournaments
CREATE TABLE Tournaments (
    Tournament_ID INT PRIMARY KEY,
    Game_ID SMALLINT,
    Tournament_Date DATE,
    Price_Pool DECIMAL(6, 2),
    Entry_Price DECIMAL(5, 2),
    Responsible_Worker VARCHAR(12),
	Number_of_winners TINYINT,
    CONSTRAINT FK_Worker FOREIGN KEY (Responsible_Worker) REFERENCES Workers(Pesel),
    CONSTRAINT FK_Game FOREIGN KEY (Game_ID) REFERENCES OwnedBoardGames(Game_ID)
);

-- Tabela: Tournament participants
CREATE TABLE TournamentParticipants (
    Customer_ID INT,
    Tournament_ID INT,
    Placement INT,
    Price_Won DECIMAL(6, 2),
    PRIMARY KEY (Customer_ID, Tournament_ID),
    CONSTRAINT FK_TournamentParticipants_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES CustomerAccountInfo(Customer_Code),
    CONSTRAINT FK_Tournament_ID FOREIGN KEY (Tournament_ID) REFERENCES Tournaments(Tournament_ID)
);

-- Tabela: Rents
CREATE TABLE Rents (
    Rent_ID INT PRIMARY KEY,
    Customer_ID INT,
    Game_ID SMALLINT,
    Date_Of_Rent DATE,
    CONSTRAINT FK_Rents_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES CustomerAccountInfo(Customer_Code),
    CONSTRAINT FK_Game_ID FOREIGN KEY (Game_ID) REFERENCES OwnedBoardGames(Game_ID)
);

-- Tabela: Posters
CREATE TABLE Posters (
    Tournament_ID INT,
    City_District NVARCHAR(50) COLLATE Polish_CI_AS,
    Number_Of_Posters TINYINT,
    PRIMARY KEY (Tournament_ID, City_District),
    CONSTRAINT FK_Posters_Tournament_ID FOREIGN KEY (Tournament_ID) REFERENCES Tournaments(Tournament_ID)
);
