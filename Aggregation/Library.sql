-- 1. Count the total number of books in the system
SELECT COUNT(*) AS TotalBooks FROM Books;
-- 2. Calculate the average price of all books
SELECT AVG(Price) AS AverageBookPrice FROM Books;
-- 3. Show the number of books available in each library
SELECT ID, COUNT(*) AS BookCount
FROM Books
GROUP BY ID;
-- 4. Count how many books were borrowed by each member
SELECT MemberID, COUNT(*) AS BorrowedBooks
FROM Loans
GROUP BY MemberID;
-- 5. List members who borrowed more than 3 books total
SELECT MemberID, COUNT(*) AS BorrowedBooks
FROM Loans
GROUP BY MemberID
HAVING COUNT(*) > 3;




