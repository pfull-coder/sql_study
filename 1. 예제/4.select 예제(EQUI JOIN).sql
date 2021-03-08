-- ORDER BY 정렬
SELECT
    certi_cd, certi_nm, issue_insti_nm
FROM tb_certi
ORDER BY certi_nm DESC
;

SELECT
    emp_no, emp_nm, birth_de, addr, tel_no,
    direct_manager_emp_no
FROM tb_emp
WHERE birth_de LIKE '196%'
ORDER BY direct_manager_emp_no DESC;

SELECT
    certi_cd,
    issue_insti_nm
FROM tb_certi
ORDER BY certi_nm DESC;

SELECT * FROM tb_emp;
SELECT * FROM tb_dept;
SELECT * FROM tb_emp_certi;


-- JOIN 기초
SELECT
    A.emp_no,
    A.emp_nm,
    A.dept_cd,
    B.dept_nm
FROM tb_emp A, tb_dept B
WHERE A.dept_cd = B.dept_cd
    AND B.dept_nm = '기획팀'
    ;

SELECT
    A.emp_no,
    A.emp_nm,
    B.dept_nm,
    C.certi_cd
FROM 
    tb_emp A,
    tb_dept B,
    tb_emp_certi C,
    tb_certi D
WHERE A.dept_cd = B.dept_cd
    AND A.emp_no = C.emp_no
    AND C.certi_cd = d.certi_cd
    AND B.dept_nm = '빅데이터팀';
    
-- # INNER JOIN = EQUI JOIN
-- 1. 2개 이상의 테이블이 공토오디는 컬럼에 의해 논리적으로 결합되는 조인기법입니다.
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 비교됩니다.

SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B
WHERE A.dept_cd = B.dept_cd
    AND A.addr LIKE '%일산%'
ORDER BY A.emp_no
;

-- #NATURAL JOIN
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 조인을 합니다.
-- 2. 즉 자동으로 두 테이블에서 같은 이름을 가진 컬럼에 대해 INNER조인을 수행합니다.
-- 3. 이때 JOIN 컬럼은 데이터 타입이 같아야하며, ALIAS나 테이블 명과 같은 접두사를 붙일 수 없습니다.
-- 4. 'SELECT *' 문법을 사용하면, 공통 컬럼들로 자동 조인하며,
--    공통 컬럼들은 결과 집합에서 한번만 표현됩니다.

SELECT * FROM tb_emp;
SELECT * FROM tb_dept;

SELECT 
    *
FROM tb_emp A NATURAL JOIN tb_dept B
;

SELECT 
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm
FROM tb_emp A NATURAL JOIN tb_dept B
;

SELECT 
    A.emp_no, A.emp_nm, B.dept_nm
FROM tb_emp A NATURAL JOIN tb_dept B
;

-- # USING 절 조인
-- 1. NATURAL 조인에서는 자동으로 이름이 일치하는 모든 컬럼들에 대해 조인이 이루어지지만,
--    USING절을 사용하면 원하는 컬럼에 대해서만 선택적으로 EQUI조인이 가능합니다.
-- 2. USING절에서도 조인 컬럼에 대해서 ALIAS나 테이블 명과 같은 접두사를 붙일 수 없습니다.

SELECT
    A.emp_no,
    A.emp_nm,
    A.addr,
    dept_cd,
    B.dept_nm
FROM tb_emp A
JOIN tb_dept B USING (dept_cd);

SELECT
    E.first_name, department_id, D.department_name
FROM employees E
JOIN departments D USING (department_id, manager_id);

-- # JOIN ON 절
-- 1. JOIN 조건 서술부(ON절) 일반 조건 서술부(WHERE절)을 분리해서 작성하기 위한 방법입니다.
-- 2. ON절을 사용하면 JOIN이후에 논리 연산이나 서브쿼리와 같은 추가 서술을 할 수 있습니다.

SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE A.addr LIKE '%일산%'
ORDER BY A.emp_no
;