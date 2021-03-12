-- # 다중행 서브쿼리 연산자 정리
-- 1. IN: 목록의 어떤값과 같은지 확인
-- 2. ANY, SOME: 값을 서브쿼리에 의해 리턴된 값 목록과 비교하는데 하나라도 만족하면 됨.
-- 3. ALL: 값을 서브쿼리에 의해 리턴된 값 목록과 비교하는데 모든 값을 만족해야 함.
-- 4. EXISTS : 결과를 만족하는 값이 존재하는지의 여부를 확인

-- ## ALL과 ANY의 차이점
-- * < ANY : 가장 큰 값보다 작으면 됨.
-- * > ANY : 가장 작은 값보다 크면 됨.
-- * < ALL : 가장 작은 값보다 작으면 됨.
-- * > ALL : 가장 큰 값보다 크면 됨.
-- * = ANY : IN과 같은 역할

SELECT first_name, salary
FROM employees
WHERE salary > ALL (
                SELECT salary
                FROM employees
                WHERE first_name = 'David'
                );

-- 스칼라 서브쿼리 추가예제 // JOIN 남발 예방
-- 모든 사원의 이름과 부서이름을 조회
SELECT
    E.first_name, D.department_name
FROM employees E
JOIN departments D
ON E.department_id = D.department_id;

SELECT
    E.first_name,
    (SELECT D.department_name FROM departments D WHERE E.department_id = D.department_id) AS dept_name
FROM employees E;

-- # 실습 문제
-- 1. employees테이블에서 Nancy보다 많은 급여를 받는 사원의 first_name과 salary를 조회하세요.

SELECT first_name, salary
FROM employees
WHERE salary > (
                SELECT salary
                FROM employees
                WHERE first_name = 'Nancy'
                );

-- 2. employees테이블에서 David와 같은 부서에 근무하는 사원 이름(first_name)과 부서번호, 직무(job_id)를 조회
SELECT first_name, department_id, job_id
FROM employees
WHERE department_id = ANY (
             SELECT department_id
             FROM employees
             WHERE first_name = 'David'
             );