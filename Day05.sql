-- CROSS INNER JOIN
-- 두 개 이상의 테이블에서 '모든 가능한 조합'을 만들어 결과를 반환하는
-- 조인 방법
-- 이를 통해 두 개 이상의 테이블을 조합하여 새로운 테이블을 만들 수 있다.
-- 두 테이블이 서로 관련 없어도 조인이 가능하다.
-- 단, 각 행의 모든 가능한 조합을 만들기 때문에 결과가 매우 큰 테이블이
-- 될 수 있으므로 주의가 필요하다.
DROP TABLE 테이블A;
DROP TABLE 테이블B;

CREATE TABLE 테이블A(
   A_id NUMBER,
   A_name varchar2(10)
);

CREATE TABLE 테이블B(
   B_id NUMBER,
   B_name varchar2(20)
);


INSERT INTO 테이블A values(1, 'John');
INSERT INTO 테이블A values(2, 'Jane');
INSERT INTO 테이블A values(3, 'Bob');

INSERT INTO 테이블B values(101, 'Apple');
INSERT INTO 테이블B values(102, 'Banana');

SELECT *
FROM 테이블A CROSS JOIN 테이블B;

-- OUTER JOIN
-- 두 테이블에서 '공통된 값을 가지지 않는 행들'도 반환한다.

-- LEFT OUTER JOIN
-- '왼쪽 테이블의 모든 행'과
-- '오른쪽 테이블과 왼쪽 테이블이 공통적으로 가지는 값'을 반환한다.
-- 교집합과 차집합의 연산 결과를 합친 것과 같다.
-- 만약 오른쪽에서 테이블에서 공통된 값을 가지고 있는 행이 없다면
-- NULL을 반환

-- 사원테이블과 부서테이블의 LEFT OUTER JOIN을 이용하여
-- 사원이 어느부서에 있는지 조회하기
SELECT E.FIRST_NAME, D.DEPARTMENT_ID
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT * FROM EMPLOYEES
WHERE FIRST_NAME = 'Kimberely';

SELECT * FROM STADIUM LEFT OUTER JOIN TEAM
ON HOMETEAM_ID = TEAM_ID;

-- RIGHT OUTER JOIN
-- LEFT OUTER JOIN의 반대
-- 공통데이터와 오른쪽 테이블에 있는 데이터를 조회
SELECT * FROM SCHEDULE S RIGHT OUTER JOIN TEAM T
ON S.STADIUM_ID = T.STADIUM_ID;

SELECT FIRST_NAME, DEPARTMENT_NAME
FROM EMPLOYEES e RIGHT OUTER JOIN DEPARTMENTS d 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- LEFT와 RIGHT중에 뭘 많이 쓸까?
-- 상황에 따라 다르다.
-- 대부분 왼쪽 테이블의 데이터를 중심으로 분석하고자 하는 경우가
-- 많기 때문에 LEFT를 더 많이 사용하는 것 같다.

-- FULL OUTER JOIN
-- 두 테이블에서 '모든값'을 반환한다.
-- 서로 공통되지 않은 부분은 NULL로 채운다.
-- 합집합의 연산과 같다.

SELECT FIRST_NAME, DEPARTMENT_NAME
FROM EMPLOYEES e FULL OUTER JOIN DEPARTMENTS d 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 부서번호, 사원명, 직업, 위치를 EMP와 DEPT테이블을 통해
-- INNER JOIN하여 조회하기
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT E.DEPTNO, E.ENAME, E.JOB, D.LOC
FROM EMP E JOIN DEPT d 
ON E.DEPTNO = D.DEPTNO
ORDER BY DEPTNO ASC;

-- PLAYER테이블, TEAM테이블에서 송종국선수가 속한 팀의 전화번호 조회하기
-- 팀 아이디, 선수 이름, 전화번호 조회
SELECT * FROM PLAYER;
SELECT * FROM TEAM t;

--SELECT P.TEAM_ID, P.PLAYER_NAME, T.TEL
--FROM PLAYER p FULL OUTER JOIN TEAM t 
--ON P.TEAM_ID = T.TEAM_ID
--WHERE PLAYER_NAME = '송종국';

SELECT P.TEAM_ID, P.PLAYER_NAME, T.TEL
FROM PLAYER p FULL OUTER JOIN TEAM t 
ON P.TEAM_ID = T.TEAM_ID AND PLAYER_NAME = '송종국';

-- JOBS테이블과 EMPLOYEES테이블에서
-- 직종번호, 직종이름, 이메일, 이름과 성(연결) 별칭(ALIAS)을 이름으로 하고
-- 조회하기
SELECT * FROM JOBS;
SELECT * FROM EMPLOYEES;
SELECT J.JOB_ID, J.JOB_TITLE, E.EMAIL, E.FIRST_NAME||' '||E.LAST_NAME "이름"
FROM JOBS j JOIN EMPLOYEES e 
ON J.JOB_ID = E.JOB_ID;

-- 비등가조인
-- 두 테이블을 결합할 때 부등호(>,<,>=,<=), BETWEEN,LIKE등
-- 다양한 비교 연산자를 통해 조인 조건을 지정하는 방식
-- 특정 값이 일정 범위내에 속하거나, 두 값 사이의 관계를
-- 비교하여 행을 결합할 때 유용하다.
SELECT * FROM SALGRADE;
SELECT * FROM EMP;

SELECT E.EMPNO, E.ENAME, S.GRADE, E.SAL
FROM SALGRADE s JOIN EMP e 
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- USING() : 중복되는 컬럼이 생길 시 맨 앞으로 출력하며
-- 중복 컬럼을 한 개만 출력한다.
SELECT * FROM EMP JOIN DEPT
USING(DEPTNO); -- ON EMP.DEPTNO = DEPT.DEPTNO;

-- dept테이블의 loc별 평균 sal를 반올림한 값과, sal의 총합을
-- 조회해주세요
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT D.LOC, ROUND(AVG(E.SAL)) "평균", SUM(E.SAL) "총합"
FROM DEPT d FULL OUTER JOIN EMP e 
ON D.DEPTNO = E.DEPTNO
GROUP BY D.LOC
ORDER BY LOC ASC;

-- Natural Join
-- 두 테이블 간의 동일한 이름을 갖는 모든 컬럼들에 대해
-- 등가조인을 수행한다.
-- 컬럼 이름 뿐만 아니라 타입도 같아야 한다.

SELECT * FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT * FROM EMP INNER JOIN DEPT
USING(DEPTNO);

SELECT * FROM EMP NATURAL JOIN DEPT;
-- 자동매칭
-- 두 테이블에서 이름이 동일한 컬럼을 찾아서, 해당 컬럼들이 값이
-- 일치하는 행끼리 자동으로 결합한다.
-- 중복 컬럼 제거
-- 조인 결과에서 공통 컬럼은 한 번만 표시된다.
-- 명시적 조건 생략
-- ON절이나 USING절 없이 간단하게 조인할 수 있다.

-- 의도하지 않은 결과가 나올 수 있다...
-- 자동으로 공통컬럼을 기준으로 조인하기 떄문에 개발자가 어떤 컬럼을
-- 기준으로 조인하는지 명확히 알기 어려울 수 있다.

-- 집합연산자
-- JOIN과는 별개로 두 개의 테이블을 합치는 방법

-- 1. UNION
-- 두 개의 테이블에서 '중복을 제거하고 합친 모든 행'을 반환

SELECT FIRST_NAME FROM EMPLOYEES
UNION
SELECT DEPARTMENT_NAME FROM DEPARTMENTS;

-- UNION ALL
-- 중복을 제거하지 않고 모두 합친 행을 반환
SELECT FIRST_NAME FROM EMPLOYEES
UNION ALL
SELECT DEPARTMENT_NAME FROM DEPARTMENTS;