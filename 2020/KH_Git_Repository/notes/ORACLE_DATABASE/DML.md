# Database
- SQL (Structured Query Language)

- DML: ������ ��ü ����
  - ����(INSERT)
  - ����(UPDATE)
  - ����(DELETE)
  - ( ��ȸ(SELECT) )

- DQL: �����͸� ��ȸ �� �˻�
  - <b>SELECCT</b>

- DDL: ������ ����
  - CREATE
  - ALTER
  - DROP

- TCL: Ʈ������ ����(��� ��� �Ұ���.)
  - ������ �ο��ް�, ������¿��� ���� �� �ǵ����������� ����
  - ��������� �����ϰų� �ֽŻ��·� �����ڴ�.
  - COMMIT
  - ROLLBACK
  - GRANT


<HR>

- Ʃ�� = ��(����)
  - �ϳ��� ������ row

- �÷� = ��(����)

- �⺻Ű(Primary Key): ������ ���� - Ʃ���� �����ϴµ� ���.
  - �ߺ��Ǹ� �ȵȴ�.
  - ���� ��������� �ȵȴ�.

  - ���̵�
  - ������ ������ ���� �⺻Ű�� �� �� ����.
  - DB�𵨸����� �߿��� �����̴�.

- �ܷ�Ű
  - ���̺��� ���̺� ���̿��� ���踦 ���� �� �ִ�.
    - (A���̺�) (B���̺�) ���� ����
      ```
      �� ���̺��� �⺻Ű�� �ٸ����̺��� �Ϲ��÷����� ���� ��
      ���̺� A�� ���̺� B�� ���谡 �ξ�����.
      ```
      - B���̺����忡�� �� �Ϲ��÷��� ���̺� A�� �⺻Ű���� �� ���̹Ƿ�, �ܷ�Ű�̴�.

- ���̺��� �����Ϳ��� NULL���� ������� �� �ִ�.


<hr>


# SELECT

<B>
- *Result Set* : �����͸� ��ȸ/�˻�/���� �� �����
- SELECT ������ ���ؼ� ��ȯ�� ����� ����
</B>

- Result Set�� *0�� �̻��� ��* �� ���Ե� �� �ִ�.
- ���ĵ� �����ϴ�.

```SQL
SELECT �÷��� -- ��� �÷��� �� ��ȸ  : *(*=�ƽ�Ʈ��)
FROM ���̺���
WHERE ���ǽ�; -- ���� �����ϴ� ���� ���.

```


```sql
-- SELECT
-- SELECT �������� �����͸� ��ȸ�� ������� RESULT_SET ���� ��ȯ

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
```


```sql
-- ��� ����� ��ȸ
-- EMPLOYEE ���̺����� ��� ����� ��� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, JOB_CODE, SAL_LEVEL, SALARY,
BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;

-- ���� ǥ��
SELECT *
FROM EMPLOYEE;
```

- ����
```sql
-- JOB ���̺��� ��� ���� ��ȸ
SELECT * FROM JOB;

-- JOB ���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME FROM JOB;

-- DEPARTMENT ���̺��� ��� ���� ��ȸ
DESC DEPARTMENT ; --���̺��� ������Ҹ� �� �� ����.
SELECT * FROM DEPARTMENT;

-- EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, ������ ��ȸ
DESC EMPLOYEE;
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������, ����̸� �޿� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY FROM EMPLOYEE;
```

<HR>

- �÷��� �������
  - �÷��� �ִ� �����͸� ����Ͽ� ���ο� �÷� �����
```sql
-- �÷��� �������
-- SELECT �� �÷��� �Էºκп� ��꿡 �ʿ���
-- �÷���, ����, �����ڸ� �̿��Ͽ� ��� ��ȸ
-- EMPLOYEE ���̺����� ������, ���� ��ȸ(SALARY *12)

SELECT EMP_NAME, SALARY*12 "����"
FROM EMPLOYEE;


-- EMPLOYEE ���̺����� ������, ����, ���ʽ��� �߰��� ���� ��ȸ
SELECT EMP_NAME, SALARY*12 "����", 12*(SALARY+BONUS)  "���ʽ� �߰� ����"
FROM EMPLOYEE;
```

<BR>

- ����
```sql
--EMPLOYEE���̺����� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ�-(����*����3%)) ��ȸ
DESC EMPLOYEE;
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*12 "����" , SALARY*(1+BONUS)*12 "�Ѽ��ɾ�" , (SALARY*(1+BONUS)*12-(SALARY*12*0.03)) "�Ǽ��ɾ�"
FROM EMPLOYEE;


--EMPLOYEE���̺����� �̸�, ������, �ٹ��ϼ�(���� ��¥-������) ��ȸ (SYSDATE ���糯¥)
SELECT EMP_NAME, HIRE_DATE, (SYSDATE-HIRE_DATE) "�ٹ��ϼ�", SYSDATE "���糯¥"
FROM EMPLOYEE;
```

<HR>


# �÷��� ��Ī �ֱ�

- �÷��� AS ��Ī
- �÷��� "��Ī"
- �÷��� AS "��Ī"
- �÷��� ��Ī


- AS ��� ������� ��Ī�� <B>����, Ư������, ����</B>�� �ִٸ� <B>""</B> �� ����ؾ��Ѵ�.

```sql
-- �÷� ��Ī
-- ��Ī�� ����, Ư�����ڰ� ������ ������ "" �� �̿��ؾ���.

SELECT EMP_NAME AS �̸� , SALARY*12 AS "����(��)", (SALARY*(1+BONUS))*12 "�Ѽҵ�(��)"
FROM EMPLOYEE;


-- ����2
SELECT EMP_NAME �̸�, HIRE_DATE ������, SYSDATE-HIRE_DATE �ٹ��ϼ�
FROM EMPLOYEE;

```

<BR>

- ���ͷ�(Literal) = ����ü
- '': ���ڸ� ��������Ÿ� Ȭ����ǥ�� �̿�
- "": ��Ī
- DB�� ��ü�� ��ҹ��� �Ȱ�����.
  - ��ҹ��ڸ� �����°���, ���ڿ������� ��Ÿ����.
    - 'Won', 'won' �� �ٸ� ������ �����Ѵ�.
    - �����ڰ���/����� ������  ��й�ȣ�� ��ҹ��� ������.

```sql
SELECT EMP_ID "���� ��ȣ", EMP_NAME �̸�, SALARY "����(��)", '�� �Դϴ�' "����"
FROM EMPLOYEE;

select emp_id, emp_name, SALARY, 'Won', 'won'
from employee;
```

<BR>

<HR>

- DISTINCT: �ߺ�����
  - DISTINCT�� <B>SELECT������ �� �ѹ��� �� �� �ִ�.</B>

```sql
-- �ߺ�����1
SELECT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- �ߺ�����2
-- DEPT_CODE, JOB_CODE��� ��� �ߺ�����
SELECT DISTINCT DEPT_CODE,  JOB_CODE
FROM EMPLOYEE;

-- �����߻� : DISTINCT�� �ѹ���!
SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
FROM EMPLOYEE;
```

# WHERE
- ��ȸ�� ���̺����� ������ �´� ���� ���� ���� ��󳽴�.
- �����ڸ� ����Ͽ� ������ �����.
  - `=`: ����
  - `>`: ũ��
  - `>=`: ũ�ų� ����

  - `<`: �۴�
  - `<=`: �۰ų� ����
  - `!=`, `^=`, `<>`: �����ʴ�

```SQL
-- EMPLOYEE ���̺����� �μ��ڵ尡 'D9'�� ������ �̸� �μ��ڵ� ��ȸ
SELECT EMP_NAME ���� , DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

-- EMPLOYEE ���̺����� �μ��ڵ尡 'D9'�� �ƴ� �����̸� �μ��ڵ� ��ȸ

SELECT EMP_NAME ����, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_CODE<>'D9';
--WHERE DEPT_CODE!='D9';
--WHERE DEPT_CODE^='D9';
```