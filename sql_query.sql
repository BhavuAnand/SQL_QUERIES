use first_db;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE manager (
    manager_name VARCHAR(50),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    UNIQUE(manager_name, emp_id)  -- Ensures same employee cannot have two managers
);


INSERT INTO employees (emp_id, first_name, last_name) VALUES
(101, 'Joe', 'Smith'),
(102, 'Mic', 'Johnson'),
(103, 'Sam', 'Williams'),
(104, 'Jim', 'Brown'),
(105, 'Lang', 'Jones'),
(106, 'Nina', 'Garcia'),
(107, 'Nancy', 'Martinez'),
(108, 'Alex', 'Davis'),
(109, 'Chris', 'Miller'),
(110, 'Ella', 'Wilson'),
(111, 'Jake', 'Moore'),
(112, 'Leo', 'Taylor'),
(113, 'Mia', 'Anderson'),
(114, 'Nora', 'Thomas'),
(115, 'Owen', 'Jackson'),
(116, 'Pia', 'White'),
(117, 'Quinn', 'Harris'),
(118, 'Ray', 'Clark'),
(119, 'Tia', 'Lewis'),
(120, 'Zara', 'Robinson');


INSERT INTO manager (manager_name, emp_id) VALUES
('Mic', 103),
('Mic', 105),
('Mic', 104),
('Joe', 106),
('Joe', 107),
('Joe', 108),
('Sam', 101),
('Sam', 102),
('Jim', 109),
('Jim', 110),
('Nina', 111),
('Nina', 112),
('Lang', 113),
('Lang', 114),
('Nancy', 115),
('Nancy', 116),
('Alex', 117),
('Chris', 118),
('Ella', 119),
('Jake', 120);


-- q1. get all employess under each manager
SELECT 
    m.manager_name,
    e.emp_id,
    e.first_name,
    e.last_name
FROM manager m
JOIN employees e ON m.emp_id = e.emp_id
ORDER BY m.manager_name, e.emp_id;

-- q2. how many employees are there under the name of manager 'joe'
SELECT COUNT(*) AS employee_count FROM manager WHERE manager_name = 'Joe';


-- q3. get all manager details
select * from manager;


-- q4. find if any employee is still not assigned to a manager
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN manager m ON e.emp_id = m.emp_id
WHERE m.manager_name IS NULL;



-- q5. function to get full name of the employee
DELIMITER $$
CREATE FUNCTION GetFullName(emp_id INT)
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(100);

    SELECT 
        CONCAT(first_name, ' ', last_name)
    INTO 
        full_name
    FROM 
        employee
    WHERE 
        emp_id = emp_id
    LIMIT 1;  -- Ensures only one row is selected

    RETURN full_name;
END $$

DELIMITER ;

SELECT GetFullName(102) AS FullName;  