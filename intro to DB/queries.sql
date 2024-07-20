-------------------------------------------------------------------------QUERIES--------------------------------------------------------------
1. SELECT * FROM Employee;

2. SELECT Fname, Lname, Salary, Dno FROM Employee;

3. SELECT Pname, Plocation, Dnum FROM Project;

4. SELECT CONCAT(Fname, ' ', Lname) AS FullName, Salary * 12 * 0.10 AS Annual_Comm FROM Employee;

5. SELECT SSN, Fname, Lname FROM Employee WHERE Salary > 1000;

6. SELECT SSN, Fname, Lname FROM Employee WHERE Salary * 12  > 10000;

7. SELECT Fname, Lname, Salary FROM Employee WHERE Sex = 'F';

8. SELECT DNumber, Dname FROM Department WHERE MGRSSN = '968574';

9. SELECT Pnumber, Pname, Plocation FROM project WHERE Dnum = 10;

10. SELECT D.DNumber, D.Dname, E.Fname, E.Lname, E.SSN FROM department  D JOIN employee E ON E.SSN = D.MGRSSN;

11. SELECT D.Dname, P.Pname FROM Department D JOIN Project P ON D.DNumber = P.Dnum;

12.SELECT D.*, E.Fname, E.Lname FROM dependent D JOIN Employee E ON D.ESSN = E.SSN;

13.SELECT D.Dependent_name , D.Sex FROM Dependent D JOIN Employee E ON D.ESSN = E.SSN WHERE D.Sex = 'F' AND E.Sex = 'F'
    UNION
    SELECT D.Dependent_name , D.Sex FROM Dependent D JOIN Employee E ON D.ESSN = E.SSN WHERE D.Sex = 'M' AND E.Sex = 'M';

14. SELECT E.* FROM Employee E JOIN Department D ON E.SSN = D.MGRSSN;

15. SELECT Pnumber, Pname, Plocation FROM Project WHERE City IN ('Cairo', 'Alex');

16. SELECT * FROM Project WHERE Pname LIKE 'a%';

17. SELECT * FROM Employee WHERE Dno = 30 AND Salary BETWEEN 1000 AND 2000;

18. SELECT E.Fname, E.Lname FROM Employee E WHERE E.Dno = 10 AND E.SSN 
    IN (
      SELECT W.ESSN
      FROM WorksFor W
      JOIN Project P ON W.Pno = P.Pnumber
      WHERE P.Pname = 'AL Rabwah' AND W.Hours >= 10
    );

19. SELECT E.Fname, E.Lname FROM Employee E JOIN Employee S ON E.Superssn = S.SSN WHERE S.Fname = 'Kamel' AND S.Lname = 'Mohamed';

20. SELECT P.Pname, SUM(W.Hours) AS Total_Hours FROM Project P JOIN WorksFor W ON P.Pnumber = W.Pno GROUP BY P.Pname;

21. SELECT E.Fname, E.Lname FROM Employee E JOIN WorksFor W ON E.SSN = W.ESSN GROUP BY E.SSN, E.Fname, E.Lname 
    HAVING COUNT(DISTINCT W.Pno) = (SELECT COUNT(*) FROM Project) ORDER BY E.Lname, E.Fname;

22. SELECT D.* FROM Department D WHERE D.DNumber = ( SELECT E.Dno FROM Employee E ORDER BY E.SSN LIMIT 1);

23. SELECT D.Dname, 
       MAX(E.Salary) AS Max_Salary, 
       MIN(E.Salary) AS Min_Salary, 
       AVG(E.Salary) AS Avg_Salary FROM Department D JOIN Employee E ON D.DNumber = E.Dno GROUP BY D.Dname;

24. SELECT DISTINCT E.Lname FROM Employee E LEFT JOIN Dependent D ON E.SSN = D.ESSN WHERE D.ESSN IS NULL AND E.SSN IN (SELECT MGRSSN FROM Department);

25. SELECT D.DNumber, D.Dname, COUNT(E.SSN) AS NumEmployees FROM Department D JOIN Employee E ON D.DNumber = E.Dno 
    GROUP BY D.DNumber, D.Dname
    HAVING AVG(E.Salary) < ( SELECT AVG(Salary) FROM Employee );

26. SELECT E.Fname, E.Lname, P.Pname FROM Employee E JOIN WorksFor W ON E.SSN = W.ESSN JOIN Project P ON W.Pno = P.Pnumber 
    JOIN Department D ON E.Dno = D.DNumber ORDER BY D.Dname, E.Lname, E.Fname;

27. SELECT P.Pnumber, D.Dname, E.Lname, E.Address, E.BDATE FROM Project P JOIN Department D ON P.Dnum = D.DNumber JOIN Employee E ON D.MGRSSN = M.SSN WHERE P.City = 'Cairo';

28. SELECT P.Pnumber FROM Project P
    WHERE P.Pnumber IN (
    SELECT W.Pno
    FROM WorksFor W
    JOIN Employee E ON W.ESSN = E.SSN
    WHERE E.Lname = 'Mohamed'
)
OR P.Dnum IN (
    SELECT D.DNumber
    FROM Department D
    JOIN Employee M ON D.MGRSSN = M.SSN
    WHERE M.Lname = 'Mohamed'
);

29.SELECT E.SSN,E.Fname, E.Lname FROM Employee E 
    WHERE NOT EXISTS (
        SELECT 1
        FROM Dependent D
        WHERE D.ESSN = E.SSN
    );

----------------------------------------------------------- Data Manipulating Language -------------------------------------

1. -- Inserting personal data into the Employee table
INSERT INTO Employee (Fname, Lname, SSN, BDATE, Address, Sex, Salary, Superssn, Dno) 
VALUES ('Mariam', 'Gaadallah', '102672', '2002-10-18', 'Bolkly', 'F', 10000, '112233', 30);


2. -- Inserting friend data into the Employee table
INSERT INTO Employee (Fname, Lname, SSN, BDATE, Address, Sex, Salary, Superssn, Dno) 
VALUES ('Miley', 'Mohamed', '102660', '2016-01-02', 'Roushdy', 'F', NULL, NULL, 30);

3. -- Inserting new department into the Department table
INSERT INTO Department (Dname, DNumber, MGRSSN, MGRStartdate) VALUES ('DEPT IT', 100, '112233', '2006-11-01');

4. -- Update Noha Mohamed to be the manager of department 100
UPDATE Department SET MGRSSN = '968574', MGRStartdate = '2024-07-20' WHERE DNumber = 100;
   -- Update my record to be the manager of department 20
UPDATE Department SET MGRSSN = '102672', MGRStartdate = '2024-07-20' WHERE DNumber = 20;
   -- Update my friend’s record to be supervised by you
UPDATE Employee SET Superssn = '102672' WHERE SSN = '102660';

5. -- Updating my record to temporarily manage Mr. Kamel Mohamed's department
UPDATE Employee SET Dno = (SELECT Dno FROM Employee WHERE SSN = '223344') WHERE SSN = '102672';
  -- Updating my record to temporarily take over Mr. Kamel Mohamed's supervisor role
UPDATE Employee SET Superssn = '102672' WHERE SSN = '223344';
  -- Remove dependents related to Mr. Kamel Mohamed
DELETE FROM Dependent WHERE ESSN = '223344';
  -- Update employees supervised by Mr. Kamel Mohamed to set a new supervisor or NULL
UPDATE Employee SET Superssn = '102672' WHERE Superssn = '223344'
  -- Remove records from the WorksFor table related to Mr. Kamel Mohamed
DELETE FROM WorksFor WHERE ESSN = '223344';
  -- Delete Mr. Kamel Mohamed from the Employee table
DELETE FROM Employee WHERE SSN = '223344';

6. -- Updating my salary so that it is increased by 20%
UPDATE Employee SET Salary = Salary * 1.20 WHERE SSN = '102672';