-- # 계층형 쿼리 추가 예제
SELECT employee_id, first_name, manager_id
FROM employees;

SELECT
    employee_id,
    LPAD(' ', 4*(LEVEL-1)) || first_name || ' ' || last_name AS "NAME",
    LEVEL
FROM employees
START WITH manager_id IS NULL
-- CONNECT BY PRIOR 자식 = 부모  ***중요
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY first_name ASC;


-- # 실습문제
-- 1. employees 테이블에서 입사일(hire_date)가 04년이거나
--    부서번호(department_id)가 20번인 사람의 사원아이디(employee_id)와
--    이름(first_name)을 조회하세요. UNION 사용!

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

-- 2. employees 테이블에서 입사일(hire_date)가 04년이고
--    부서번호(department_id)가 20번인 사람의 사원아이디(employee_id)와 이름(first_name)을 조회하세요.
--    INTERSECT을 사용할 것!
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.hire_date LIKE '04%'
INTERSECT
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.department_id = 20;

-- 3. employees 테이블에서 입사일(hire_date)가 04년에 입사하였지만
--    부서번호(department_id)가 20번이 아닌 사람의 사원아이디(employee_id)와 이름(first_name)을 조회하세요.
--    MINUS을 사용할 것!

SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.hire_date LIKE '04%'
MINUS
SELECT
E.department_id, E.employee_id, E.first_name
FROM employees E
WHERE E.department_id = 20;