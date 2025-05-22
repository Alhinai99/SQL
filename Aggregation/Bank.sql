-- 1. Count the total number of customers
SELECT COUNT(*) AS TotalCustomers FROM Customer;
-- 2. Calculate the average account balance
SELECT AVG(Balance) AS AverageBalance FROM Account;
-- 3. Display how many accounts are opened in each branch
SELECT e.B_ID, COUNT(a.AccNUM) AS AccountCount
FROM Account a
JOIN Customer c ON a.C_ID = c.C_ID
JOIN Assist x ON c.C_ID = x.C_ID
JOIN Employee e ON x.E_ID = e.E_ID
GROUP BY e.B_ID;
-- 4. Show total loan amount per customer
SELECT C_ID, SUM(Amount) AS TotalLoan
FROM Loan
GROUP BY C_ID;
-- 5. List customers who have borrowed more than 200000 in total
SELECT C_ID, SUM(Amount) AS TotalLoan
FROM Loan
GROUP BY C_ID
HAVING SUM(Amount) > 200000;





