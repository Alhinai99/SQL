--1. Display the department ID, name, and the full name of the faculty managing it. 
--2. Display each program's name and the name of the department offering it. 
--3. Display the full student data and the full name of their faculty advisor. 
--4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'. 
--5. Display full data about courses whose titles start with "I" (e.g., "Introduction to..."). 
--6. Display names of students in program ID 3 whose GPA is between 2.5 and 3.5. 
--7. Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course. 
--8. Find names of students who are advised by "Dr. Ahmed Hassan". 
--9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title. 
--10.  For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class. 
--11.  Display all faculty members who manage any department. 
--12.  Display all students and their advisors' names, even if some students don’t have advisors yet.


--==========1===============
SELECT 
    d.Department_id,
    d.D_Name AS Department_Name,
    f.F_Name AS Managing_Faculty
FROM 
    Department d
JOIN 
    Faculty f ON d.Department_id = f.Department_id;
	--==========2===============
SELECT 
    c.Course_Name,
    d.D_Name AS Department_Name
FROM 
    Course c
JOIN 
    Handle_Course hc ON c.Course_id = hc.Course_id
JOIN 
    Department d ON hc.Department_id = d.Department_id;


	--==========3===============
SELECT 
    s.*,
    f.F_Name AS Faculty_Advisor
FROM 
    Student s
JOIN 
    Advises a ON s.S_id = a.S_id
JOIN 
    Faculty f ON a.F_id = f.F_id;


	--==========4===============
SELECT 
    e.Exam_Code AS Class_ID,
    d.D_Name AS Department,
    e.Room
FROM 
    Exams e
JOIN 
    Department d ON e.Department_id = d.Department_id
WHERE 
    e.Room LIKE 'A%' OR e.Room LIKE 'B%';


	--==========5===============
SELECT *
FROM Course
WHERE Course_Name LIKE 'I%';


	--==========6===============
SELECT 
    s.Fname, 
    s.Lname, 
    s.GPA
FROM 
    Student s
JOIN 
    Enroll e ON s.S_id = e.S_id
WHERE 
    e.Course_id = 303
    AND s.GPA BETWEEN 2.5 AND 3.5;


	--==========7===============


	--==========8===============
SELECT 
    s.Fname, 
    s.Lname
FROM 
    Student s
JOIN 
    Advises a ON s.S_id = a.S_id
JOIN 
    Faculty f ON a.F_id = f.F_id
WHERE 
    f.F_Name = 'Dr. Ahmed';


	--==========9===============
SELECT 
    s.Fname + ' ' + s.Lname AS Student_Name,
    c.Course_Name
FROM 
    Student s
JOIN 
    Enroll e ON s.S_id = e.S_id
JOIN 
    Course c ON e.Course_id = c.Course_id
ORDER BY 
    c.Course_Name;


	--==========10===============
SELECT 
    e.Exam_Code AS Class_ID,
    d.D_Name AS Department,
    e.Room,
    f.F_Name AS Faculty_Name
FROM 
    Exams e
JOIN 
    Department d ON e.Department_id = d.Department_id
JOIN 
    Faculty f ON f.Department_id = d.Department_id
WHERE 
    e.Room LIKE 'Main%';


	--==========11===============
SELECT 
    f.*
FROM 
    Faculty f
WHERE 
    f.Department_id IS NOT NULL;


	--==========12===============
SELECT 
    s.Fname + ' ' + s.Lname AS Student_Name,
    f.F_Name AS Advisor_Name
FROM 
    Student s
LEFT JOIN 
    Advises a ON s.S_id = a.S_id
LEFT JOIN 
    Faculty f ON a.F_id = f.F_id;


