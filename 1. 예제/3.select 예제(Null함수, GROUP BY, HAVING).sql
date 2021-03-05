-- CASE ǥ���� DECODE�Լ�

SELECT 
    CASE WHEN sal_cd = '100001' THEN '�⺻��'
         WHEN sal_cd = '100002' THEN '�󿩱�'
         WHEN sal_cd = '100003' THEN 'Ư���󿩱�'
         WHEN sal_cd = '100004' THEN '�߱ټ���'
         WHEN sal_cd = '100005' THEN '�ָ�����'
         WHEN sal_cd = '100006' THEN '���ɽĴ�'
         WHEN sal_cd = '100007' THEN '��������Ʈ'
         ELSE '��ȿ���� ����'
         END SAL_NAME
FROM tb_sal;

SELECT 
    DECODE(sal_cd, '100001', '�⺻��', '100002', '�󿩱�', '��Ÿ') AS SAL_NAME
FROM tb_sal;


-- # �� ���� �Լ�
-- NVL(expr1, expr2)
-- expr1 : Null�� ������ �� �ִ� ���̳� ǥ����
-- expr2 : expr1�� Null�� ��� ����� ��

SELECT 
    NVL(direct_manager_emp_no, '�ֻ�����') AS ������
FROM tb_emp
WHERE direct_manager_emp_no IS NULL;

SELECT 
    NVL(upper_dept_cd, '�ֻ����μ�') AS �����μ�
FROM tb_dept
WHERE upper_dept_cd IS NULL;

SELECT
    NVL(MAX(emp_nm), '�������') AS EMP_NM
FROM tb_emp
WHERE emp_nm = '����ȣ';

-- NVL2(expr1, expr2, expr3)
-- expr1�� ���� Null�� �ƴϸ� expr2�� ��ȯ, Null�̸� expr3�� ��ȯ
SELECT 
    emp_nm,
    NVL2(direct_manager_emp_no, '�Ϲݻ��', 'ȸ���') AS ����
FROM tb_emp;

-- COALESCE(expr1, ...)
-- ���� ǥ���� �� Null�� �ƴ� ���� ���ʷ� �߰ߵǸ� �ش� ���� ����
SELECT 
    COALESCE(NULL, NULL, 0) AS SAL
FROM dual;

SELECT 
    COALESCE(5000, NULL, 0) AS SAL
FROM dual;

SELECT 
    COALESCE(NULL, 6000, 0) AS SAL
FROM dual;


--NULLIF(exprl, expr2)
--�� ���� ������ NULL����, �ٸ��� expr1 ����
SELECT
    NULLIF('����ȣ', '������')
FROM dual;

SELECT
    NULLIF('����ȣ', '����ȣ')
FROM dual;

-- # GROUP BY, HAVING��
-- 1. �����Լ�
SELECT
    MAX(birth_de) AS "���� � ���",
    MIN(birth_de) AS "���� ���̸��� ���",
    COUNT(*) AS "�� �����"
FROM tb_emp;

-- 2. GROUP BY��
SELECT
    A.dept_cd,
    (SELECT L.dept_nm FROM tb_dept L WHERE L.dept_cd = A.dept_cd) AS dept_nm,
    MAX(A.birth_de) AS "���� ���� �������",
    MIN(A.birth_de) AS "���� ���� �������",
    COUNT(*) AS "������"
FROM tb_emp A
GROUP BY A.dept_cd
ORDER BY A.dept_cd ASC;

-- 3. HAVING��
SELECT
    A.dept_cd,
    (SELECT L.dept_nm FROM tb_dept L WHERE L.dept_cd = A.dept_cd) AS dept_nm,
    MAX(A.birth_de) AS "���� ���� �������",
    MIN(A.birth_de) AS "���� ���� �������",
    COUNT(*) AS "������"
FROM tb_emp A
GROUP BY A.dept_cd
ORDER BY A.dept_cd ASC;
HAVING COUNT(*) >= 2
ORDER BY A.dept_cd ASC;

SELECT
    A.emp_no,
    (SELECT L.emp_nm FROM tb_emp L WHERE L.emp_no = A.emp_no) AS emp_nm,
    MAX(A.pay_amt) AS max_pay_amt,
    MIN(A.pay_amt) AS min_pay_amt,
    ROUND(AVG(A.pay_amt), 2) AS avg_pay_amt
FROM tb_sal_his A
WHERE A.pay_de BETWEEN '20190101' AND '20191231'
GROUP BY A.emp_no
HAVING ROUND(AVG(A.pay_amt), 2) >= 4700000
ORDER BY A.emp_no;

SELECT * FROM tb_sal_his ORDER BY emp_no;

-- 76p �������� 5
SELECT 1,2 FROM dual WHERE 1=2;

SELECT NVL(MAX(1),1) FROM dual WHERE 1=2;

