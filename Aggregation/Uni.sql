-- 1. Count total number of students
SELECT COUNT(*) AS TotalStudent
FROM Student;

-- 2. Count number of students per city
SELECT 
    h.City, 
    COUNT(*) AS StudentCount
FROM 
    Student s
JOIN 
    Live l ON s.S_id = l.S_id
JOIN 
    Hostel h ON l.Hostel_id = h.Hostel_id
GROUP BY 
    h.City;

-- 3. Count students per course
SELECT 
    e.Course_id, 
    COUNT(*) AS StudentCount
FROM 
    Enroll e
GROUP BY 
    e.Course_id;

-- 4. Count number of courses per department
SELECT 
    hc.Department_id, 
    COUNT(*) AS CourseCount
FROM 
    Handle_Course hc
GROUP BY 
    hc.Department_id;

-- 5. Count number of students assigned to each hostel
SELECT 
    l.Hostel_id, 
    COUNT(*) AS StudentCount
FROM 
    Live l
GROUP BY 
    l.Hostel_id;
