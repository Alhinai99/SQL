--1. Display hotel ID, name, and the name of its manager. 
--2. Display hotel names and the rooms available under them. 
--3. Display guest data along with the bookings they made. 
--4. Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'. 
--5. Display all room records where room type starts with "S" (e.g., "Suite", "Single"). 
--6. List guests who booked rooms priced between 1500 and 2500 LE. 
--7. Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown". 
--8. Find guests whose bookings were handled by staff member "Mona Ali". 
--9. Display each guest’s name and the rooms they booked, ordered by room type. 
--10.  For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info. 
--11.  Display all staff members who hold 'Manager' positions. 
--12.  Display all guests and their reviews, even if some guests haven't submitted any reviews.

--============1============
SELECT B.B_ID, B.B_NAME, S.S_NAME AS Manager_Name
FROM BRANCH B
JOIN STAFF S ON B.B_ID = S.B_ID
WHERE S.Job_Title = 'Manager';

--============2============
SELECT B.B_NAME, R.R_NUM, R.R_Type
FROM BRANCH B
JOIN ROOMS R ON B.B_ID = R.B_ID;

--============3============
SELECT C.*, B.Booking_ID, B.Check_in, B.Check_out
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID;

--============4============
SELECT BKG.*
FROM BOOKING BKG
JOIN ROOMS R ON BKG.R_NUM = R.R_NUM
JOIN BRANCH BR ON R.B_ID = BR.B_ID
WHERE BR.B_Location LIKE '%Hurghada%' OR BR.B_Location LIKE '%Sharm El Sheikh%';

--============5============
SELECT * FROM ROOMS
WHERE R_Type LIKE 'S%';

--============6============
SELECT DISTINCT C.*
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID
JOIN ROOMS R ON B.R_NUM = R.R_NUM
WHERE R.NIGHTLY_RATY BETWEEN 1500 AND 2500;

--============7============
SELECT DISTINCT C.C_Name
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID
JOIN ROOMS R ON B.R_NUM = R.R_NUM
JOIN BRANCH BR ON R.B_ID = BR.B_ID
WHERE B.inAvailability = 'Y' AND BR.B_NAME = 'Hilton Downtown';

--============8============
--============9============
SELECT C.C_Name, R.R_NUM, R.R_Type
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID
JOIN ROOMS R ON B.R_NUM = R.R_NUM
ORDER BY R.R_Type;

--============10============
SELECT BR.B_ID, BR.B_NAME, ST.S_NAME AS Manager_Name
FROM BRANCH BR
JOIN STAFF ST ON BR.B_ID = ST.B_ID
WHERE BR.B_Location LIKE '%Cairo%' AND ST.Job_Title = 'Manager';

--============11============
SELECT * FROM STAFF
WHERE Job_Title = 'Manager';

--============12============
-- Example if REVIEWS table exists
--SELECT C.C_ID, C.C_Name, R.Review_Text
--FROM CUSTOMER C
--LEFT JOIN REVIEWS R ON C.C_ID = R.C_ID;

