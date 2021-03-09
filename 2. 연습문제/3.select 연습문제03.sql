-- 실습문제

-- 1. employees 테이블에서 각 사원의 부서별 
--    부서 번호(department_id)와 평균 급여(salary)를 조회하세요.
    SELECT
        NVL(department_id, '0'), ROUND(AVG(salary), 2) AS "Salary Average"
    FROM employees
    GROUP BY department_id;
-- 2. employees 테이블에서 부서별 부서 번호(department_id)와 총 사원 수를 조회하세요.
    SELECT
        NVL(department_id, '0'),
        COUNT(*) AS "총 사원수"
    FROM employees
    GROUP BY department_id;
-- 3. employees테이블에서 부서의 급여 평균이 8000을 초과하는 부서의 부서번호와 급여 평균을 조회하세요.
    SELECT
        NVL(department_id, '0'), ROUND(AVG(salary), 2) AS "Salary Average"
    FROM employees
    GROUP BY department_id
    HAVING ROUND(AVG(salary), 2) > 8000;

-- 4. employees테이블에서 급여 평균이 8000을 초과하는 각 직무(job_id)에 대하여 
--    직무 이름(job_id)가 SA로 시작하는 사원은 제외하고 직무 이름과 급여 평균을 
--    급여 평균이 높은 순서로 정렬하여 조회하세요.
SELECT
    job_id,
    ROUND(AVG(salary), 2) AS "급여평균"
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY job_id
HAVING ROUND(AVG(salary), 2) > 8000
ORDER BY ROUND(AVG(salary), 2) DESC;

-- 추가사항
SELECT * FROM employees;
SELECT COUNT(*) FROM employees;
SELECT COUNT(commission_pct) FROM employees;

-- 전체 사원의 보너스평균이 아님, 보너스를 받은 사람만 평균을 냄
SELECT
    ROUND(AVG(salary * commission_pct), 2) AS avg_bonus
FROM employees;

SELECT
    ROUND(AVG(NVL(salary * commission_pct, 0)), 2) AS avg_bonus
FROM employees;