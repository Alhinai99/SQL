CREATE DATABASE AirlineSystem_DB;
USE AirlineSystem_DB;

-- AIRPORT
CREATE TABLE AIRPORT (
    Airport_Code CHAR(5) PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50)
);

-- AIRPLANE_TYPE
CREATE TABLE AIRPLANE_TYPE (
    ARTY_ID INT PRIMARY KEY,
    Type_Name VARCHAR(50),
    Company VARCHAR(50),
    Max_Seat INT
);

-- AIRPLANE
CREATE TABLE AIRPLANE (
    Airplane_ID INT PRIMARY KEY,
    Total_Seats INT,
    ARTY_ID INT
);

-- FLIGHT
CREATE TABLE FLIGHT (
    Flight_Num INT PRIMARY KEY,
    Airline VARCHAR(50),
    Week_Days VARCHAR(50),
    Restrictions TEXT
);

-- FLIGHT_LEG
CREATE TABLE FLIGHT_LEG (
    Leg_Num INT PRIMARY KEY,
    Flight_Num INT,
    Dep_Airport CHAR(5),
    Arr_Airport CHAR(5),
    Scheduled_Dep_Time TIME,
    Scheduled_Arr_Time TIME
);

-- LEG_INSTANCE
CREATE TABLE LEG_INSTANCE (
    Leg_Num INT,
    Date DATE,
    Dep_Time TIME,
    Arr_Time TIME,
    Available_Seats INT,
    PRIMARY KEY (Leg_Num, Date)
);

-- CUSTOMER
CREATE TABLE CUSTOMER (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15)
);

-- SEAT
CREATE TABLE SEAT (
    Seat_Num INT PRIMARY KEY,
    Customer_ID INT
);

-- FARE
CREATE TABLE FARE (
    Fare_ID INT PRIMARY KEY,
    Code VARCHAR(10),
    Amount DECIMAL(10,2)
);

-- RESERVATION
CREATE TABLE RESERVATION (
    Seat_Num INT,
    Fare_ID INT,
    PRIMARY KEY (Seat_Num, Fare_ID)
);

-- ASSIGNMENT
CREATE TABLE ASSIGNMENT (
    Airplane_ID INT,
    Leg_Num INT,
    PRIMARY KEY (Airplane_ID, Leg_Num)
);

-- AIRPLANE -> AIRPLANE_TYPE
ALTER TABLE AIRPLANE
ADD CONSTRAINT fk_airplane_type
FOREIGN KEY (ARTY_ID) REFERENCES AIRPLANE_TYPE(ARTY_ID);

-- FLIGHT_LEG -> FLIGHT
ALTER TABLE FLIGHT_LEG
ADD CONSTRAINT fk_flight_leg_flight
FOREIGN KEY (Flight_Num) REFERENCES FLIGHT(Flight_Num);

-- FLIGHT_LEG -> AIRPORT (Departure)
ALTER TABLE FLIGHT_LEG
ADD CONSTRAINT fk_flight_leg_dep_airport
FOREIGN KEY (Dep_Airport) REFERENCES AIRPORT(Airport_Code);

-- FLIGHT_LEG -> AIRPORT (Arrival)
ALTER TABLE FLIGHT_LEG
ADD CONSTRAINT fk_flight_leg_arr_airport
FOREIGN KEY (Arr_Airport) REFERENCES AIRPORT(Airport_Code);

-- LEG_INSTANCE -> FLIGHT_LEG
ALTER TABLE LEG_INSTANCE
ADD CONSTRAINT fk_leg_instance_leg
FOREIGN KEY (Leg_Num) REFERENCES FLIGHT_LEG(Leg_Num);

-- SEAT -> CUSTOMER
ALTER TABLE SEAT
ADD CONSTRAINT fk_seat_customer
FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID);

-- RESERVATION -> SEAT
ALTER TABLE RESERVATION
ADD CONSTRAINT fk_reservation_seat
FOREIGN KEY (Seat_Num) REFERENCES SEAT(Seat_Num);

-- RESERVATION -> FARE
ALTER TABLE RESERVATION
ADD CONSTRAINT fk_reservation_fare
FOREIGN KEY (Fare_ID) REFERENCES FARE(Fare_ID);

-- ASSIGNMENT -> AIRPLANE
ALTER TABLE ASSIGNMENT
ADD CONSTRAINT fk_assignment_airplane
FOREIGN KEY (Airplane_ID) REFERENCES AIRPLANE(Airplane_ID);

-- ASSIGNMENT -> FLIGHT_LEG
ALTER TABLE ASSIGNMENT
ADD CONSTRAINT fk_assignment_leg
FOREIGN KEY (Leg_Num) REFERENCES FLIGHT_LEG(Leg_Num);

INSERT INTO AIRPORT (Airport_Code, Name, City, State) VALUES
('ATL01', 'Hartsfield–Jackson', 'Atlanta', 'GA'),
('LAX01', 'Los Angeles Intl', 'Los Angeles', 'CA'),
('ORD01', 'O''Hare', 'Chicago', 'IL'),
('DFW01', 'Dallas/Fort Worth', 'Dallas', 'TX'),
('DEN01', 'Denver Intl', 'Denver', 'CO'),
('JFK01', 'John F. Kennedy', 'New York', 'NY'),
('SFO01', 'San Francisco Intl', 'San Francisco', 'CA'),
('SEA01', 'Seattle-Tacoma', 'Seattle', 'WA'),
('MIA01', 'Miami Intl', 'Miami', 'FL');

INSERT INTO AIRPLANE_TYPE (ARTY_ID, Type_Name, Company, Max_Seat) VALUES
(1, 'Boeing 737', 'Boeing', 189),
(2, 'Airbus A320', 'Airbus', 180),
(3, 'Boeing 777', 'Boeing', 396),
(4, 'Airbus A350', 'Airbus', 350),
(5, 'Embraer E190', 'Embraer', 114),
(6, 'Bombardier CRJ900', 'Bombardier', 90),
(7, 'Boeing 787', 'Boeing', 242),
(8, 'Airbus A330', 'Airbus', 277),
(9, 'MD-80', 'McDonnell Douglas', 155);

INSERT INTO AIRPLANE (Airplane_ID, Total_Seats, ARTY_ID) VALUES
(101, 189, 1),
(102, 180, 2),
(103, 396, 3),
(104, 350, 4),
(105, 114, 5),
(106, 90, 6),
(107, 242, 7),
(108, 277, 8),
(109, 155, 9);

INSERT INTO FLIGHT (Flight_Num, Airline, Week_Days, Restrictions) VALUES
(201, 'Delta', 'Mon,Wed,Fri', 'None'),
(202, 'American Airlines', 'Tue,Thu,Sat', 'Pets not allowed'),
(203, 'United', 'Daily', 'No infants'),
(204, 'Southwest', 'Mon-Fri', 'No checked bags'),
(205, 'Alaska Airlines', 'Sat,Sun', 'None'),
(206, 'JetBlue', 'Daily', 'Wheelchair access only'),
(207, 'Spirit', 'Mon,Wed,Fri', 'Carry-on only'),
(208, 'Frontier', 'Tue,Thu,Sat', 'No food service'),
(209, 'Hawaiian Airlines', 'Daily', 'Special ID required');

INSERT INTO FLIGHT_LEG (Leg_Num, Flight_Num, Dep_Airport, Arr_Airport, Scheduled_Dep_Time, Scheduled_Arr_Time) VALUES
(301, 201, 'ATL01', 'LAX01', '08:00', '11:00'),
(302, 202, 'LAX01', 'ORD01', '09:00', '13:00'),
(303, 203, 'ORD01', 'DFW01', '10:00', '12:00'),
(304, 204, 'DFW01', 'DEN01', '11:30', '13:30'),
(305, 205, 'DEN01', 'JFK01', '12:00', '16:00'),
(306, 206, 'JFK01', 'SFO01', '13:00', '18:00'),
(307, 207, 'SFO01', 'SEA01', '14:00', '16:00'),
(308, 208, 'SEA01', 'MIA01', '15:00', '21:00'),
(309, 209, 'MIA01', 'ATL01', '17:00', '20:00');

INSERT INTO LEG_INSTANCE (Leg_Num, Date, Dep_Time, Arr_Time, Available_Seats) VALUES
(301, '2025-06-01', '08:05', '11:10', 50),
(302, '2025-06-01', '09:10', '13:20', 60),
(303, '2025-06-01', '10:15', '12:10', 70),
(304, '2025-06-01', '11:35', '13:40', 55),
(305, '2025-06-01', '12:10', '16:05', 48),
(306, '2025-06-01', '13:05', '18:15', 62),
(307, '2025-06-01', '14:10', '16:20', 58),
(308, '2025-06-01', '15:10', '21:10', 67),
(309, '2025-06-01', '17:15', '20:15', 45);

INSERT INTO CUSTOMER (Customer_ID, Name, Phone) VALUES
(1, 'Alice Johnson', '5551234'),
(2, 'Bob Smith', '5555678'),
(3, 'Carol Lee', '5558765'),
(4, 'David Kim', '5554321'),
(5, 'Eva Wang', '5552468'),
(6, 'Frank Lopez', '5551357'),
(7, 'Grace Miller', '5559753'),
(8, 'Henry Nguyen', '5558642'),
(9, 'Isla Patel', '5551472');

INSERT INTO SEAT (Seat_Num, Customer_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9);

INSERT INTO FARE (Fare_ID, Code, Amount) VALUES
(1, 'ECON', 199.99),
(2, 'BUS', 499.99),
(3, 'FIRST', 999.99),
(4, 'ECON2', 149.99),
(5, 'BUS2', 399.99),
(6, 'FIRST2', 799.99),
(7, 'ECON3', 129.99),
(8, 'BUS3', 350.00),
(9, 'FIRST3', 850.00);

INSERT INTO RESERVATION (Seat_Num, Fare_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9);

INSERT INTO ASSIGNMENT (Airplane_ID, Leg_Num) VALUES
(101, 301),
(102, 302),
(103, 303),
(104, 304),
(105, 305),
(106, 306),
(107, 307),
(108, 308),
(109, 309);

-- AIRPORT
SELECT * FROM AIRPORT;

-- AIRPLANE_TYPE
SELECT * FROM AIRPLANE_TYPE;

-- AIRPLANE
SELECT * FROM AIRPLANE;

-- FLIGHT
SELECT * FROM FLIGHT;

-- FLIGHT_LEG
SELECT * FROM FLIGHT_LEG;

-- LEG_INSTANCE
SELECT * FROM LEG_INSTANCE;

-- CUSTOMER
SELECT * FROM CUSTOMER;

-- SEAT
SELECT * FROM SEAT;

-- FARE
SELECT * FROM FARE;

-- RESERVATION
SELECT * FROM RESERVATION;

-- ASSIGNMENT
SELECT * FROM ASSIGNMENT;

