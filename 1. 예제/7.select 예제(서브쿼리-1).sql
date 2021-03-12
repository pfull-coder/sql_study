-- # ��������
-- ## ���� ������ ����� �� �ִ� ��
-- [ select��(��Į�� ��������), from��(�ζ��� ��),
-- where, having, order by��, insert�� value��, update set��]

-- ## �������� ��� ������
-- 1. �ݵ�� ��ȣ�� ���� ��.
-- 2. �񱳿����� �����ʿ� ��ġ��ų ��.
-- 3. ���������� order by ��� �Ұ�.
-- 4. ���� �� ������������ ���� �� �����ڸ�, ���� �� ������������ ���� �� �����ڸ� ���.

-- # ���� �� ��������

-- �����ȣ�� 1000000005���� ����� ���� �μ��� ��� ���� ����
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd =
        (
            SELECT dept_cd
            FROM tb_emp
            WHERE emp_no = '1000000005'
        );

-- 20150525�� ���� �޿��� ȸ�� ��ü ��ձ޿����� ���� ������� ���� ��ȸ
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
    

-- # ���� �� ��������
-- �������� ��ȸ �Ǽ��� ���� ���� ��(IN, ANY, ALL, EXISTS)

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ� �����ȣ�� �ڰ��� ������ ��ȸ
SELECT
    emp_no, COUNT(*) CNT
FROM tb_emp_certi
WHERE certi_cd IN (
                    SELECT certi_cd
                    FROM tb_certi
                    WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
                  )
GROUP BY emp_no
ORDER BY emp_no;

-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� ���� ���� ���� ����� ������ ��ȸ.
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

-- �ּҰ� ������ �������� �μ������� ��ȸ
SELECT A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
              SELECT 1 FROM tb_emp K WHERE K.dept_cd = A.dept_cd
                                       AND K.addr LIKE '%����%'
             );
SELECT 1, emp_nm, addr FROM tb_emp WHERE addr LIKE '%����%';   


-- # ��Į�� ��������
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
                    WHERE K.issue_insti_nm = '�ѱ������ͺ��̽������'
                  )
ORDER BY certi_nm;