/* 
USER
--------------
ID(PK) VARCHAR2(100)
--------------
PW VARCHAR2(100)
NAME VARCHAR2(50)
ADDRESS VARCHAR2(100)
EMAIL VARCHAR2(50)
BIRTH DATE

ORDER
--------------
ORDER_NUM(PK) NUMBER
--------------
ORDER_DATE DATE
ID(FK) VARCHAR2(100)
외래키는 참조하려 하는 컬럼의 타입과 크기가 일치해야 한다.
없는 컬럼을 참조할 수 없다.
PRODUCT_NUM(FK) NUMBER

PRODUCT
--------------
PRODUCT_NUM(PK) NUMBER
--------------
PRODUCT_NAME VARCHAR2(300)
PRODUCT_PRICE NUMBER
PRODUCT_COUNT NUMBER

 */

CREATE TABLE "USER"(
	ID VARCHAR2(100) PRIMARY KEY,
	PW VARCHAR2(100),
	NAME VARCHAR2(50), -- 이름
	ADDRESS VARCHAR2(100), -- 주소
	EMAIL VARCHAR2(500),
	BIRTH DATE -- 생일
);

CREATE TABLE PRODUCT(
	PRODUCT_NUM NUMBER PRIMARY KEY, -- 상품번호
	PRODUCT_NAME VARCHAR2(300), -- 상품명
	PRODUCT_PRICE NUMBER, -- 가격
	PRODUCT_COUNT NUMBER -- 재고
);

CREATE TABLE "ORDER"(
	ORDER_NUM NUMBER PRIMARY KEY, -- 주문번호
	ORDER_DATE DATE, -- 주문일
	USER_ID VARCHAR2(100),
	PRODUCT_NUM NUMBER, -- 상품번호
	-- 외래키 설정(FOREIGN KEY)
	CONSTRAINT USER_FK FOREIGN KEY(USER_ID) REFERENCES "USER"(ID),
	CONSTRAINT PRODUCT_FK FOREIGN KEY(PRODUCT_NUM) REFERENCES PRODUCT(PRODUCT_NUM)
);

CREATE TABLE FLOWER(
	FLOWER_NAME VARCHAR2(100) PRIMARY KEY,
	FLOWER_COLOR VARCHAR2(50),
	FLOWER_PRICE NUMBER
);

CREATE TABLE JAR(
	JAR_NUM NUMBER PRIMARY KEY,
	JAR_COLOR VARCHAR2(100),
	JAR_SHAPE VARCHAR2(50),
	FLOWER_NAME VARCHAR2(100),
	CONSTRAINT FNAME_FK FOREIGN KEY(FLOWER_NAME) REFERENCES FLOWER(FLOWER_NAME)
);

SELECT JOB_TITLE FROM JOBS;

-- 사원 테이블에서 모든 내용을 조회하세요
SELECT * FROM employees;

-- 부서 테이블의 모든 정보를 조회하시오.
SELECT * FROM departments;

-- 사원테이블에서 이름(FIRST_NAME), 직종(JOB_ID), 급여(SALARY)를 조회하세요.
SELECT first_name, job_id, salary FROM employees;

-- 사원테이블에서 사번, 이름, 입사일, 급여를 조회하세요
SELECT employee_id,
	   first_name,
	   hire_date,
	   salary
FROM employees;

-- 사원테이블에서 사번, 이름, 직종, 급여, 보너스비율, 실제 보너스 금액 출력
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	JOB_ID,
	SALARY,
	COMMISSION_PCT,
	-- SELECT절에서 간단한 연산도 가능하다.
	COMMISSION_PCT * SALARY COMM
	FROM EMPLOYEES;

-- 사원테이블에서 급여가 10,000 이상인 정보를 사번, 이름, 급여순으로 조회
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	SALARY
FROM EMPLOYEES
WHERE
	SALARY >= 10000;

-- 사원테이블에서 이름 MICHAEL인 사원의 사번, 이름, 급여를 조회
-- 데이터 대소문자를 구별해서 써야한다.
-- SQL에서 문자형 데이터는 ''에 넣어야 한다.
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	SALARY
FROM EMPLOYEES
WHERE
	FIRST_NAME = 'Michael';

-- 사원테이블에서 직종이 it_prog인 사원들의 정보를
-- 사번, 이름, 직종, 급여 순으로 출력하세요
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	JOB_ID,
	SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- 사원테이블에서 급여가 10000이상 13000이하인 사원의 정보를 사원번호, 이름, 급여순으로 조회
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000 AND 13000 >= SALARY;

-- 사원테이블에서 입사일이 05년 9월 21일인 사원의 정보를 사번, 이름, 입사일순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005-09-21';

-- 사원테이블에서 직종이 SA_MAN이거나 IT_PROG인 사원들의 모든 정보를 출력하세요
SELECT * FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN' OR JOB_ID = 'IT_PROG';


-- 사원테이블에서 급여가 2200, 3200, 5000, 6800을 받는 사원의 정보를 사원번호, 이름, 직종, 급여순으로 조회하세요
SELECT employee_id, first_name, job_id, salary
FROM EMPLOYEES
WHERE SALARY = 2200 OR SALARY = 3200 OR SALARY = 5000 OR SALARY = 6800;

-- SQL 연산자
-- 1. BETWEEN 'A' AND 'B' : A와 B사이의 값을 조회할 때 사용
-- 2. IN('', '') : OR을 대신해서 사용하는 연산자
-- 3. LIKE : 유사검색

-- 사원테이블에서 06년도에 입사한 사원들의 정보를 사번, 이름, 직종, 입사일순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2006/01/01' AND '2006/12/31';

SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID IN('SA_MAN', 'IT_PROG');

SELECT employee_id, first_name, job_id, salary
FROM EMPLOYEES
WHERE SALARY IN(2200, 3200, 5000, 6800);

-- LIKE연산자 (유사 검색)
-- 쿼리문에 WHERE절에 주로 사용되며 부분적으로 일치하는 속성을 찾을 때 사용된다.
-- % : 모든값
-- _ : 하나의 값
-- EX) 'A%' : A로 시작하는 모든 값
-- '%A' : A로 끝나는 모든 값
-- '%A%' : A를 포함하고 있는 모든 값
-- '%A%B%' : A와 B를 포함하고 있는 모든 값
-- 'A_' : A로 시작하는 두글자 짜리 데이터
-- 'A__' : A로 시작하는 세글자 짜리 데이터
-- '_A' : A로 끝나는 두글자 짜리 데이터
-- '__A' : A로 끝나는 세글자 짜리 데이터
-- '_A_' : 두번째 글자가 A인 세글자 짜리 데이터

-- 사원테이블에서 사원들의 이름중 M으로 시작하는 사원들의 정보를 사번, 이름, 직종순으로 출력하세요
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE('M%');

-- 사원테이블에서 이름이 D로 끝나는 사원의 사번, 이름, 직종을 조회하세요
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%d';

-- 사원테이블에서 이름에 a가 포함되어 있는 사원의 정보를 이름, 직종순으로 조회하세요
SELECT first_name, job_id
FROM employees
WHERE first_name LIKE '%a%';

-- 이름에 소문자 o가 들어가면서 a로 끝나는 사원들의 정보를 이름, 급여순으로 조회
SELECT first_name, salary
FROM EMPLOYEES
WHERE first_name LIKE '%o%a';

-- 이름이 H로 시작하면서 6글자 이상인 사원의 정보를 사번, 이름순으로 조회하세요
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'H_____%';

-- 사원테이블에서 이름이 s가 포함되어 잇지 않은 사원들만 사번, 이름순으로 조회하세요
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME NOT LIKE '%s%';

-- or 연산자를 통해서 여러개의 like 조건을 연결할 수 있다.
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%el%' OR first_name LIKE '%en%';

-- INSERT
-- 테이블에 데이터를 추가하는 문법
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2...)
-- VALUES(값1, 값2...);

-- 성별은 'M' 또는 'W'만 들어갈 수 있다.
INSERT INTO TBL_STUDENT
(ID, NAME, MAJOR, GENDER, BIRTH)
VALUES(0, '홍길동', '컴공', 'M', TO_DATE('1980-01-02', 'YYYY-MM-DD'));

-- PK로 설정된 컬럼에는 값이 겹치거나 비워둘 수 없다.
INSERT INTO HR.TBL_STUDENT
(ID, NAME, MAJOR, GENDER, BIRTH)
VALUES(1, '허춘삼', '컴공', 'W' , TO_DATE('1980-01-02', 'YYYY-MM-DD'));

-- CHECK 제약조건으로 1980-01-01보다 나이가 많은 사람은 추가할 수 없다.
INSERT INTO HR.TBL_STUDENT
(ID, NAME, MAJOR, GENDER, BIRTH)
VALUES(2, '김마루', '컴공', 'M' , TO_DATE('2000-12-30', 'YYYY-MM-DD'));

-- 성별을 아예 생략하면 DEFAULT값인 W가 들어가게 된다.
INSERT INTO HR.TBL_STUDENT
(ID, NAME, MAJOR, BIRTH)
VALUES(3, '김마리', '컴공', TO_DATE('2000-12-30', 'YYYY-MM-DD'));

SELECT * FROM TBL_STUDENT;

-- 꽃 테이블, 화분테이블
INSERT INTO FLOWER
(FLOWER_NAME, FLOWER_COLOR, FLOWER_PRICE)
VALUES('장미꽃', '빨간색', 3000);


INSERT INTO FLOWER
(FLOWER_NAME, FLOWER_COLOR, FLOWER_PRICE)
VALUES('해바라기', '노란색', 2000);

INSERT INTO FLOWER
(FLOWER_NAME, FLOWER_COLOR, FLOWER_PRICE)
VALUES('안개꽃', '흰색', 4000);

SELECT * FROM FLOWER;

-- INSERT ALL
-- INTO 테이블명(컬럼명)VALUES(값)
-- INTO 테이블명(컬럼명)VALUES(값)
-- INTO 테이블명(컬럼명)VALUES(값)
-- INTO 테이블명(컬럼명)VALUES(값)
-- SELECT * FROM DUAL;
-- DUAL 테이블을 이용한 SELECT구문은 단일 행을 반환하여
-- 각 INTO절이 한번씩 실행되도록 한다.

-- 참조하는 테이블에 없는 데이터는 추가할 수 없다.
INSERT INTO HR.JAR
(JAR_NUM, JAR_COLOR, JAR_SHAPE, FLOWER_NAME)
VALUES('202503130001', '검은색', '타원형', '장미꽃');

INSERT INTO HR.JAR
(JAR_NUM, JAR_COLOR, JAR_SHAPE, FLOWER_NAME)
VALUES(202503130002, '은색', '동그라미', '장미꽃');


INSERT INTO HR.JAR
(JAR_NUM, JAR_COLOR, JAR_SHAPE, FLOWER_NAME)
VALUES(202503130003, '흰색', '네모', '해바라기');

SELECT * FROM JAR;

ALTER TABLE JAR MODIFY JAR_NUM VARCHAR2(50);

-- DELETE(삭제)
-- DELETE FROM 테이블명 WHERE 조건;

-- 외래키로 참조되고 있을 때 자식테이블에서 참조되고 있는 행을 먼저 삭제해야 부모테이블에서 삭제할 수 있다.
DELETE FROM JAR WHERE FLOWER_NAME = '해바라기';
DELETE FROM FLOWER WHERE FLOWER_NAME = '해바라기';

-- DELETE문에 조건을 쓰지 않으면 의도하지 않게 모든 데이터가 날아갈 수 있다.
DELETE FROM JAR;

SELECT * FROM JAR;

-- UPDATE(수정하기)
-- UPDATE 테이블명
-- SET 컬럼명 = '변경값'
-- WHERE 조건식

-- TBL_STUDENT테이블에서 홍길동의 전공을 경영학과로 수정
UPDATE TBL_STUDENT
SET MAJOR = '경영학과'
WHERE NAME LIKE('홍길동');

SELECT * FROM TBL_STUDENT;


-- 테이블 사이에는 관계라는 개념이 존재하고
-- 일대일(1:1), 일대다(1:N), 다대다(N:M)의 관계가 있다.

-- 일대일 관계
-- 두 테이블 A와 B가 있을 때 A의 정보와 B의 정보 하나가 연결된 관계
-- 한 사람은 하나의 여권만 소지할 수 있고, 하나의 여권은 한 사람에게만 발급된다.

-- 일대다 관계
-- 테이블 A의 레코드(행) 하나가 B의 여러 행과 연결되는 관계
-- 한 사람이 여러개의 부동산을 가질 수 있다.
-- 집은 주인이 한명이다.

-- 다대다 관계
-- 테이블 A의 행 하나가 테이블 B의 행 여러개와,
-- 테이블 B의 행 하나가 테이블 A의 행 여러개와 연결된 관계
-- 학생과 강의의 관계
-- 한 학생이 여러강의를 수강할 수 있다.
-- 하나의 강의는 여러 학생들이 들을 수 있다.
-- 다대다 관계는 두개의 테이블 사이에서 직접 구현할 수 없으므로 연결 테이블을 사용하여 테이블 A와 B를 연결한다.
-- 연결 테이블은 두 테이블의 기본키를 외래키로 포함하며, 복합 기본키로 지정하는 경우가 많다.

/* CD 테이블
- TITLE(PK) VARCHAR2(100) -> 타이틀
- PRICE NUMBER -> 가격
- GENRE VARCHAR2(50) -> 장르
- TRACKLIST VARCHAR2(100) -> 트랙리스트
- ARTISTNAME(FK) VARCHAR2(100) -> 이름(Artist)
====================
Artist테이블
- NAME(PK) VARCHAR2(100) -> 이름
- COUNTRY VARCHAR2(100) -> 국적
- DEBUTYEAR DATE -> 데뷔년도
=====================
Track 테이블
- Title(PK) VARCHAR2(100) -> 타이틀
- RunningTime VARCHAR2(100) -> 러닝타임
- CDTitle(FK) VARCHAR2(100) -> 타이틀(CD)
*/

CREATE TABLE Artist(
	NAME VARCHAR2(100) PRIMARY KEY,
	COUNTRY VARCHAR2(100),
	DEBUTYEAR DATE
);

CREATE TABLE CD(
	TITLE VARCHAR2(100) PRIMARY KEY,
	PRICE NUMBER,
	GENRE VARCHAR2(50),
	TRACKLIST VARCHAR2(100),
	ARTIST_NAME VARCHAR2(100),
	CONSTRAINT ARTISTNAME_FK FOREIGN KEY(ARTIST_NAME) REFERENCES Artist(NAME)
);

CREATE TABLE TRACK(
	TITLE VARCHAR2(100) PRIMARY KEY,
	RUNNINGTIME VARCHAR2(100),
	CD_TITLE VARCHAR(100),
	CONSTRAINT CD_TITLE_FK FOREIGN KEY(CD_TITLE) REFERENCES CD(TITLE)
);

SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN('10', '30') AND SALARY > 1500;

SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN('IT_PROG', 'SA_MAN') AND SALARY NOT IN(1000, 3000, 5000);