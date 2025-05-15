-- Create the database

CREATE DATABASE Company_DB;


-- Use the newly created database
USE Company_DB;

-- 1. Create Tables (Without Foreign Keys)
CREATE TABLE EMPLOYEE (
    Fname           VARCHAR(15),
    Minit           CHAR(1),
    Lname           VARCHAR(15),
    Ssn             CHAR(9) PRIMARY KEY,
    Bdate           DATE,
    Address         VARCHAR(50),
    Sex             CHAR(1),
    Salary          DECIMAL(10,2),
    Super_ssn       CHAR(9),
    Dno             INT
);

CREATE TABLE DEPARTMENT (
    Dname           VARCHAR(20),
    Dnumber         INT PRIMARY KEY,
    Mgr_ssn         CHAR(9),
    Mgr_start_date  DATE
);

CREATE TABLE DEPT_LOCATIONS (
    Dnumber         INT,
    Dlocation       VARCHAR(20),
    PRIMARY KEY (Dnumber, Dlocation)
);

CREATE TABLE PROJECT (
    Pname           VARCHAR(20),
    Pnumber         INT PRIMARY KEY,
    Plocation       VARCHAR(20),
    Dnum            INT
);

CREATE TABLE WORKS_ON (
    Essn            CHAR(9),
    Pno             INT,
    Hours           DECIMAL(3,1),
    PRIMARY KEY (Essn, Pno)
);

CREATE TABLE DEPENDENT (
    Essn            CHAR(9),
    Dependent_name  VARCHAR(15),
    Sex             CHAR(1),
    Bdate           DATE,
    Relationship    VARCHAR(10),
    PRIMARY KEY (Essn, Dependent_name)
);

-- 2. Add Foreign Keys Using ALTER TABLE
ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_employee_supervisor
FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);

ALTER TABLE DEPARTMENT
ADD CONSTRAINT fk_department_manager
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE DEPT_LOCATIONS
ADD CONSTRAINT fk_dept_locations_department
FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber);

ALTER TABLE PROJECT
ADD CONSTRAINT fk_project_department
FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber);

ALTER TABLE WORKS_ON
ADD CONSTRAINT fk_works_on_employee
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE WORKS_ON
ADD CONSTRAINT fk_works_on_project
FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber);

ALTER TABLE DEPENDENT
ADD CONSTRAINT fk_dependent_employee
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn);


