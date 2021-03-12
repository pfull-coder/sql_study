-- # 서브쿼리
-- ## 서브 쿼리를 사용할 수 있는 곳
-- [ select절(스칼라 서브쿼리), from절(인라인 뷰),
-- where, having, order by절, insert의 value절, update set절]

-- ## 서브쿼리 사용 유의점
-- 1. 반드시 괄호로 감쌀 것.
-- 2. 비교연산자 오른쪽에 위치시킬 것.
-- 3. 서브쿼리에 order by 사용 불가.
-- 4. 단일 행 서브쿼리에는 단일 행 연산자만, 다중 행 서브쿼리에는 다중 행 연산자를 사용.

-- # 단일 행 서브쿼리

-- 사원번호가 1000000005번인 사원이 속한 부서의 모든 직원 정보
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd =
        (
            SELECT dept_cd
            FROM tb_emp
            WHERE emp_no = '1000000005'
        );

-- 20150525에 받은 급여가 회사 전체 평균급여보다 높은 사원들의 정보 조회
SELECT
A.emp_no, B.emp_nm, A.pay_de, A.pay_amt
FROM tb_sal_his A
INNER JOIN tb_emp B
ON A.emp_no = B.emp_no
WHERE A.pay_de = '20200525'
    AND A.pay_amt >= (
                        SELECT AVG(S.pay_amt)
                        FROM tb_sal_his S
                        WHERE S.pay_de = '20200525'
                    );
    

-- # 다중 행 서브쿼리
-- 서브쿼리 조회 건수가 다중 행인 것(IN, ANY, ALL, EXISTS)

-- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는 사원번호와 자격증 개수를 조회
SELECT
    emp_no, COUNT(*) CNT
FROM tb_emp_certi
WHERE certi_cd IN (
                    SELECT certi_cd
                    FROM tb_certi
                    WHERE issue_insti_nm = '한국데이터베이스진흥원'
                  )
GROUP BY emp_no
ORDER BY emp_no;

-- 부서원이 2명 이상인 부서 중에서 각 부서의 가장 나이 많은 사람의 정보를 조회.
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm, A.birth_de
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (
                                    SELECT
                                        E. dept_cd, MIN(E.birth_de) AS MIN_BIRTH
                                    FROM tb_emp E
                                    GROUP BY E.dept_cd
                                    HAVING COUNT(*) > 1
                                    )
ORDER BY A.emp_no;

-- 주소가 강남인 직원들의 부서정보를 조회
SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
              SELECT 1 FROM tb_emp K WHERE K.dept_cd = A.dept_cd
                                       AND K.addr LIKE '%강남%'
             );
SELECT 1, emp_nm, addr FROM tb_emp WHERE addr LIKE '%강남%';   


-- # 스칼라 서브쿼리
SELECT * FROM tb_emp_certi;

SELECT
    A.emp_no,
    (SELECT emp_nm FROM tb_emp L WHERE L.emp_no = A.emp_no) AS emp_nm,
    A.certi_cd,
    (SELECT C.certi_nm FROM tb_certi C WHERE C.certi_cd = A.certi_cd) AS certi_nm
FROM tb_emp_certi A
WHERE certi_cd IN (
                    SELECT K.certi_cd
                    FROM tb_certi K
                    WHERE K.issue_insti_nm = '한국데이터베이스진흥원'
                  )
ORDER BY certi_nm;