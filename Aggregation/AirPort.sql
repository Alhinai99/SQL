-- 1. Count total flights
SELECT COUNT(*) AS TotalFlights
FROM FLIGHT;

-- 2. Average available seats per leg
SELECT 
    Leg_Num, 
    AVG(Available_Seats) AS AvgSeats
FROM 
    LEG_INSTANCE
GROUP BY 
    Leg_Num;

-- 3. Count flights per airline
SELECT 
    Airline, 
    COUNT(*) AS FlightCount
FROM 
    FLIGHT
GROUP BY 
    Airline;

-- 4. Estimated total payments per flight (total number of reservations * average fare amount)
SELECT 
    f.Flight_Num,
    COUNT(r.Seat_Num) * AVG(fa.Amount) AS EstimatedTotal
FROM 
    FLIGHT f
JOIN 
    FLIGHT_LEG fl ON f.Flight_Num = fl.Flight_Num
JOIN 
    ASSIGNMENT a ON fl.Leg_Num = a.Leg_Num
JOIN 
    SEAT s ON s.Seat_Num IS NOT NULL
JOIN 
    RESERVATION r ON r.Seat_Num = s.Seat_Num
JOIN 
    FARE fa ON fa.Fare_ID = r.Fare_ID
GROUP BY 
    f.Flight_Num;

-- 5. Flights with estimated payments > 10000
SELECT 
    f.Flight_Num,
    COUNT(r.Seat_Num) * AVG(fa.Amount) AS EstimatedTotal
FROM 
    FLIGHT f
JOIN 
    FLIGHT_LEG fl ON f.Flight_Num = fl.Flight_Num
JOIN 
    ASSIGNMENT a ON fl.Leg_Num = a.Leg_Num
JOIN 
    SEAT s ON s.Seat_Num IS NOT NULL
JOIN 
    RESERVATION r ON r.Seat_Num = s.Seat_Num
JOIN 
    FARE fa ON fa.Fare_ID = r.Fare_ID
GROUP BY 
    f.Flight_Num
HAVING 
    COUNT(r.Seat_Num) * AVG(fa.Amount) > 10000;
