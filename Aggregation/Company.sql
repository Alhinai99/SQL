-- GET NUMBER OF EMPLOYESS
SELECT COUNT(*) AS TotalEmployees FROM Employee;
--  GET THE AVREG SALARY OF ALL EMPLOYEE
SELECT AVG(Salary) AS AverageSalary FROM Employee;
--  Count employees in each department
SELECT Dnum, COUNT(*) AS EmployeeCount FROM Departments GROUP BY Dnum;
--Total salary per department
SELECT d.Dname, SUM(e.Salary) AS TotalSalary
FROM Employee e
JOIN Departments d ON e.Dno = d.Dnum
GROUP BY d.Dname;
--Display departments having more than 5 employees
SELECT d.Dname, COUNT(e.SSN) AS EmployeeCount
FROM Employee e
JOIN Departments d ON e.Dno = d.Dnum
GROUP BY d.Dname
HAVING COUNT(e.SSN) > 5;