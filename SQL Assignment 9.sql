CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT(15),
    JoiningDate DATETIME,
    Department CHAR(25)
);


-- Create a stored procedure that takes in IN parameters for all the columns in the Worker table and adds a new record to the table and then invokes the procedure call
 DELIMITER $$
 CREATE PROCEDURE Add_new_worker( IN N_Worker_Id INT,
 IN N_FirstName CHAR(25), IN N_LastName CHAR(25), IN N_Salary INT(15), IN N_JoiningDate DATETIME, IN N_Department CHAR(25))
 BEGIN
 INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department) VALUES (N_Worker_Id, N_FirstName, N_LastName, N_Salary, N_JoiningDate, N_Department);
 END $$
 DELIMITER ;
 CALL Add_new_Worker(1, 'Archana', 'Anil', 50000, '2024-11-26 10:30:00', 'Engineering');
 SELECT * FROM Worker;
 
 -- Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. It should retrieve the salary of the worker with the given ID and returns it in the p_salary parameter.

DELIMITER $$
CREATE PROCEDURE Find_salary(IN N_Worker_Id INT, OUT P_Salary INT(15))
BEGIN
SELECT Salary  INTO P_Salary FROM Worker WHERE Worker_Id=N_Worker_Id;
END $$
DELIMITER ;
SET @salary=0;
CALL Find_salary(1,@salary);
SELECT @salary;

--  Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. It should update the department of the worker with the given ID. Then make a procedure call. 

DELIMITER $$
CREATE PROCEDURE Update_Worker_Department (
    IN N_Worker_Id INT,
    IN N_Department CHAR(25)
)
BEGIN
    UPDATE Worker SET Department = N_Department WHERE Worker_Id = N_Worker_Id;
END $$
DELIMITER ;
CALL Update_Worker_Department(1, 'HR');
SELECT * FROM Worker;

-- Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. It should retrieve the number of workers in the given department and returns it in the p_workerCount parameter. Make procedure call.


DELIMITER $$
CREATE PROCEDURE Get_WorkerCount_Department (IN p_Department CHAR(25),OUT p_workerCount INT)
BEGIN
    SELECT COUNT(*) INTO p_workerCount FROM Worker WHERE Department = p_Department;
END $$
DELIMITER ;
SET @workerCount=0;
CALL Get_WorkerCount_Department('HR', @workerCount);
SELECT @workerCount;

--  Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_avgSalary. It should retrieve the average salary of all workers in the given department and returns it in the p_avgSalary parameter and call the procedure.

DELIMITER $$
CREATE PROCEDURE Avg_Salary_Department (IN p_Department CHAR(25),OUT p_avgSalary DECIMAL(15, 2))
BEGIN
    SELECT AVG(Salary) INTO p_avgSalary FROM Worker WHERE Department = p_Department;
END $$
DELIMITER ;
SET avgSalary=0;
CALL Avg_Salary_Department('HR', @avgSalary);
SELECT @avgSalary;





