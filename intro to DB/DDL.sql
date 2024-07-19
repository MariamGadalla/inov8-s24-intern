CREATE SCHEMA company;

CREATE TABLE
    Employee (
        Fname VARCHAR(50),
        Lname VARCHAR(50),
        SSN CHAR(9) PRIMARY KEY NOT NULL,
        BDATE DATE,
        Address VARCHAR(100),
        Sex CHAR(1),
        Salary DECIMAL(10, 2),
        Superssn CHAR(9),
        Dno INT
    );

CREATE TABLE
    Department (
        Dname VARCHAR(50),
        DNumber INT PRIMARY KEY,
        MGRSSN CHAR(9),
        MGRStartdate DATE
    );

CREATE TABLE
    WorksFor (
        ESSN CHAR(9),
        Pno INT,
        Hours DECIMAL(4, 2),
        PRIMARY KEY (ESSN, Pno)
    );

CREATE TABLE
    Project (
        Pname VARCHAR(50),
        Pnumber INT PRIMARY KEY NOT NULL,
        Plocation VARCHAR(100),
        City VARCHAR(50),
        Dnum INT
    )
CREATE TABLE
    Dependent (
        ESSN CHAR(9),
        Dependent_name VARCHAR(50),
        Sex CHAR(1),
        Bdate DATE,
        PRIMARY KEY (ESSN, Dependent_name)
    );

--  ---------------------------------ALTERATIONS---------------------------------------------------
ALTER TABLE employee ADD FOREIGN KEY (Superssn) REFERENCES Employee (SSN);

ALTER TABLE employee ADD FOREIGN KEY (Dno) REFERENCES Department (DNumber);

ALTER TABLE department ADD FOREIGN KEY (MGRSSN) REFERENCES Employee (SSN);

ALTER TABLE worksfor ADD FOREIGN KEY (ESSN) REFERENCES Employee (SSN);

ALTER TABLE worksfor ADD FOREIGN KEY (Pno) REFERENCES Project (Pnumber);

ALTER TABLE project ADD FOREIGN KEY (Dnum) REFERENCES Department (DNumber);

ALTER TABLE `dependent` ADD FOREIGN KEY (ESSN) REFERENCES Employee (SSN);