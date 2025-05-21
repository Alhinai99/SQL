--1. Display branch ID, name, and the name of the employee who manages it. 
--2. Display branch names and the accounts opened under each. 
--3. Display full customer details along with their loans. 
--4. Display loan records where the loan office is in 'Alexandria' or 'Giza'. 
--5. Display account data where the type starts with "S" (e.g., "Savings"). 
--6. List customers with accounts having balances between 20,000 and 50,000. 
--7. Retrieve customer names who borrowed more than 100,000 LE from 'Cairo Main Branch'. 
--8. Find all customers assisted by employee "Amira Khaled". 
--9. Display each customer’s name and the accounts they hold, sorted by account type. 
--10.  For each loan issued in Cairo, show loan ID, customer name, employee handling it, and branch name. 
--11.  Display all employees who manage any branch. 
--12.  Display all customers and their transactions, even if some customers have no transactions yet.

--=============1==========
SELECT 
    B.B_ID, 
    B.B_Address AS Branch_Name, 
    E.E_Name AS Manager_Name
FROM Branch B
JOIN Employee E ON B.B_ID = E.B_ID
WHERE E.Position = 'Branch Manager';


--=============2==========
SELECT 
    B.B_Address AS Branch_Name, 
    A.AccNUM
FROM Branch B
JOIN Employee E ON B.B_ID = E.B_ID
JOIN Assist ASST ON E.E_ID = ASST.E_ID
JOIN Account A ON ASST.C_ID = A.C_ID;

--=============3==========
SELECT 
    C.*, 
    L.L_ID, L.L_Type, L.Amount, L.Issue_Date
FROM Customer C
LEFT JOIN Loan L ON C.C_ID = L.C_ID;

--=============4==========
SELECT 
    L.*
FROM Loan L
JOIN Handle H ON L.L_ID = H.L_ID
JOIN Employee E ON H.E_ID = E.E_ID
JOIN Branch B ON E.B_ID = B.B_ID
WHERE B.B_Address LIKE '%Alexandria%' OR B.B_Address LIKE '%Giza%';

--=============5==========
SELECT * 
FROM Account
WHERE A_Type LIKE 'S%';

--=============6==========
SELECT DISTINCT C.*
FROM Customer C
JOIN Account A ON C.C_ID = A.C_ID
WHERE A.Balance BETWEEN 20000 AND 50000;

--=============7==========
SELECT C.C_Name
FROM Customer C
JOIN Loan L ON C.C_ID = L.C_ID
JOIN Handle H ON L.L_ID = H.L_ID
JOIN Employee E ON H.E_ID = E.E_ID
JOIN Branch B ON E.B_ID = B.B_ID
WHERE B.B_Address = 'Cairo Main Branch' AND L.Amount > 100000;

--=============8==========
SELECT C.*
FROM Assist A
JOIN Employee E ON A.E_ID = E.E_ID
JOIN Customer C ON A.C_ID = C.C_ID
WHERE E.E_Name = 'Amira Khaled';

--=============9==========
SELECT 
    C.C_Name, 
    A.AccNUM, 
    A.A_Type
FROM Customer C
JOIN Account A ON C.C_ID = A.C_ID
ORDER BY A.A_Type;

--=============10==========
SELECT 
    L.L_ID,
    C.C_Name,
    E.E_Name AS Employee_Name,
    B.B_Address AS Branch_Name
FROM Loan L
JOIN Customer C ON L.C_ID = C.C_ID
JOIN Handle H ON L.L_ID = H.L_ID
JOIN Employee E ON H.E_ID = E.E_ID
JOIN Branch B ON E.B_ID = B.B_ID
WHERE B.B_Address LIKE '%Cairo%';

--=============11==========
SELECT * 
FROM Employee
WHERE Position = 'Branch Manager';

--=============12==========
SELECT 
    C.C_Name, 
    T.T_ID, T.T_Type, T.T_Date, T.Amount
FROM Customer C
LEFT JOIN Account A ON C.C_ID = A.C_ID
LEFT JOIN Transaction0 T ON A.AccNUM = T.AccNUM;
