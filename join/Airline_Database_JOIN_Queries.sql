--1. Display each flight leg's ID, schedule, and the name of the airplane assigned to it. 
--2. Display all flight numbers and the names of the departure and arrival airports. 
--3. Display all reservation data with the name and phone of the customer who made each booking. 
--4. Display IDs and locations of flights departing from 'CAI' or 'DXB'. 
--5. Display full data of flights whose names start with 'A'. 
--6. List customers who have bookings with total payment between 3000 and 5000. 
--7. Retrieve all passengers on 'Flight 110' who booked more than 2 seats. 
--8. Find names of passengers whose booking was handled by agent "Youssef Hamed". 
--9. Display each passenger’s name and the flights they booked, ordered by flight date. 
--10.  For each flight departing from 'Cairo', display the flight number, departure time, and airline name. 
--11.  Display all staff members who are assigned as supervisors for flights. 
--12.  Display all bookings and their related passengers, even if some bookings are unpaid.

--==========1========
SELECT 
    FL.Leg_Num,
    FL.Scheduled_Dep_Time,
    FL.Scheduled_Arr_Time,
    AT.Type_Name AS Airplane_Type
FROM FLIGHT_LEG FL
JOIN ASSIGNMENT A ON FL.Leg_Num = A.Leg_Num
JOIN AIRPLANE AP ON A.Airplane_ID = AP.Airplane_ID
JOIN AIRPLANE_TYPE AT ON AP.ARTY_ID = AT.ARTY_ID;

--==========2========
SELECT 
    FL.Flight_Num,
    DA.Name AS Departure_Airport,
    AA.Name AS Arrival_Airport
FROM FLIGHT_LEG FL
JOIN AIRPORT DA ON FL.Dep_Airport = DA.Airport_Code
JOIN AIRPORT AA ON FL.Arr_Airport = AA.Airport_Code;

--==========3========
SELECT 
    R.Seat_Num,
    R.Fare_ID,
    C.Name,
    C.Phone
FROM RESERVATION R
JOIN SEAT S ON R.Seat_Num = S.Seat_Num
JOIN CUSTOMER C ON S.Customer_ID = C.Customer_ID;

--==========4========
SELECT 
    FL.Leg_Num,
    FL.Dep_Airport,
    A.City, A.State
FROM FLIGHT_LEG FL
JOIN AIRPORT A ON FL.Dep_Airport = A.Airport_Code
WHERE FL.Dep_Airport IN ('CAI', 'DXB');

--==========5========
SELECT * 
FROM FLIGHT 
WHERE Airline LIKE 'A%';

--==========6========
SELECT 
    C.Customer_ID,
    C.Name,
    SUM(F.Amount) AS Total_Payment
FROM CUSTOMER C
JOIN SEAT S ON C.Customer_ID = S.Customer_ID
JOIN RESERVATION R ON S.Seat_Num = R.Seat_Num
JOIN FARE F ON R.Fare_ID = F.Fare_ID
GROUP BY C.Customer_ID, C.Name
HAVING SUM(F.Amount) BETWEEN 3000 AND 5000;

--==========7========
SELECT 
    C.Customer_ID,
    C.Name,
    COUNT(*) AS Seats_Booked
FROM FLIGHT_LEG FL
JOIN LEG_INSTANCE LI ON FL.Leg_Num = LI.Leg_Num
JOIN ASSIGNMENT A ON FL.Leg_Num = A.Leg_Num
JOIN AIRPLANE AP ON A.Airplane_ID = AP.Airplane_ID
JOIN SEAT S ON S.Customer_ID = C.Customer_ID
JOIN CUSTOMER C ON C.Customer_ID = S.Customer_ID
JOIN RESERVATION R ON R.Seat_Num = S.Seat_Num
WHERE FL.Flight_Num = 110
GROUP BY C.Customer_ID, C.Name
HAVING COUNT(*) > 2;

--==========8========

SELECT DISTINCT C.Name
FROM RESERVATION R
JOIN SEAT S ON R.Seat_Num = S.Seat_Num
JOIN CUSTOMER C ON S.Customer_ID = C.Customer_ID
--WHERE R.Handled_By = 'Youssef Hamed';

--==========9========

SELECT 
    C.Name,
    F.Flight_Num,
    LI.Date
FROM CUSTOMER C
JOIN SEAT S ON C.Customer_ID = S.Customer_ID
JOIN RESERVATION R ON S.Seat_Num = R.Seat_Num
JOIN LEG_INSTANCE LI ON S.Seat_Num = LI.Leg_Num  -- Hypothetical
JOIN FLIGHT_LEG FL ON LI.Leg_Num = FL.Leg_Num
JOIN FLIGHT F ON FL.Flight_Num = F.Flight_Num
ORDER BY LI.Date;

--==========10========
SELECT 
    F.Flight_Num,
    FL.Scheduled_Dep_Time,
    F.Airline
FROM FLIGHT_LEG FL
JOIN FLIGHT F ON FL.Flight_Num = F.Flight_Num
JOIN AIRPORT A ON FL.Dep_Airport = A.Airport_Code
WHERE A.City = 'Cairo';

--==========11========


--==========12========
SELECT 
    R.Seat_Num,
    R.Fare_ID,
    C.Name
FROM RESERVATION R
LEFT JOIN SEAT S ON R.Seat_Num = S.Seat_Num
LEFT JOIN CUSTOMER C ON S.Customer_ID = C.Customer_ID;
