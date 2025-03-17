SELECT * FROM ALL_INDEXES
WHERE TABLE_NAME = 'EMPLOYEES'

SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEES;

-- 자동으로 만들어진 INDEX건, 우리가 수동으로 만든 INDEX건
-- 조회할 때 사용이 되는 거라면
-- 잘 사용이 되고 있는지 확인을 해야할 필요가 있다.
-- EXPLAIN PLAN FOR
-- ORACLE 데이터베이스에서 SQL 쿼리가 실행될 때
-- 어떤 경로로 수행되는지를 미리 확인할 수 있는 명령어
-- 주요 개념
-- 실행 계획(EXPLAIN PLAN)
-- SQL 쿼리를 처리하기 위한 단계별 작업 순서를 나타낸다.
-- 테이블 스캔, 인덱스 스캔, 조인 방식이 포함된다.
-- 실제로 쿼리를 실행하지는 않고, 쿼리의 실행 경로를 분석
-- 실행 계획을 통해 쿼리 성능 개선, 인덱스 활용 여부
-- 병목 현상 등을 진단할 수 있다.
-- PLAN_TABLE
-- 실행 계획 정보는 기본적으로 PLAN_TABLE이라는 테이블에 저장된다.
-- 이후 DBMS_XPLAN.DISPLAY 함수를 이용하여 보기 쉽게 출력할 수 있다.

EXPLAIN PLAN FOR
SELECT * FROM EMPLOYEES WHERE LAST_NAME='Smith';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 사번이 150번인 사원의 급여와 같은 급여를 받는 사원들의
-- 정보를 사번, 이름, 급여 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 150);

-- 1) 사번이 150번인 사원의 급여
SELECT SALARY FROM EMPLOYEES
WHERE EMPLOYEE_ID=150; -- 10,000

-- 2) 급여가 10000인 사원의 사번, 이름, 급여순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = 10000;

-- 급여가 회사의 평균급여 이상인 사람들의 이름과 급여를 조회하세요
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY)
FROM EMPLOYEES);

-- 사번이 111번인 사원과 직종이 같고,
-- 사번이 159번인 사원의 급여보다 많이 받는 사원의
-- 사번, 이름, 직종, 급여를 조회하세요
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES
WHERE EMPLOYEE_ID = 159) AND JOB_ID = (SELECT JOB_ID FROM EMPLOYEES
WHERE EMPLOYEE_ID = 111);

SELECT JOB_ID FROM EMPLOYEES
WHERE EMPLOYEE_ID = 111; -- FI_ACCOUNT

SELECT SALARY FROM EMPLOYEES
WHERE EMPLOYEE_ID = 159; -- 8000

-- 직종별 평균급여가 Bruce보다 큰 직종만
-- 직종, 평균급여를 조회하세요

SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) > (SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Bruce');

SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Bruce' -- 6000

SELECT * FROM player;

-- PLAYER테이블에서 TEAM_ID가 'K01'인 선수중
-- POSITION이 'GK'인 선수 찾기

SELECT * FROM
(SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01')
WHERE "POSITION" = 'GK';
-- 내부 서브쿼리에서 TEAM_ID가 'K01'인 행을 먼저 선택
-- 그 결과를 기반으로 외부쿼리에서 "POSITION"이 'GK'인
-- 행을 추가로 필터링을 한다.

SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01' AND "POSITION" = 'GK';
-- 전체 테이블에 대해 두가지 조건으로 필터링한다.

-- FROM(INLINE VIEW) : 쿼리문으로 출력되는 결과를 테이블처럼 사용하겠다.
-- SELECT절(SCLA) : 하나의 컬럼처럼 사용되는 서브쿼리
-- WHERE절(SUBQUERY) : 하나의 변수처럼 사용한다.
	-- 단일행 서브쿼리 : 쿼리 결과가 단일행만 반환하는 서브쿼리
	-- 다중행 서브쿼리 : 쿼리 결과가 다중행을 리턴하는 서브쿼리
	-- 다중 컬럼 서브쿼리 : 쿼리 결과가 다중컬럼을 반환하는 서브쿼리

-- PLAYER테이블에서 전체 평균키와, 포지션별 평균키 구하기
SELECT (SELECT ROUND(AVG(HEIGHT),1)
FROM PLAYER) AS "평균키", "POSITION", ROUND(AVG(PLAYER.HEIGHT),1) AS "포지션별 평균키"
FROM PLAYER
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION";

SELECT AVG(HEIGHT) 
FROM PLAYER;

-- PLAYER 테이블에서 NICKNAME이 NULL인 선수들은
-- 정태민선수의 닉네임으로 바꾸기
SELECT NICKNAME FROM PLAYER
WHERE PLAYER_NAME = '정태민';

SELECT * FROM PLAYER;

UPDATE PLAYER SET NICKNAME = (SELECT NICKNAME FROM PLAYER
WHERE PLAYER_NAME = '정태민')
WHERE NICKNAME IS NULL;

-- EMPLOYEES테이블에서 평균 급여보다 급여가 낮은 사원들의
-- 급여를 10%인상하기
SELECT AVG(SALARY) FROM EMPLOYEES;
-- 급여가 6461보다 작은 사원들에 대해서 급여를 10% 인상
SELECT SALARY FROM EMPLOYEES;

SELECT AVG(SALARY) FROM EMPLOYEES;
-- 6461
SELECT SALARY FROM EMPLOYEES;

UPDATE EMPLOYEES SET SALARY = SALARY * 1.1
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

UPDATE EMPLOYEES SET SALARY = SALARY * 1.1
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

-- PLAYER테이블에서 평균키보다 큰 선수들을 삭제
SELECT AVG(HEIGHT) FROM PLAYER;
-- 179
SELECT * FROM PLAYER;
SELECT HEIGHT FROM PLAYER;

DELETE PLAYER
WHERE HEIGHT > (SELECT AVG(HEIGHT) FROM PLAYER) OR HEIGHT IS NULL;


-- CONCATENATION(연결) : ||

-- 사원테이블에서 사원들의 이름 연결하기
SELECT FIRST_NAME||' '||LAST_NAME "이름" FROM EMPLOYEES;


-- OO의 급여는 OO이다.
SELECT FIRST_NAME||'의 급여는 '||SALARY||'이다.' "급여" FROM EMPLOYEES;
 
-- 별칭(alias)
-- SELECT절
	-- AS 별칭
	-- 컬럼명 뒤에 한칸 띄우고 작성

-- FROM절
	-- AS 별칭
	-- 테이블명 뒤에 한칸 띄우고 작성

-- 별칭의 특징
-- 테이블에 별칭을 줘서 컬럼을 단순, 명확히 할 수 있다.
-- 현재의 select문장에서만 유효하다.
-- 테이블 별칭은 길이가 30자가지 가능하나 짧을수록 좋다.
-- from절에 테이블 별칭 설정시 해당 테이블 별칭은
-- select문장에서 테이블 이름 대신 사용할 수 있다.

SELECT
	COUNT(SALARY) AS 개수,
	MAX(SALARY) AS 최대값,
	MIN(SALARY) AS 최소값,
	SUM(SALARY) AS 합계,
	AVG(SALARY) AS 평균
FROM EMPLOYEES;

-- 두 개 이상의 테이블에서 각각의 컬럼을 조회하려고 할 때
-- 어떤 테이블에서 온 컬럼인지 확실하게 해야 할 때가 있다.

SELECT
	E.DEPARTMENT_ID,
	D.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D;

-- 사원테이블에 부서명이 없음
-- 부서테이블과 DEPARTMENT_ID로 연결

SELECT E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 부서테이블과 지역(Locations)로 부터 부서명과 city 조회하기
SELECT D.DEPARTMENT_NAME, L.CITY
FROM DEPARTMENTS D JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

-- 지역(Locations), 나라(Countries)를 조회하여
-- 도시명과 국가명을 조회

SELECT * FROM LOCATIONS;

SELECT * FROM COUNTRIES;

SELECT L.CITY, C.COUNTRY_NAME
FROM LOCATIONS L JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID;

-- 사원테이블과, JOBS테이블을 이용하여
-- 이름, 성, 직종번호, 직종이름을 조회하세요
SELECT * FROM EMPLOYEES;
SELECT * FROM JOBS;

SELECT E.FIRST_NAME||' '||E.LAST_NAME, E.JOB_ID, J.JOB_TITLE
FROM EMPLOYEES E JOIN JOBS J
ON E.JOB_ID = J.JOB_ID;