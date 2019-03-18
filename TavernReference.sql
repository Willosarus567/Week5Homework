DROP TABLE IF EXISTS Taverns; 
DROP TABLE IF EXISTS Owners; 
DROP TABLE IF EXISTS NPCs; 
DROP TABLE IF EXISTS Roles; 
DROP TABLE IF EXISTS Cities; 
DROP TABLE IF EXISTS Supplies; 
DROP TABLE IF EXISTS Sales; 
DROP TABLE IF EXISTS Payments_Recieved; 
DROP TABLE IF EXISTS Services; 
DROP TABLE IF EXISTS ServiceStatuses; 
DROP TABLE IF EXISTS Guests; 
DROP TABLE IF EXISTS GuestStatuses; 
DROP TABLE IF EXISTS GuestClasses; 
DROP TABLE IF EXISTS Classes; 
DROP TABLE IF EXISTS Rooms; 
DROP TABLE IF EXISTS GuestRooms; 

CREATE DATABASE Roon_Skaep_Taverns; 

DROP TABLE IF Exists Taverns, Owners, NPCs, Roles, Cities, Supplies, Sales, Payments_Recieved, Services, 
                     ServiceStatuses, Guests, GuestStatuses, Classes, GuestClasses, Rooms, GuestRooms;

CREATE TABLE Taverns(
    Tavern_Id INT PRIMARY KEY,
    Tavern_Name varchar(250), 
    Owner_Id INT,
    Floors INT,
    Rooms INT,
    City_Id INT
    /*ALTER TABLE Taverns ADD FOREIGN KEY(Owner_Id) REFERENCES Owners(Owner_Id)
      ALTER TABLE Taverns ADD FOREIGN KEY(City_Id) REFERENCES Cities(City_Id)
      --ALTER TABLE Taverns ADD FOREIGN KEY(Service_Id) REFERENCES Services(Service_Id), Maybe in another design it should be added*/
);

SELECT * FROM Taverns; 

--Tavern Values
INSERT INTO Taverns(Tavern_Id, Tavern_Name, City_Id, Owner_Id, Floors, Rooms)

                VALUES(1, 'Jolly Boar Inn', 1, 1, 2, 7),
                      (2, 'Blue Moon Inn', 1, 1, 3, 9),
                      (3, 'Falador Party Room', 2, 2, 4, 14),
                      (4, 'Flying Horse Inn', 3, 3, 2, 7),
                      (5, 'The Pick and Lute', 4, 4, 2, 7);

CREATE TABLE Owners(
    Owner_Id INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50)
);

--Owner Values
INSERT INTO Owners(owner_id, first_name, last_name)

                VALUES(1, 'Varrock', 'Obama'),
                      (2, 'Osama.bin', 'Lumbridge'),
                      (3, 'Hagascan', 'Richards'),
                      (4, 'Malnisnid', 'Toad');

SELECT * FROM Owners;

CREATE TABLE NPCs(
    NPC_Id INT PRIMARY KEY,
    First_Name VARCHAR(250),
    Last_Name VARCHAR(250),
    birth_date DATE,
    gender VARCHAR(10) DEFAULT 'not listed',
    Role_Id INT,
    income DECIMAL DEFAULT 0,
    Tavern_Id INT,
    FOREIGN KEY(Tavern_Id) REFERENCES Taverns(Tavern_Id)
/*ALTER TABLE NPCs ADD FOREIGN KEY(Role_Id) REFERENCES Roles(Role_Id)-- Why didn't this work, it did in MySQL?*/    
);

--NPC Values
INSERT INTO NPCs(npc_id, first_name, last_name, birth_date, gender, role_id, income, tavern_id)

                VALUES(1, 'Jonathan', 'Cobbler', '1998-09-27', 'Male', 1, 2000.00, 1),
                      (2, 'Ameth', 'Grodgen', '1999-12-30', 'Female', 2, 2010.00, 1),
                      (3, 'Xiena', 'Bisk', '2000-11-14', 'Female', 3, 1991.00, 1),
                      (4, 'Zendar', 'Nami', '2001-10-18', 'Male', 4, 2100.00, 1),
                      (5, 'Thioh', 'Muay', '2002-09-30', 'Female', 5, 2100.00, 1),
                      (6, 'Pigral', 'Sursk', '1998-09-27', 'Male', 1, 2000.00, 2),
                      (7, 'Yerih', 'Rhamam', '1999-12-30', 'Female', 2, 2010.00, 2),
                      (8, 'Tihni', 'Naz', '2000-11-14', 'Female', 3, 1991.00, 2),
                      (9, 'Orerniz', 'Hurgundol', '2001-10-18', 'Male', 4, 2100.00, 2),
                      (10, 'Zorhe', 'Chestrun', '2002-09-30', 'Female', 5, 2100.00, 2),
                      (11, 'Gravef', 'Div', '1998-09-27', 'Male', 1, 2000.00, 3),
                      (12, 'Xia', 'Paom', '1999-12-30', 'Female', 2, 2010.00, 3),
                      (13, 'Bedv', 'Cirgeza', '2000-11-14', 'Female', 3, 1991.00, 3),
                      (14, 'Vloojarlat', 'Rhaegarlott', '2001-10-18', 'Male', 4, 2100.00, 3),
                      (15, 'Fohrol', 'Hakhad', '2002-09-30', 'Female', 5, 2100.00, 3),
                      (16, 'Gorlis', 'Grodzutra', '1998-09-27', 'Male', 1, 2000.00, 4),
                      (17, 'Sechuh', 'Starblower', '1999-12-30', 'Female', 2, 2010.00, 4),
                      (18, 'Shai', 'Shianong', '2000-11-14', 'Female', 3, 1991.00, 4),
                      (19, 'Medrum', 'Bhokhon', '2001-10-18', 'Male', 4, 2100.00, 4),
                      (20, 'Veirtm', 'Goganer', '2002-09-30', 'Female', 5, 2100.00, 4),
                      (21, 'Haldul', 'Caskwoods', '1998-09-27', 'Male', 1, 2000.00, 5),
                      (22, 'Tai', 'Na', '1999-12-30', 'Female', 2, 2010.00, 5),
                      (23, 'Sona', 'Marlblebinder', '2000-11-14', 'Female', 3, 1991.00, 5),
                      (24, 'Cheadral', 'Cestiscus', '2001-10-18', 'Male', 4, 2100.00, 5),
                      (25, 'Cisha', 'Clankeep', '2002-09-30', 'Female', 5, 2100.00, 5);

SELECT * FROM NPCs; 

CREATE TABLE Roles(
    Role_Id INT,
    Role_Name VARCHAR(50) DEFAULT 'tavern keeper',
    Role_Description VARCHAR(250) DEFAULT 'tends to the tavern.',
    PRIMARY KEY(Role_Id, Role_Name, Role_Description)

);

-- Roles Values
INSERT INTO Roles(Role_Id, Role_Name, Role_Description)

            VALUES(1, 'bartender', 'serves drinks, takes, orders, maintains premises'),
                  (2, 'cook', 'prepare food, learns receipts, delivers food') ,
                  (3, 'bard', 'sings songs, performs jokes, records history'),
                  (4, 'merchant', 'sells goods, brokers or provides services, acts as clearing house'),
                  (5, 'admin', 'logs room rentals, maintains premises, bookeeping, performs maintanence');

SELECT * FROM Roles; 


CREATE TABLE Cities(
    City_Id INT PRIMARY KEY,
    City_Name VARCHAR(40)
);

INSERT INTO Cities(City_Id, City_Name)

            VALUES(1, 'Varrock'),
                  (2, 'Falador'),
                  (3, 'East Ardougne'),
                  (4, 'Taverly');

SELECT * FROM Cities;

CREATE TABLE Supplies(
    Supply_Id INT PRIMARY KEY,
    Supply_Name VARCHAR(250),
    Date_Purchased DATE,
    Tavern_Id INT,
    Supply_Cost INT,
    FOREIGN KEY(Tavern_Id) References Taverns(Tavern_Id)
);

INSERT INTO Supplies(Supply_Id, Supply_Name, Date_Purchased, Tavern_Id, Supply_Cost)

            VALUES(1, 'Ale', '2002-11-09', 1, 460.00),
                  (2, 'Smithing Kit', '2002-12-04', 2, 300.00),
                  (3, 'Coal Ore', '2002-12-14', 3, 2000.00),
                  (4, 'Groceries', '2003-01-15', 4, 5000.00),
                  (5, 'Linens', '2003-02-01', 5, 200.00),
                  (6, 'Cleaning Wares', '2004-04-15', 1, 50.00),
                  (7, 'Leather', '2005-11-09', 1, 200.00),
                  (8, 'Runes', '2005-12-04', 1, 100.00),
                  (9, 'Hatchets', '2002-12-14', 1, 200.00),
                  (10, 'Groceries', '2006-01-15', 2, 5000.00),
                  (11, 'Linens', '2006-02-01', 2, 200.00);

SELECT * FROM Supplies; 

CREATE TABLE Guests(
    Guest_Id INT PRIMARY KEY,
    Guest_Name VARCHAR(250),
    Guest_Notes VARCHAR(250),
    Status_Name VARCHAR(20) DEFAULT 'Unknown.',
    Birthday DATE,
    CakeDay DATE,
    Status_Id INT
    /*ALTER TABLE Guests ADD FOREIGN KEY(Status_Id) REFERENCES GuestStatuses(Status_Id)*/
    
);

INSERT INTO Guests(Guest_Id, Guest_Name, Guest_Notes, Status_Name, Birthday, CakeDay, Status_Id)

            VALUES(1, 'Rahllkath', 'From a far away land', 'sick', '2005-01-22', '2006-01-01', 1),
                  (2, 'JusticeZero', 'From Lumbridge', 'fine', '2004-08-22', '2006-01-01', 2),
                  (3, 'Yimer', 'From Lumbridge', 'hangry', '2004-08-22', '2006-01-01', 3),
                  (4, 'Brunthorpe', 'From Tutorial Island', 'placid', '2004-08-22', '2006-01-01', 4),
                  (5, 'Dagnurgen', 'From Falador', 'hydrated', '2004-08-22', '2006-01-01', 5),
                  (6, 'Lardar', 'From a far away land', 'cool', '2004-08-22', '2006-01-01', 6),
                  (7, 'Golribul', 'From Falador', 'cool', '2005-08-22', '2006-01-01', 6),
                  (8, 'Zavigad', 'From Falador', 'hangry', '2005-08-22', '2006-01-01', 3),
                  (9, 'Bobronkun', 'From Falador', 'fine', '2005-09-22', '2006-01-01', 2),
                  (10, 'Lenuknil', 'From Taverly', 'hydrated', '2005-09-22', '2006-01-01', 5),
                  (11, 'Belnelban', 'From Taverly', 'hydrated', '2005-08-22', '2006-01-01', 5),
                  (12, 'Zavelbam', 'From Taverly', 'sick', '2004-08-22', '2006-01-01', 1),
                  (13, 'Shalralah', 'From Taverly', 'fine', '2006-08-22', '2006-01-01', 2),
                  (14, 'Alrohlel', 'From Taverly', 'hydrated', '2006-08-22', '2006-01-01', 5),
                  (15, 'Erictal', 'From Taverly', 'placid', '2006-09-22', '2006-01-01', 4),
                  (16, 'Zezima', 'From Tutorial Island', 'placid', '1999-09-22', '2006-01-01', 4),
                  (17, 'Helvomos', 'From Burthorpe', 'sick', '2006-09-22', '2006-01-01', 1),
                  (18, 'Zozzoshel', 'From Burthorpe', 'cool', '2008-08-22', '2006-01-01', 6),
                  (19, 'Elrorvah', 'From Burthorpe', 'sick', '2008-09-22', '2006-01-01', 1),
                  (20, 'Ovopil', 'From Burthorpe', 'hangry', '2008-09-22', '2006-01-01', 3),
                  (21, 'Shinalma', 'From Burthorpe', 'cool', '2008-08-22', '2006-01-01', 6),
                  (22, 'Manzarval', 'From Burthorpe', 'placid', '2008-08-22', '2006-01-01', 4),
                  (23, 'Virrasol', 'From Burthorpe', 'hangry', '2008-08-22', '2006-01-01', 3);

SELECT * FROM Guests;

CREATE TABLE Payments_Recieved(
    Payment_Recieved_Id INT PRIMARY KEY,
    Date_Recieved Date, 
    Amount_Recieved DECIMAL(18, 2),
    Service_Name VARCHAR(250),
    Service_Id INT,
    Tavern_id INT,
    Guest_Id INT,
    
    /*ALTER TABLE Payments_Recieved ADD FOREIGN KEY(Service_Id) REFERENCES Sales(Sale_Id)--ask why it didn't work*/
    FOREIGN KEY(Tavern_Id) REFERENCES Taverns(Tavern_Id),
    FOREIGN KEY(Guest_Id) REFERENCES Guests(Guest_Id)
);

INSERT INTO Payments_Recieved(Payment_Recieved_Id, Date_Recieved, Amount_Recieved, Service_Name, Service_Id, Tavern_Id, Guest_Id)

            VALUES(1, '2007-12-30', 20.00, 'Food & Beverage', 1, 1, 3),
                  (2, '2007-12-31', 10000.00, 'Equipment Smithing & Crafting', 2, 1, 16),
                  (3, '2008-01-21', 40.00, 'Room Rentals', 3, 1, 5),
                  (4, '2008-02-15', 160.00, 'Room Rentals', 3, 3, 21),
                  (5, '2008-03-10', 40.00, 'Room Rentals', 3, 1, 2),
                  (6, '2008-04-13', 90.00, 'Wares', 5, 1, 10),
                  (7, '2008-01-21', 110.00, 'Wares', 5, 1, 3),
                  (8, '2008-02-15', 5070.00, 'Equipment Smithing & Crafting', 2, 1, 16),
                  (9, '2008-03-10', 110.00, 'Room Rentals', 3, 3, 23),
                  (10, '2008-04-13', 110.00, 'Room Rentals', 3, 3, 18),
                  (11, '2008-01-21', 160.00, 'Room Rentals', 3, 3, 14),
                  (12, '2008-02-15', 390.00, 'Wares', 5, 1, 11),
                  (13, '2008-03-03', 40.00, 'Room Rentals', 3, 1, 23),
                  (14, '2008-04-13', 590.00, 'Wares', 2, 1, 10);

SELECT * FROM Payments_Recieved;

CREATE TABLE Sales(
    Sale_Id INT Primary KEY,
    Service_Id INT,
    Guest_Id INT,
    Price DECIMAL(18, 2),
    Sale_Date DATE,
    Sale_Amount DECIMAL(18, 2),
    Tavern_Id INT,
    FOREIGN KEY(Service_Id) REFERENCES Payments_Recieved(Payment_Recieved_Id)
    /*ALTER TABLE Sales ADD FOREIGN KEY(Sale_Amount) REFERENCES Payments_Recieved(Amount_Recieved)-ask why it didn't work 

                                                        -- Ask if there is a way to make 
                                                        a decimal a Primary Key or even
                                                        part of a composite key.*/
);

INSERT INTO Sales(Sale_Id, Service_Id, Guest_Id, Price, Sale_Date, Sale_Amount, Tavern_Id)

        VALUES(1, 1, 3, 20.00, '2007-12-30', 20.00, 1),
              (2, 5, 16, 12000.00, '2007-12-30', 10000.00, 1),
              (3, 3, 5, 40.00, '2008-01-21', 320.00, 1),
              (4, 3, 21, 160.00, '2008-02-15', 320.00, 3),
              (5, 3, 2, 40.00, '2008-03-10', 80.00, 1),
              (6, 5, 10, 90.00, '2008-04-13', 90.00, 1),
              (7, 5, 3, 110.00, '2007-12-30', 110.00, 1),
              (8, 5, 16, 5070.00, '2007-12-30', 5070.00, 1),
              (9, 3, 23, 110.00, '2008-01-21', 220.00, 3),
              (10, 3, 18, 110.00, '2008-02-15', 550.00, 3),
              (11, 3, 14, 160.00, '2008-03-10', 320.00, 3),
              (12, 5, 11, 390.00, '2008-04-13', 390.00, 1),
              (13, 5, 23, 2240.00, '2008-03-10', 2240.00, 1),
              (14, 5, 10, 590.00, '2008-04-13', 590.00, 1);

SELECT * FROM Sales; 

CREATE TABLE ServiceStatuses(
    Status_Id INT PRIMARY KEY,
    Service_Name VARCHAR(250),
    Status_Name VARCHAR(10)
);

INSERT INTO ServiceStatuses(Status_Id, Service_Name, Status_Name)

            VALUES(1, 'Rune Crafting', 'InActive'),
                  (2, 'Team Rostering', 'InActive'),
                  (3, 'Quick Travel', 'InActive'),
                  (4, 'Food & Beverage', 'Active'),
                  (5, 'Equipment Smithing & Crafting', 'Active'),
                  (6, 'Room Rentals', 'Active'),
                  (7, 'Quest/Job Board', 'Active'),
                  (8, 'Wares', 'Active');

SELECT * FROM ServiceStatuses; 

CREATE TABLE Services(
    Service_Id INT,
    Service_Name VARCHAR(250),
    Status_Id INT,
    Tavern_Id INT,
    PRIMARY KEY(Service_Id),
    FOREIGN KEY(Status_Id) REFERENCES ServiceStatuses(Status_Id)
);

INSERT INTO Services(Service_Id, Service_Name, Status_Id)

            VALUES(1, 'Food & Beverage', 4),
                  (2, 'Equipment Smithing & Crafting', 5),
                  (3, 'Room Rentals', 6),
                  (4, 'Quest/Job Board', 7),
                  (5, 'Wares', 8),
                  (6, 'Rune Crafting', 1),
                  (7, 'Team Rostering', 2),
                  (8, 'Quick Travel', 3);

SELECT * FROM Services; 

CREATE TABLE GuestStatuses(
    Status_Id INT,
    Status_Name VARCHAR(50),
    Guest_Id INT,
    PRIMARY KEY(Status_Id, Guest_Id)
);

INSERT INTO GuestStatuses(Status_Id, Status_Name, Guest_Id)

            VALUES(1, 'sick', 1),
                  (2, 'fine', 2),
                  (3, 'hangry', 3),
                  (4, 'placid', 4),
                  (5, 'hydrated', 5),
                  (6, 'cool', 6),
                  (6, 'cool', 7),
                  (3, 'hangry', 8),
                  (2, 'fine', 9),
                  (5, 'hydrated', 10),
                  (5, 'hydrated', 11),
                  (1, 'sick', 12),
                  (2, 'fine', 13),
                  (5, 'hydrated', 14),
                  (4, 'placid', 15),
                  (4, 'placid', 16),
                  (1, 'sick', 17),
                  (6, 'cool', 18),
                  (1, 'sick', 19),
                  (3, 'hangry', 20),
                  (6, 'cool', 21),
                  (4, 'placid', 22),
                  (3, 'hangry', 23);

SELECT * FROM GuestStatuses; 

CREATE TABLE Classes(
    Class_Id INT PRIMARY KEY,
    Class_Name VARCHAR(250)
);

INSERT INTO Classes(Class_Id, Class_Name)

        VALUES  (1, 'Attack'),
                (2, 'Health'),
                (3, 'Strength'),
                (4, 'Defense'),
                (5, 'Ranged'),
                (6, 'Prayer'),
                (7, 'Magic'),
                (8, 'RuneCrafting'),
                (9, 'Agility'),
                (10, 'Herbology'),
                (11, 'Thievery'),
                (12, 'Crafting'),
                (13, 'Fletching'),
                (14, 'Slaying'),
                (15, 'Mining'),
                (16, 'Smithing'),
                (17, 'Fishing'),
                (18, 'Cooking'),
                (19, 'FireMaking'),
                (20, 'Woodcutting'),
                (21, 'Farming');

SELECT * FROM Classes;

CREATE TABLE GuestClasses(
    Guest_Id INT,
    Class_Id INT,
    Class_Level INT,
    PRIMARY KEY(Guest_Id, Class_Id),
    FOREIGN KEY(Guest_Id) REFERENCES Guests(Guest_Id)

);

INSERT INTO GuestClasses(Guest_Id, Class_Id, Class_Level) 
        VALUES(1, 1, 20),
              (1, 2, 19),
              (1, 3, 30),
              (1, 4, 30),
              (1, 5, 20),
              (1, 6, 15),
              (1, 7, 2),
              (1, 8, 1),
              (1, 9, 15),
              (1, 10, 20),
              (1, 11, 1),
              (1, 12, 4),
              (1, 13, 3),
              (1, 14, 20),
              (1, 15, 3),
              (1, 16, 5),
              (1, 17, 5),
              (1, 18, 3),
              (1, 19, 6),
              (1, 20, 4),
              (1, 21, 1),
              (2, 1, 71),
              (2, 2, 70),
              (2, 3, 70),
              (2, 4, 70),
              (2, 5, 46),
              (2, 6, 52),
              (2, 7, 62),
              (2, 8, 51),
              (2, 9, 42),
              (2, 10, 43),
              (2, 11, 56),
              (2, 12, 37),
              (2, 13, 42),
              (2, 14, 60),
              (2, 15, 51),
              (2, 16, 65),
              (2, 17, 67),
              (2, 18, 50),
              (2, 19, 57),
              (2, 20, 57),
              (2, 21, 37),
              (3, 1, 62),
              (3, 2, 58),
              (3, 3, 60),
              (3, 4, 64),
              (3, 5, 50),
              (3, 6, 40),
              (3, 7, 36),
              (3, 8, 32),
              (3, 9, 40),
              (3, 10, 51),
              (3, 11, 43),
              (3, 12, 47),
              (3, 13, 51),
              (3, 14, 40),
              (3, 15, 70),
              (3, 16, 51),
              (3, 17, 53),
              (3, 18, 57),
              (3, 19, 60),
              (3, 20, 56),
              (3, 21, 34),
              (4, 1, 24),
              (4, 2, 30),
              (4, 3, 30),
              (4, 4, 30),
              (4, 5, 20),
              (4, 6, 15),
              (4, 7, 2),
              (4, 8, 1),
              (4, 9, 15),
              (4, 10, 20),
              (4, 11, 1),
              (4, 12, 13),
              (4, 13, 43),
              (4, 14, 48),
              (4, 15, 29),
              (4, 16, 49),
              (4, 17, 51),
              (4, 18, 33),
              (4, 19, 59),
              (4, 20, 50),
              (4, 21, 89),
              (5, 1, 2),
              (5, 2, 39),
              (5, 3, 32),
              (5, 4, 43),
              (5, 5, 50),
              (5, 6, 18),
              (5, 7, 21),
              (5, 8, 19),
              (5, 9, 15),
              (5, 10, 20),
              (5, 11, 19),
              (5, 12, 41),
              (5, 13, 32),
              (5, 14, 20),
              (5, 15, 39),
              (5, 16, 51),
              (5, 17, 51),
              (5, 18, 31),
              (5, 19, 61),
              (5, 20, 41),
              (5, 21, 19),
              (6, 1, 20),
              (6, 2, 19),
              (6, 3, 30),
              (6, 4, 30),
              (6, 5, 20),
              (6, 6, 15),
              (6, 7, 2),
              (6, 8, 1),
              (6, 9, 15),
              (6, 10, 20),
              (6, 11, 1),
              (6, 12, 4),
              (6, 13, 3),
              (6, 14, 20),
              (6, 15, 3),
              (6, 16, 5),
              (6, 17, 5),
              (6, 18, 3),
              (6, 19, 6),
              (6, 20, 4),
              (6, 21, 1),
              (7, 1, 20),
              (7, 2, 19),
              (7, 3, 30),
              (7, 4, 30),
              (7, 5, 20),
              (7, 6, 15),
              (7, 7, 2),
              (7, 8, 1),
              (7, 9, 15),
              (7, 10, 20),
              (7, 11, 1),
              (7, 12, 4),
              (7, 13, 3),
              (7, 14, 20),
              (7, 15, 3),
              (7, 16, 5),
              (7, 17, 5),
              (7, 18, 3),
              (7, 19, 6),
              (7, 20, 4),
              (7, 21, 1),
              (8, 1, 20),
              (8, 2, 19),
              (8, 3, 30),
              (8, 4, 30),
              (8, 5, 20),
              (8, 6, 15),
              (8, 7, 2),
              (8, 8, 1),
              (8, 9, 15),
              (8, 10, 20),
              (8, 11, 1),
              (8, 12, 4),
              (8, 13, 3),
              (8, 14, 20),
              (8, 15, 3),
              (8, 16, 5),
              (8, 17, 5),
              (8, 18, 3),
              (8, 19, 6),
              (8, 20, 4),
              (8, 21, 1),
              (9, 1, 12),
              (9, 2, 17),
              (9, 3, 38),
              (9, 4, 39),
              (9, 5, 20),
              (9, 6, 15),
              (9, 7, 12),
              (9, 8, 11),
              (9, 9, 15),
              (9, 10, 20),
              (9, 11, 11),
              (9, 12, 14),
              (9, 13, 13),
              (9, 14, 20),
              (9, 15, 13),
              (9, 16, 15),
              (9, 17, 15),
              (9, 18, 13),
              (9, 19, 16),
              (9, 20, 14),
              (9, 21, 11),
              (10, 1, 20),
              (10, 2, 19),
              (10, 3, 30),
              (10, 4, 30),
              (10, 5, 20),
              (10, 6, 15),
              (10, 7, 2),
              (10, 8, 1),
              (10, 9, 15),
              (10, 10, 20),
              (10, 11, 1),
              (10, 12, 4),
              (10, 13, 3),
              (10, 14, 20),
              (10, 15, 3),
              (10, 16, 5),
              (10, 17, 5),
              (10, 18, 3),
              (10, 19, 6),
              (10, 20, 4),
              (10, 21, 1),
              (11, 1, 20),
              (11, 2, 19),
              (11, 3, 30),
              (11, 4, 30),
              (11, 5, 20),
              (11, 6, 15),
              (11, 7, 2),
              (11, 8, 1),
              (11, 9, 15),
              (11, 10, 20),
              (11, 11, 1),
              (11, 12, 4),
              (11, 13, 3),
              (11, 14, 20),
              (11, 15, 3),
              (11, 16, 5),
              (11, 17, 5),
              (11, 18, 3),
              (11, 19, 6),
              (11, 20, 4),
              (11, 21, 1),
              (12, 1, 20),
              (12, 2, 19),
              (12, 3, 30),
              (12, 4, 30),
              (12, 5, 20),
              (12, 6, 15),
              (12, 7, 2),
              (12, 8, 1),
              (12, 9, 15),
              (12, 10, 20),
              (12, 11, 1),
              (12, 12, 4),
              (12, 13, 3),
              (12, 14, 20),
              (12, 15, 3),
              (12, 16, 5),
              (12, 17, 5),
              (12, 18, 3),
              (12, 19, 6),
              (12, 20, 4),
              (12, 21, 1),
              (13, 1, 20),
              (13, 2, 19),
              (13, 3, 30),
              (13, 4, 30),
              (13, 5, 20),
              (13, 6, 15),
              (13, 7, 2),
              (13, 8, 1),
              (13, 9, 15),
              (13, 10, 20),
              (13, 11, 1),
              (13, 12, 4),
              (13, 13, 3),
              (13, 14, 20),
              (13, 15, 3),
              (13, 16, 5),
              (13, 17, 5),
              (13, 18, 3),
              (13, 19, 6),
              (13, 20, 4),
              (13, 21, 1),
              (14, 1, 20),
              (14, 2, 19),
              (14, 3, 30),
              (14, 4, 30),
              (14, 5, 20),
              (14, 6, 15),
              (14, 7, 2),
              (14, 8, 1),
              (14, 9, 15),
              (14, 10, 20),
              (14, 11, 1),
              (14, 12, 4),
              (14, 13, 3),
              (14, 14, 20),
              (14, 15, 3),
              (14, 16, 5),
              (14, 17, 5),
              (14, 18, 3),
              (14, 19, 6),
              (14, 20, 4),
              (14, 21, 1),
              (15, 1, 20),
              (15, 2, 19),
              (15, 3, 30),
              (15, 4, 30),
              (15, 5, 20),
              (15, 6, 15),
              (15, 7, 2),
              (15, 8, 1),
              (15, 9, 15),
              (15, 10, 20),
              (15, 11, 1),
              (15, 12, 4),
              (15, 13, 3),
              (15, 14, 20),
              (15, 15, 3),
              (15, 16, 5),
              (15, 17, 5),
              (15, 18, 3),
              (15, 19, 6),
              (15, 20, 4),
              (15, 21, 1),
              (16, 1, 99),
              (16, 2, 99),
              (16, 3, 99),
              (16, 4, 99),
              (16, 5, 99),
              (16, 6, 99),
              (16, 7, 99),
              (16, 8, 99),
              (16, 9, 99),
              (16, 10, 99),
              (16, 11, 99),
              (16, 12, 99),
              (16, 13, 99),
              (16, 14, 99),
              (16, 15, 99),
              (16, 16, 99),
              (16, 17, 99),
              (16, 18, 99),
              (16, 19, 99),
              (16, 20, 99),
              (16, 21, 99),
              (17, 1, 25),
              (17, 2, 39),
              (17, 3, 31),
              (17, 4, 35),
              (17, 5, 21),
              (17, 6, 5),
              (17, 7, 21),
              (17, 8, 18),
              (17, 9, 15),
              (17, 10, 20),
              (17, 11, 13),
              (17, 12, 1),
              (17, 13, 1),
              (17, 14, 26),
              (17, 15, 13),
              (17, 16, 15),
              (17, 17, 54),
              (17, 18, 32),
              (17, 19, 61),
              (17, 20, 14),
              (17, 21, 11),
              (18, 1, 20),
              (18, 2, 19),
              (18, 3, 30),
              (18, 4, 30),
              (18, 5, 20),
              (18, 6, 15),
              (18, 7, 2),
              (18, 8, 1),
              (18, 9, 15),
              (18, 10, 20),
              (18, 11, 1),
              (18, 12, 4),
              (18, 13, 3),
              (18, 14, 20),
              (18, 15, 3),
              (18, 16, 5),
              (18, 17, 5),
              (18, 18, 3),
              (18, 19, 6),
              (18, 20, 4),
              (18, 21, 1),
              (19, 1, 20),
              (19, 2, 19),
              (19, 3, 30),
              (19, 4, 30),
              (19, 5, 20),
              (19, 6, 15),
              (19, 7, 2),
              (19, 8, 1),
              (19, 9, 15),
              (19, 10, 20),
              (19, 11, 1),
              (19, 12, 4),
              (19, 13, 3),
              (19, 14, 20),
              (19, 15, 3),
              (19, 16, 5),
              (19, 17, 5),
              (19, 18, 3),
              (19, 19, 6),
              (19, 20, 4),
              (19, 21, 1),
              (20, 1, 20),
              (20, 2, 19),
              (20, 3, 30),
              (20, 4, 30),
              (20, 5, 20),
              (20, 6, 15),
              (20, 7, 2),
              (20, 8, 1),
              (20, 9, 15),
              (20, 10, 20),
              (20, 11, 1),
              (20, 12, 4),
              (20, 13, 3),
              (20, 14, 20),
              (20, 15, 3),
              (20, 16, 5),
              (20, 17, 5),
              (20, 18, 3),
              (20, 19, 6),
              (20, 20, 4),
              (20, 21, 1),
              (21, 1, 20),
              (21, 2, 19),
              (21, 3, 30),
              (21, 4, 30),
              (21, 5, 20),
              (21, 6, 15),
              (21, 7, 2),
              (21, 8, 1),
              (21, 9, 15),
              (21, 10, 20),
              (21, 11, 1),
              (21, 12, 4),
              (21, 13, 3),
              (21, 14, 20),
              (21, 15, 3),
              (21, 16, 5),
              (21, 17, 5),
              (21, 18, 3),
              (21, 19, 6),
              (21, 20, 4),
              (21, 21, 1),
              (22, 1, 20),
              (22, 2, 19),
              (22, 3, 30),
              (22, 4, 30),
              (22, 5, 20),
              (22, 6, 15),
              (22, 7, 2),
              (22, 8, 1),
              (22, 9, 15),
              (22, 10, 20),
              (22, 11, 1),
              (22, 12, 4),
              (22, 13, 3),
              (22, 14, 20),
              (22, 15, 3),
              (22, 16, 5),
              (22, 17, 5),
              (22, 18, 3),
              (22, 19, 6),
              (22, 20, 4),
              (22, 21, 1),
              (23, 1, 21),
              (23, 2, 23),
              (23, 3, 3),
              (23, 4, 34),
              (23, 5, 2),
              (23, 6, 15),
              (23, 7, 23),
              (23, 8, 19),
              (23, 9, 5),
              (23, 10, 2),
              (23, 11, 1),
              (23, 12, 49),
              (23, 13, 31),
              (23, 14, 27),
              (23, 15, 19),
              (23, 16, 14),
              (23, 17, 38),
              (23, 18, 25),
              (23, 19, 40),
              (23, 20, 12),
              (23, 21, 6); 

SELECT * FROM GuestClasses;

CREATE TABLE Rooms(
    Room_Id INT,
    Tavern_Id INT,
    Room_Status VARCHAR(10),
    Floor INT,
    Date_Info DATE,
    Room_Rate DECIMAL,
    PRIMARY KEY(Room_Id, Tavern_Id, Floor)
    
);

INSERT INTO Rooms(Room_Id, Tavern_Id, Room_Status, Date_Info, Floor, Room_Rate)

        VALUES(1, 1, 'Occupied', '2008-01-21', 2, 40.00),
              (2, 1, 'Occupied', '2008-03-10', 2, 40.00),
              (1, 3, 'Occupied', '2008-02-15', 3, 160.00),
              (2, 3, 'Occupied', '2008-01-21', 2, 110.00),
              (3, 3, 'Occupied', '2008-02-15', 2, 110.00),
              (4, 3, 'Occupied', '2008-03-10', 3, 160.00),
              (3, 1, 'Vacant', '2019-01-28', 2, 40.00),
              (4, 1, 'Vacant', '2019-02-18', 2, 40.00),
              (5, 1, 'Vacant', '2019-03-08', 2, 40.00);

SELECT * FROM Rooms;

CREATE TABLE GuestRooms(
    Guest_Id INT,
    Date_Start DATE,
    Date_End DATE,  
    Sale_Id INT,
    Room_Id INT,
	Tavern_Id INT,
	Floor INT,
    PRIMARY KEY(Guest_Id, Sale_Id),
    FOREIGN KEY(Room_Id, Tavern_Id, Floor) REFERENCES Rooms(Room_Id, Tavern_Id, Floor)
);

INSERT INTO GuestRooms(Guest_Id, Date_Start, Date_End, Sale_Id, Room_Id, Tavern_Id, Floor)

        VALUES(5, '2008-01-21', '2008-01-29' , 3, 1, 1, 2),
              (2, '2008-03-10', '2008-03-12', 5, 2, 1, 2),
              (21, '2008-02-15', '2008-02-17', 4, 1, 3, 3),
              (23, '2008-01-21', '2008-01-23', 9, 2, 3, 2),
              (18, '2008-02-15', '2008-02-20', 10, 3, 3, 2),
              (14, '2008-03-10', '2008-03-12', 11, 4, 3, 3);

SELECT * FROM Taverns; 
SELECT * FROM Owners; 
SELECT * FROM NPCs; 
SELECT * FROM Roles; 
SELECT * FROM Cities; 
SELECT * FROM Supplies; 
SELECT * FROM Sales; 
SELECT * FROM Payments_Recieved; 
SELECT * FROM Services; 
SELECT * FROM ServiceStatuses; 
SELECT * FROM Guests; 
SELECT * FROM GuestStatuses; 
SELECT * FROM GuestClasses; 
SELECT * FROM Classes; 
SELECT * FROM Rooms; 
SELECT * FROM GuestRooms;  

 --Homework 4
/*#1. Query to return users with admin roles.*/

    SELECT npcs.Role_Id FROM npcs WHERE npcs.Role_Id = 5;
    SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id FROM npcs LEFT JOIN roles ON npcs.Role_Id = '5' AND roles.Role_Id = '5';
    SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id FROM npcs LEFT JOIN roles ON npcs.Role_Id = '5';
    SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id FROM npcs LEFT JOIN roles ON npcs.Role_Id = roles.Role_Id;
    SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id FROM npcs RIGHT JOIN roles ON npcs.Role_Id = 5 AND roles.Role_Id = 5;

/*#2. Query to return users with admin roles and information about their travern/what their role description is. */

    SELECT CONCAT(npcs.First_Name, ' ', npcs.Last_Name) AS 'npc name', roles.Role_Id, roles.Role_Name, roles.Role_Description FROM roles RIGHT JOIN npcs ON roles.Role_Id = 5 AND npcs.Role_Id = 5;
    SELECT CONCAT(npcs.First_Name, ' ', npcs.Last_Name) AS 'npc name', roles.Role_Id, roles.Role_Name, roles.Role_Description FROM roles LEFT JOIN npcs ON roles.Role_Id = 5 AND npcs.Role_Id = 5; 
    SELECT CONCAT(npcs.First_Name, ' ', npcs.Last_Name) AS 'npc name', roles.Role_Id, roles.Role_Name, roles.Role_Description FROM roles LEFT JOIN npcs ON roles.Role_Id = npcs.Role_Id WHERE roles.Role_Id >= 5; 

    SELECT CONCAT(npcs.First_Name, ' ', npcs.Last_Name) AS 'npc name' FROM npcs
    WHERE Role_Id >= 5 

/*#3. Query to return all guests ordered by name in ascending order with their class and corresponding level.*/

    SELECT Guests.Guest_Name, Guests.Guest_Id, Classes.Class_Name, GuestClasses.Class_Level FROM Guests INNER JOIN GuestClasses ON Guests.Guest_Id = GuestClasses.Guest_Id INNER JOIN Classes ON GuestClasses.Class_Id = Classes.Class_Id ORDER by Guests.Guest_Name ASC;

    SELECT Guests.Guest_Name FROM Guests ORDER by Guests.Guest_Name ASC; 

/*#4. Query that returns the top 10 sales, with price and service description.*/

    SELECT Top 10 sales.Price, services.Service_Name FROM sales LEFT JOIN services ON sales.Service_Id = services.Service_Id; 
    SELECT sales.Price, sales.Guest_Id, services.Service_Name FROM sales LEFT JOIN services ON sales.Service_Id = services.Service_Id; 

    SELECT sales.Price, services.Service_Name FROM sales RIGHT JOIN services ON sales.Service_Id = services.Service_Id LIMIT 10; 

/*#5. Query that returns guests with 2 or more classes. */

      SELECT GuestClasses.Guest_Id, COUNT(*) FROM GuestClasses GROUP BY Guest_Id;

        SELECT GuestClasses.Guest_Id, COUNT(*) FROM GuestClasses LEFT JOIN Guests ON GuestClasses.Guest_Id = Guests.Guest_Id GROUP BY GuestClasses.Guest_Id HAVING COUNT(*) >= 2;

        SELECT Guests.Guest_Name, GuestClasses.Guest_Id, COUNT(*) FROM GuestClasses LEFT JOIN Guests ON GuestClasses.Guest_Id = Guests.Guest_Id GROUP BY GuestClasses.Guest_Id HAVING COUNT(*) >= 2;

/*#6. Query that returns guests with 2 or more classes with levels higher than 5.*/

        SELECT Guests.Guest_Name, GuestClasses.Guest_Id, COUNT(*) FROM GuestClasses LEFT JOIN Guests ON GuestClasses.Guest_Id = Guests.Guest_Id WHERE GuestClasses.Class_Level >= 5 GROUP BY GuestClasses.Guest_Id HAVING COUNT(*) >= 2;

		SELECT GuestClasses.Guest_Id, COUNT(*) FROM GuestClasses LEFT JOIN Guests ON GuestClasses.Guest_Id = Guests.Guest_Id WHERE GuestClasses.Class_Level >= 5 GROUP BY GuestClasses.Guest_Id HAVING COUNT(*) >= 2;

/*#7. Query that returns guests with only their highest level class. */
        SELECT Guests.Guest_Name, Guests.Guest_Id, MAX(GuestClasses.Class_Level) FROM GuestClasses RIGHT JOIN Guests ON GuestClasses.Guest_Id = Guests.Guest_Id GROUP BY Guests.Guest_Id;

		SELECT Guests.Guest_Id, MAX(GuestClasses.Class_Level) FROM GuestClasses RIGHT JOIN Guests ON GuestClasses.Guest_Id = Guests.Guest_Id GROUP BY Guests.Guest_Id;

/*#8. Query that returns a guests stay in a room.*/ 
        SELECT GuestRooms.Guest_Id, GuestRooms.Date_Start, GuestRooms.Date_End FROM GuestRooms INNER JOIN Guests ON Guests.Guest_Id = GuestRooms.Guest_Id; 

        SELECT GuestRooms.Guest_Id, GuestRooms.Date_Start, GuestRooms.Date_End, DATEDIFF(day, GuestRooms.Date_Start, GuestRooms.Date_End) FROM GuestRooms INNER JOIN Guests ON Guests.Guest_Id = GuestRooms.Guest_Id; 
         SELECT GuestRooms.Guest_Id, GuestRooms.Date_Start, GuestRooms.Date_End, DATEDIFF(GuestRooms.Date_End, GuestRooms.Date_Start) AS 'Number of days' FROM GuestRooms INNER JOIN Guests ON Guests.Guest_Id = GuestRooms.Guest_Id; 

/*#9. Query that makes a returned table which shows a key constraint associated with the column name. */ 
        SELECT 
