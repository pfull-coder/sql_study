-- # 집합 연산자
-- ## UNION
-- 1. 수학에서의 합집합과 같은 의미
-- 2. 첫 번째 쿼리와 두 번째 쿼리의 중복된 정보는 한번만 보여줍니다.
-- 3. 첫 번째 쿼리의 열 개수와 타입이 두 번째 쿼리의 열의 개수와 타입과 동일해야 합니다.

SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

-- ## UNION ALL
-- 1. 첫 번째 쿼리와 두 번째 쿼리에 있는 모든 데이터를 합쳐서 보여줍니다.
-- 2. 중복된 정보도 모두 보여줍니다.
-- 3. UNION과는 달리 자동 정렬기능을 제공하지 않습니다.

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

-- ## INTERSECT (이론적으로만 인지 권장, 거의 사용하지 않음)
-- 1. 첫 번째 쿼리와 두 번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 수학에서의 교집합과 같은 의미입니다.

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
    AND A.addr LIKE '%용인%';
    
    
SELECT
    A.emp_no, A.emp_nm, A.addr, B.certi_cd, C.certi_nm
FROM tb_emp A, tb_emp_certi B, tb_certi C
WHERE A.emp_no = B.emp_no
    AND B.certi_cd = C.certi_cd
    AND C.certi_nm = 'SQLD'
    AND A.addr LIKE '%용인%';
    
-- ## MINUS (EXCEPT)
-- 1. 수학에서의 차집합과 같은 의미입니다.
-- 2. 두 번째 쿼리에는 업고 첫 번째 쿼리에만 있는 데이터를 보여줍니다.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1';

-- # 계층형 질의
-- 1. 관계형이라는 의미는 데이터가 서로 평등하고 수평적인 관계를 의미하는 반면
--    계층형은 계급적이고 수직적인 관게를 의미합니다.
-- 2. 웹사이트에서 사용하는 답변형 게시판이나 카테고리 정보들이 계층형 구조에 해당합니다.

-- 계층형 전용 키워드
-- 1. START WITH top_level_condition
--   : 루트노드를 지정하는 조건, 이 조건을 만족하는 모든 행들은 루트노드가 된다.
-- 2. CONNECT BY[PRIOR] connect_condition
--   : 부모와 자식 노드들의 사이의 관계를 명시합니다. 이 조건에 따라 부모와 자식 노드들의
--     사이를 연결합니다. PRIOR는 부모 노드 컬럼을 식별하는데 사용합니다.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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