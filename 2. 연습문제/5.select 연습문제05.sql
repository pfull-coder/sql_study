-- OUTER JOIN ����
SELECT * FROM job_history; -- �������� �̷�
SELECT * FROM employees;

-- ��� ����� ������ȸ �� ���� �����̷��� �ִٸ� �ش� ������ ���� ��ȸ�ϰ� ���� ���
-- ���� �����̷��� �ִ� ����� ��ȸ�ϰ� �ȴ�.
SELECT
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "cur_job_id",
    J.start_date, J.end_date, J.job_id, J.department_id
FROM employees E, job_history J
WHERE E.employee_id = J.employee_id(+) -- LEFT OUTER JOIN(������)
ORDER BY J.employee_id;

SELECT
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "cur_job_id",
    J.start_date, J.end_date, J.job_id, J.department_id
FROM employees E
LEFT OUTER JOIN job_history J -- LEFT OUTER JOIN(�Ź���)
ON E.employee_id = J.employee_id
ORDER BY J.employee_id;

-- �ǽ����� 
-- 1. �����ȣ�� 103���� ����� �̸�(employee_name)�� �Ŵ��� �̸�(manager_name)�� ����ϼ���.
SELECT
    e.first_name AS employee_name,
    m.first_name AS manager_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
    AND e.employee_id=103;
    
        
SELECT
    e.first_name AS employee_name,
    m.first_name AS manager_name
FROM employees e 
JOIN employees m
ON e.manager_id = m.employee_id
WHERE e.employee_id=103;


SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

-- 2. ��� ����� first_name�� department_name,
--    street_address + ',' + city + ',' + state_province�� 
--    address��� alias�� ��ȸ�ϼ���.
SELECT
    E.first_name, D.department_name, 
    L.street_address || ',' || L.city || ',' || L.state_province AS address
FROM employees E

JOIN departments D
ON E.department_id = D.department_id
JOIN locations L
ON D.location_id = L.location_id;


-- 3. 103�� ����� first_name�� department_name,
--    street_address + ',' + city + ',' + state_province��
--    address��� alias�� �����Ͽ� ��ȸ�ϼ���.

SELECT
    E.first_name, D.department_name, 
    L.street_address || ',' || L.city || ',' || L.state_province AS address
FROM employees E
JOIN departments D
ON E.department_id = D.department_id
JOIN locations L
ON D.location_id = L.location_id
WHERE E.employee_id = 103;

-- 4. �μ� �̸��� IT�� �����ϴ� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province��
--    address��� alias�� �����Ͽ� ��ȸ�ϼ���.

SELECT
    E.first_name, D.department_name, 
    L.street_address || ',' || L.city || ',' || L.state_province AS address
FROM employees E
JOIN departments D
ON E.department_id = D.department_id
JOIN locations L
ON D.location_id = L.location_id
WHERE D.department_name LIKE 'IT%';