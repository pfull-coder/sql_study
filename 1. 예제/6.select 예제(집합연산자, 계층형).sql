-- # ���� ������
-- ## UNION
-- 1. ���п����� �����հ� ���� �ǹ�
-- 2. ù ��° ������ �� ��° ������ �ߺ��� ������ �ѹ��� �����ݴϴ�.
-- 3. ù ��° ������ �� ������ Ÿ���� �� ��° ������ ���� ������ Ÿ�԰� �����ؾ� �մϴ�.

SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

-- ## UNION ALL
-- 1. ù ��° ������ �� ��° ������ �ִ� ��� �����͸� ���ļ� �����ݴϴ�.
-- 2. �ߺ��� ������ ��� �����ݴϴ�.
-- 3. UNION���� �޸� �ڵ� ���ı���� �������� �ʽ��ϴ�.

SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

-- ## INTERSECT (�̷������θ� ���� ����, ���� ������� ����)
-- 1. ù ��° ������ �� ��° �������� �ߺ��� �ุ�� ����մϴ�.
-- 2. ���п����� �����հ� ���� �ǹ��Դϴ�.

SELECT
    A.emp_no, A.emp_nm, A.addr, B.certi_cd, C.certi_nm
FROM tb_emp A, tb_emp_certi B, tb_certi C
WHERE A.emp_no = B.emp_no
    AND B.certi_cd = C.certi_cd
    AND C.certi_nm = 'SQLD'
INTERSECT    
    SELECT
    A.emp_no, A.emp_nm, A.addr, B.certi_cd, C.certi_nm
FROM tb_emp A, tb_emp_certi B, tb_certi C
WHERE A.emp_no = B.emp_no
    AND B.certi_cd = C.certi_cd
    AND A.addr LIKE '%����%';
    
    
SELECT
    A.emp_no, A.emp_nm, A.addr, B.certi_cd, C.certi_nm
FROM tb_emp A, tb_emp_certi B, tb_certi C
WHERE A.emp_no = B.emp_no
    AND B.certi_cd = C.certi_cd
    AND C.certi_nm = 'SQLD'
    AND A.addr LIKE '%����%';
    
-- ## MINUS (EXCEPT)
-- 1. ���п����� �����հ� ���� �ǹ��Դϴ�.
-- 2. �� ��° �������� ���� ù ��° �������� �ִ� �����͸� �����ݴϴ�.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1';

-- # ������ ����
-- 1. �������̶�� �ǹ̴� �����Ͱ� ���� ����ϰ� �������� ���踦 �ǹ��ϴ� �ݸ�
--    �������� ������̰� �������� ���Ը� �ǹ��մϴ�.
-- 2. ������Ʈ���� ����ϴ� �亯�� �Խ����̳� ī�װ� �������� ������ ������ �ش��մϴ�.

-- ������ ���� Ű����
-- 1. START WITH top_level_condition
--   : ��Ʈ��带 �����ϴ� ����, �� ������ �����ϴ� ��� ����� ��Ʈ��尡 �ȴ�.
-- 2. CONNECT BY[PRIOR] connect_condition
--   : �θ�� �ڽ� ������ ������ ���踦 ����մϴ�. �� ���ǿ� ���� �θ�� �ڽ� ������
--     ���̸� �����մϴ�. PRIOR�� �θ� ��� �÷��� �ĺ��ϴµ� ����մϴ�.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no;

SELECT emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp;