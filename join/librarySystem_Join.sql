--1. Display library ID, name, and the name of the manager. 
--2. Display library names and the books available in each one. 
--3. Display all member data along with their loan history. 
--4. Display all books located in 'Zamalek' or 'Downtown'. 
--5. Display all books whose titles start with 'T'. 
--6. List members who borrowed books priced between 100 and 300 LE. 
--7. Retrieve members who borrowed and returned books titled 'The Alchemist'. 
--8. Find all members assisted by librarian "Sarah Fathy". 
--9. Display each member’s name and the books they borrowed, ordered by book title. 
--10.  For each book located in 'Cairo Branch', show title, library name, manager, and shelf info. 
--11.  Display all staff members who manage libraries. 
--12.  Display all members and their reviews, even if some didn’t submit any review yet. 

--=========1=========
SELECT 
    l.ID AS LibraryID,
    l.Name AS LibraryName,
    s.FullName AS ManagerName
FROM 
    Library l
JOIN 
    Staff s ON l.ID = s.LibraryID
WHERE 
    s.Position = 'Manager';

--=========2=========
-- Assuming Books table has LibraryID
SELECT 
    l.Name AS LibraryName,
    b.Title AS BookTitle
FROM 
    Books b
JOIN 
    Library l ON b.LibraryID = l.ID
WHERE 
    b.Availability = 1;

--=========3=========
SELECT 
    m.*,
    l.ID AS LoanID,
    l.BookID,
    l.LoanDate,
    l.DueDate,
    l.ReturnDate,
    l.Status
FROM 
    Members m
LEFT JOIN 
    Loans l ON m.ID = l.MemberID;

--=========4=========
-- Assuming Books.LibraryID exists
SELECT 
    b.*
FROM 
    Books b
JOIN 
    Library l ON b.LibraryID = l.ID
WHERE 
    l.Name LIKE '%Zamalek%' OR l.Name LIKE '%Downtown%';

--=========5=========
SELECT * FROM Books WHERE Title LIKE 'T%';

--=========6=========
SELECT DISTINCT 
    m.*
FROM 
    Members m
JOIN 
    Loans l ON m.ID = l.MemberID
JOIN 
    Books b ON l.BookID = b.ID
WHERE 
    b.Price BETWEEN 100 AND 300;

--=========7=========
SELECT DISTINCT 
    m.*
FROM 
    Members m
JOIN 
    Loans l ON m.ID = l.MemberID
JOIN 
    Books b ON l.BookID = b.ID
WHERE 
    b.Title = 'The Alchemist' AND l.Status = 'Returned';

--=========8=========
-- Assuming Loans table includes StaffID (LibrarianID)
SELECT DISTINCT 
    m.*
FROM 
    Members m
JOIN 
    Loans l ON m.ID = l.MemberID
JOIN 
    Staff s ON l.StaffID = s.ID
WHERE 
    s.FullName = 'Sarah Fathy';

--=========9=========
SELECT 
    m.FullName AS MemberName,
    b.Title AS BookTitle
FROM 
    Members m
JOIN 
    Loans l ON m.ID = l.MemberID
JOIN 
    Books b ON l.BookID = b.ID
ORDER BY 
    b.Title;

--=========10=========
SELECT 
    b.Title,
    l.Name AS LibraryName,
    s.FullName AS ManagerName,
    b.ShelfLoc
FROM 
    Books b
JOIN 
    Library l ON b.LibraryID = l.ID
JOIN 
    Staff s ON l.ID = s.LibraryID
WHERE 
    l.Name LIKE '%Cairo Branch%' AND s.Position = 'Manager';

--=========11=========
SELECT * FROM Staff WHERE Position = 'Manager';

--=========12=========
SELECT 
    m.FullName AS MemberName,
    r.Rating,
    r.Comments,
    r.ReviewDate
FROM 
    Members m
LEFT JOIN 
    Reviews r ON m.ID = r.MemberID;

