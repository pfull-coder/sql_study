-- # ������ ���� �߰� ����
SELECT employee_id, first_name, manager_id
FROM employees;

SELECT
    employee_id,
    LPAD(' ', 4*(LEVEL-1)) || first_name || ' ' || last_name AS "NAME",
    LEVEL
FROM employees
START WITH manager_id IS NULL
-- CONNECT BY PRIOR �ڽ� = �θ�  ***�߿�
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY first_name ASC;


-- # �ǽ�����
-- 1. employees ���̺��� �Ի���(hire_date)�� 04���̰ų�
--    �μ���ȣ(department_id)�� 20���� ����� ������̵�(employee_id)��
--    �̸�(first_name)�� ��ȸ�ϼ���. UNION ���!

SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.hire_date LIKE '04%'
UNION
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.department_id = 20;

SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.hire_date LIKE '04%'
UNION ALL
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.department_id = 20;

-- 2. employees ���̺��� �Ի���(hire_date)�� 04���̰�
--    �μ���ȣ(department_id)�� 20���� ����� ������̵�(employee_id)�� �̸�(first_name)�� ��ȸ�ϼ���.
--    INTERSECT�� ����� ��!
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.hire_date LIKE '04%'
INTERSECT
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.department_id = 20;

-- 3. employees ���̺��� �Ի���(hire_date)�� 04�⿡ �Ի��Ͽ�����
--    �μ���ȣ(department_id)�� 20���� �ƴ� ����� ������̵�(employee_id)�� �̸�(first_name)�� ��ȸ�ϼ���.
--    MINUS�� ����� ��!

SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.hire_date LIKE '04%'
MINUS
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.department_id = 20;