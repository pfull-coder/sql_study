-- �ǽ�����

-- 1. employees ���̺��� �� ����� �μ��� 
--    �μ� ��ȣ(department_id)�� ��� �޿�(salary)�� ��ȸ�ϼ���.
    SELECT
        NVL(department_id, '0'), ROUND(AVG(salary), 2) AS "Salary Average"
    FROM employees
    GROUP BY department_id;
-- 2. employees ���̺��� �μ��� �μ� ��ȣ(department_id)�� �� ��� ���� ��ȸ�ϼ���.
    SELECT
        NVL(department_id, '0'),
        COUNT(*) AS "�� �����"
    FROM employees
    GROUP BY department_id;
-- 3. employees���̺��� �μ��� �޿� ����� 8000�� �ʰ��ϴ� �μ��� �μ���ȣ�� �޿� ����� ��ȸ�ϼ���.
    SELECT
        NVL(department_id, '0'), ROUND(AVG(salary), 2) AS "Salary Average"
    FROM employees
    GROUP BY department_id
    HAVING ROUND(AVG(salary), 2) > 8000;

-- 4. employees���̺��� �޿� ����� 8000�� �ʰ��ϴ� �� ����(job_id)�� ���Ͽ� 
--    ���� �̸�(job_id)�� SA�� �����ϴ� ����� �����ϰ� ���� �̸��� �޿� ����� 
--    �޿� ����� ���� ������ �����Ͽ� ��ȸ�ϼ���.
SELECT
    job_id,
    ROUND(AVG(salary), 2) AS "�޿����"
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY job_id
HAVING ROUND(AVG(salary), 2) > 8000
ORDER BY ROUND(AVG(salary), 2) DESC;

-- �߰�����
SELECT * FROM employees;
SELECT COUNT(*) FROM employees;
SELECT COUNT(commission_pct) FROM employees;

-- ��ü ����� ���ʽ������ �ƴ�, ���ʽ��� ���� ����� ����� ��
SELECT
    ROUND(AVG(salary * commission_pct), 2) AS avg_bonus
FROM employees;

SELECT
    ROUND(AVG(NVL(salary * commission_pct, 0)), 2) AS avg_bonus
FROM employees;