-- 1. Count total rooms
SELECT COUNT(*) AS TotalRooms
FROM ROOMS;

-- 2. Average room price per night
SELECT AVG(NIGHTLY_RATY) AS AveragePrice
FROM ROOMS;

-- 3. Count rooms per hotel branch
SELECT B_ID, COUNT(*) AS RoomCount
FROM ROOMS
GROUP BY B_ID;

-- 4. Sum booking cost per customer
-- (Assuming BookingCost = DATEDIFF * NIGHTLY_RATY)
SELECT 
    C.C_ID,
    C.C_Name,
    SUM(DATEDIFF(DAY, B.Check_in, B.Check_out) * R.NIGHTLY_RATY) AS TotalBooking
FROM 
    BOOKING B
JOIN 
    CUSTOMER C ON B.C_ID = C.C_ID
JOIN 
    ROOMS R ON B.R_NUM = R.R_NUM
GROUP BY 
    C.C_ID, C.C_Name;

-- 5. Customers with total bookings > 5000
SELECT 
    C.C_ID,
    C.C_Name,
    SUM(DATEDIFF(DAY, B.Check_in, B.Check_out) * R.NIGHTLY_RATY) AS TotalBooking
FROM 
    BOOKING B
JOIN 
    CUSTOMER C ON B.C_ID = C.C_ID
JOIN 
    ROOMS R ON B.R_NUM = R.R_NUM
GROUP BY 
    C.C_ID, C.C_Name
HAVING 
    SUM(DATEDIFF(DAY, B.Check_in, B.Check_out) * R.NIGHTLY_RATY) > 5000;
