SELECT FROM 


/*#1. Write a query which returns the NPCs and their roles, there should be two columns. Write a query to return a “report” of all users and their roles */

SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id, roles.Role_Name, Roles.Role_Description FROM npcs LEFT JOIN roles ON npcs.Role_Id = roles.Role_Id;

SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id, roles.Role_Name, Roles.Role_Description FROM npcs LEFT JOIN roles ON npcs.Role_Id = roles.Role_Id GROUP BY roles.Role_Id; 

SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id, roles.Role_Name, Roles.Role_Description FROM npcs LEFT JOIN roles ON npcs.Role_Id = roles.Role_Id GROUP BY npcs.NPC_Id;

/*SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id, roles.Role_Name, Roles.Role_Description FROM npcs LEFT JOIN roles ON npcs.Role_Id = roles.Role_Id GROUP BY npcs.NPC_Id WHERE roles.Role_Id BETWEEN 2 AND 4; --If Only it worked.*/

SELECT npcs.First_Name, npcs.Last_Name, npcs.Role_Id, roles.Role_Name, Roles.Role_Description 
FROM npcs LEFT JOIN roles ON npcs.Role_Id = roles.Role_Id GROUP BY npcs.NPC_Id DESC;

/*Simply having a JOIN means any and all data from the table can be listed even if not specified directly. npcs.NPC_Id can be added just fine*/

/*#2. Write a query to return all classes and the count of guests that hold those classes. */

    SELECT * FROM Classes; 

    SELECT classes.Class_Id, classes.Class_Name, Guests.Guest_Name 
        FROM Classes LEFT JOIN Guests On Guests.Guest_Id = Classes.Class_Id;

        SELECT classes.Class_Id, classes.Class_Name, Guests.Guest_Name, Count(classes.Class_Id) 
            FROM Classes LEFT JOIN Guests On Guests.Guest_Id = Classes.Class_Id;

            SELECT GuestClasses.Guest_Id,classes.Class_Id, classes.Class_Name, Count(GuestClasses.Class_Id) 
                FROM GuestClasses RIGHT JOIN Classes On GuestClasses.Guest_Id = Classes.Class_Id Group By Class_Name HAVING COUNT(*) >= 1;

            SELECT classes.Class_Name, Count(GuestClasses.Class_Id) 
                FROM GuestClasses RIGHT JOIN Classes On GuestClasses.Guest_Id = Classes.Class_Id Group By Class_Name HAVING COUNT(*) >= 1;

/*#3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. 
Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes 
(Don’t alter the table for this) */

SELECT * FROM Guests ORDER BY Guest_Name ASC; /* ORDER BY alters the order in which items are returned. */

SELECT * FROM Guests GROUP BY Guest_Name ASC; /* GROUP BY will aggregate records by the specified columns 
                                                which allows you to perform aggregation functions  
                                                on non-grouped columns (such as SUM, COUNT, AVG, etc).*/
SELECT * FROM Guests GROUP BY Guest_Name;

SELECT Guests.Guest_Id, Guests.Guest_Name, GuestClasses.Class_Id, GuestClasses.Class_Level 
From Guestclasses LEFT JOIN Guests ON Guests.Guest_Id = GuestClasses.Guest_Id ORDER BY Guests.Guest_Name ASC;

SELECT Guests.Guest_Id, Guests.Guest_Name, GuestClasses.Class_Id, GuestClasses.Class_Level 
From GuestClasses LEFT JOIN Guests ON Guests.Guest_Id = GuestClasses.Guest_Id
ORDER BY Guests.Guest_Name ASC;

SELECT GuestClasses.Class_Level AS 'Beginner' FROM GuestClasses WHERE GuestClasses.Class_Level BETWEEN 1 AND 5;
SELECT GuestClasses.Class_Level AS 'Experienced' FROM GuestClasses WHERE GuestClasses.Class_Level BETWEEN 5 AND 10;
SELECT GuestClasses.Class_Level AS 'Expert' FROM GuestClasses WHERE GuestClasses.Class_Level BETWEEN 10 AND 99; /* I need a CASE/Conditional statement here.*/

SELECT Guests.Guest_Id, Guests.Guest_Name, GuestClasses.Class_Id, GuestClasses.Class_Level, CASE
    
    WHEN GuestClasses.Class_Level BETWEEN 1 AND 5 THEN 'Beginner'
    WHEN GuestClasses.Class_Level BETWEEN 5 AND 10 THEN 'Intermediate'
    WHEN GuestClasses.Class_Level BETWEEN 10 AND 99 THEN 'Expert'
    ELSE NULL
    END

From GuestClasses LEFT JOIN Guests ON Guests.Guest_Id = GuestClasses.Guest_Id
ORDER BY Guests.Guest_Name ASC;

/*SQL Server version, with column name. The one above would not take a name in MySQL.*/
SELECT Guests.Guest_Id, Guests.Guest_Name, GuestClasses.Class_Id, GuestClasses.Class_Level, CASE
    
    WHEN GuestClasses.Class_Level BETWEEN 1 AND 5 THEN 'Beginner'
    WHEN GuestClasses.Class_Level BETWEEN 5 AND 10 THEN 'Intermediate'
    WHEN GuestClasses.Class_Level BETWEEN 10 AND 99 THEN 'Expert'
    ELSE NULL
    END AS EXP_Level

From GuestClasses LEFT JOIN Guests ON Guests.Guest_Id = GuestClasses.Guest_Id
ORDER BY Guests.Guest_Name ASC;

/*#4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc) */

DROP FUNCTION dbo.LevelGroupings; 

CREATE FUNCTION dbo.LevelGroupings( @Levels INT )
    RETURNS 
        VARCHAR(250)
    AS 
    BEGIN 
        DECLARE @RESULT VARCHAR(250);
        
            IF @Levels <= 5 SET @RESULT = 'Beginner'
            IF @Levels >= 6 AND @Levels <= 10 SET @RESULT = 'Intermediate'
            Else 
                SET @RESULT = 'Expert' 
    RETURN @RESULT
    END;

SELECT Guest_Id, Class_Id, dbo.LevelGroupings(GuestClasses.Class_Level) AS EXP_Level FROM GuestClasses;

/* You cannot Group By as this isn't an aggregat function but if you wanted an Order By, it would work.*/
SELECT Guest_Id, Class_Id, dbo.LevelGroupings(GuestClasses.Class_Level) AS EXP_Level FROM GuestClasses ORDER BY Class_Id;

/*#5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to */
SELECT Rooms.Room_Id, Rooms.Tavern_Id, Rooms.Floor, Rooms.Room_Status FROM Rooms LEFT JOIN Taverns ON Rooms.Room_Id = Taverns.Tavern_Id WHERE Rooms.Room_Status = 'Vacant';

CREATE FUNCTION dbo.OpenRooms( @Date DATE )
    RETURNS 
        TABLE
    AS 
    RETURN(
        SELECT Rooms.Room_Id, Rooms.Tavern_Id, Rooms.Floor, Rooms.Room_Status FROM Rooms LEFT JOIN Taverns ON Rooms.Room_Id = Taverns.Tavern_Id WHERE Rooms.Date_Info FROM Rooms = @Date
    ); /*This didn't work, try something else. --Nested Queries, a query where multiple select statemnents exist.
    A subquery is a SELECT statement that is nested within another SELECT statement and which return intermediate results. SQL executes innermost subquery first, then next level.
    Whatever is in parenthesis will be executed first, and the order of operations for SQL code will still remain. 
    */ 
            /*SELECT employee.first_name, employee.last_name FROM employee WHERE employee.emp_id IN 
																			( SELECT works_with.emp_id FROM works_with WHERE works_with.total_sales > 30000 ); 
                                                                            
                                                        IN is a statement as previously used in order to get things contained within the parenthesis
														but here we can actually put another SELECT statement here, creating a nested query. */


    CREATE FUNCTION dbo.OpenRooms( @Date DATE )
    RETURNS 
        TABLE
    AS 
    RETURN(
        SELECT Rooms.Room_Id, Rooms.Tavern_Id, Rooms.Floor, Rooms.Room_Status FROM Rooms LEFT JOIN Taverns ON Rooms.Room_Id = Taverns.Tavern_Id IN
                                                                            ( SELECT Rooms.Date_Info FROM Rooms WHERE Rooms.Date_Info = @Date )/*One day the nested query will work*/
    );                                                                      

CREATE FUNCTION dbo.OpenRooms( @Date DATE )
    RETURNS 
        TABLE
    AS 
    RETURN(
        SELECT Rooms.Room_Id, Rooms.Tavern_Id, Rooms.Floor, Rooms.Room_Status, Rooms.Date_Info FROM Rooms LEFT JOIN Taverns ON Rooms.Room_Id = Taverns.Tavern_Id WHERE Rooms.Date_Info = @Date
    );  

SELECT * FROM dbo.OpenRooms('2019-01-28');

/*#6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs */
DROP FUNCTION dbo.PriceRange;

CREATE FUNCTION dbo.PriceRange( @LowPrice DEC, @HighPrice DEC )
    RETURNS 
        TABLE
    AS 
    RETURN( 
        SELECT Rooms.Room_Id, Rooms.Tavern_Id, Rooms.Room_Status, Rooms.Room_Rate FROM Rooms LEFT JOIN Taverns ON Rooms.Room_Id = Taverns.Tavern_Id   
        WHERE Rooms.Room_Rate BETWEEN @LowPrice AND @HighPrice
    );

SELECT * FROM dbo.PriceRange(40.00, 160.00); 
/*SELECT Rooms.Room_Rate, dbo.PriceRange(40.00, 160.00) AS Availabilities FROM Rooms WHERE Rooms.Room_Status = 'Vacant'; One day it will work.*/


/*#7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one*/

CREATE PROCEDURE dbo.CreateRoom( @RoomID INT, 
                                @TavernID INT, 
                                @RoomStatus VARCHAR(250), 
                                @RoomFloor INT, 
                                @RoomPrice DEC )
    AS
		DECLARE @CheapRoom DEC;
		SELECT @CheapRoom = Room_Rate 
		FROM 
		dbo.PriceRange(40.00, 160.00);
		IF (@CheapRoom >= 40)
		SET @CheapRoom = @RoomPrice - .01;
        INSERT INTO Rooms VALUES ( @RoomID, @TavernID, @RoomStatus, @RoomFloor, @RoomPrice ),
		(SELECT Room_Id FROM Rooms LEFT JOIN Taverns ON Rooms.Room_Id = Rooms.Tavern_Id),
		@CheapRoom IS NOT NULL;

EXEC dbo.CreateRoom( 6, 2, 'Vacant', 2, 40.00 ); --This didn't work, I tried reviewing the slides, I shall try again. 