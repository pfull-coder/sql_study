-- # ������ �������� ������ ����
-- 1. IN: ����� ����� ������ Ȯ��
-- 2. ANY, SOME: ���� ���������� ���� ���ϵ� �� ��ϰ� ���ϴµ� �ϳ��� �����ϸ� ��.
-- 3. ALL: ���� ���������� ���� ���ϵ� �� ��ϰ� ���ϴµ� ��� ���� �����ؾ� ��.
-- 4. EXISTS : ����� �����ϴ� ���� �����ϴ����� ���θ� Ȯ��

-- ## ALL�� ANY�� ������
-- * < ANY : ���� ū ������ ������ ��.
-- * > ANY : ���� ���� ������ ũ�� ��.
-- * < ALL : ���� ���� ������ ������ ��.
-- * > ALL : ���� ū ������ ũ�� ��.
-- * = ANY : IN�� ���� ����

SELECT first_name, salary
FROM employees
WHERE salary > ALL (
                SELECT salary
                FROM employees
                WHERE first_name = 'David'
                );

-- ��Į�� �������� �߰����� // JOIN ���� ����
-- ��� ����� �̸��� �μ��̸��� ��ȸ
SELECT
    E.first_name, D.department_name
FROM employees E
JOIN departments D
ON E.department_id = D.department_id;

SELECT
    E.first_name,
    (SELECT D.department_name FROM departments D WHERE E.department_id = D.department_id) AS dept_name
FROM employees E;

-- # �ǽ� ����
-- 1. employees���̺��� Nancy���� ���� �޿��� �޴� ����� first_name�� salary�� ��ȸ�ϼ���.

SELECT first_name, salary
FROM employees
WHERE salary > (
                SELECT salary
                FROM employees
                WHERE first_name = 'Nancy'
                );

-- 2. employees���̺��� David�� ���� �μ��� �ٹ��ϴ� ��� �̸�(first_name)�� �μ���ȣ, ����(job_id)�� ��ȸ
SELECT first_name, department_id, job_id
FROM employees
WHERE department_id = ANY (
             SELECT department_id
             FROM employees
             WHERE first_name = 'David'
             );