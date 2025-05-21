--1. Display the department ID, department name, manager ID, and the full name of the manager. 
--2. Display the names of departments and the names of the projects they control. 
--3. Display full data of all dependents, along with the full name of the employee they depend on. 
--4. Display the project ID, name, and location of all projects located in Cairo or Alex. 
--5. Display all project data where the project name starts with the letter 'A'. 
--6. Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE. 
--7. Retrieve the names of employees in department 10 who work ? 10 hours/week on the "AL Rabwah" project. 
--8. Find the names of employees who are directly supervised by "Kamel Mohamed". 
--9. Retrieve the names of employees and the names of the projects they work on, sorted by project name. 
--10.  For each project located in Cairo, display the project number, controlling department name, manager's last name, 
--address, and birthdate. 
--11.  Display all data of managers in the company. 
--12.  Display all employees and their dependents, even if some employees have no dependents.  


-- =====1======
SELECT 
    D.Dnum AS DepartmentID,
    D.Dname AS DepartmentName,
    D.MGRSSN AS ManagerID,
    E.Fname + ' ' + E.Lname AS ManagerFullName
FROM 
	Departments D INNER JOIN Employee E
ON 
    D.MGRSSN = E.SSN;

-- =====2======

SELECT 
    D.Dname AS DepartmentName,
    P.Pname AS ProjectName
FROM 
    Departments D INNER JOIN Project P
ON 
    D.Dnum = P.Dnum;

-- =====3======

SELECT 
    D.ESSN,
    D.Dependent_name,
    D.Sex,
    D.Bdate,
    E.Fname + ' ' + E.Lname AS EmployeeFullName
FROM 
    Dependent D INNER JOIN Employee E
ON 
    D.ESSN = E.SSN;

-- =====4======
SELECT 
    Pnumber AS ProjectID,
    Pname AS ProjectName,
    Plocation AS ProjectLocation
FROM 
    Project
WHERE 
    City IN ('Cairo', 'Alex');

-- =====5======
SELECT *
FROM Project
WHERE Pname LIKE 'A%';

-- =====6======
SELECT 
    SSN AS EmployeeID,
    Fname + ' ' + Lname AS EmployeeName
FROM 
    Employee
WHERE 
    Dno = 30 AND Salary BETWEEN 1000 AND 2000;

-- =====7======

SELECT 
    E.Fname + ' ' + E.Lname AS EmployeeName
FROM 
    Employee E INNER JOIN Works_for W 
	ON 
	E.SSN = W.ESSN INNER JOIN Project P 
	ON 
	W.Pno = P.Pnumber
WHERE 
    E.Dno = 10 AND P.Pname = 'AL Rabwah' AND W.Hours >= 10;

-- =====8======
SELECT 
    E.Fname + ' ' + E.Lname AS EmployeeName
FROM 
    Employee E
WHERE 
    E.Superssn = (
        SELECT SSN 
        FROM Employee 
        WHERE Fname = 'Kamel' AND Lname = 'Mohamed'
    );

-- =====9======

SELECT 
    E.Fname + ' ' + E.Lname AS EmployeeName,
    P.Pname AS ProjectName
FROM 
    Employee E INNER JOIN Works_for W 
ON 
	E.SSN = W.ESSN INNER JOIN Project P 
ON 
	W.Pno = P.Pnumber
ORDER BY 
    P.Pname;

-- =====10======

SELECT 
    P.Pnumber AS ProjectNumber,
    D.Dname AS DepartmentName,
    E.Lname AS ManagerLastName,
    E.Address,
    E.Bdate
FROM 
    Project P INNER JOIN Departments D 
ON 
	P.Dnum = D.Dnum INNER JOIN Employee E 
ON
	D.MGRSSN = E.SSN
WHERE 
    P.City = 'Cairo';

-- =====11======

SELECT E.*
FROM Employee E JOIN Departments D
ON E.SSN = D.MGRSSN;



-- =====12======
SELECT 
    E.SSN,
    E.Fname,
    E.Lname,
    E.Bdate AS Employee_Bdate,
    E.Address,
    E.Sex AS Employee_Sex,
    E.Salary,
    E.Superssn,
    E.Dno,
    D.Dependent_name,
    D.Sex AS Dependent_Sex,
    D.Bdate AS Dependent_Bdate
FROM 
    Employee E LEFT JOIN Dependent D
ON 
    E.SSN = D.ESSN;