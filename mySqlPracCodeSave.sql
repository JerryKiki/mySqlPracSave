쿼리1 (0705)

DESCRIBE article;
# 나머지 칼럼 모두에도 not null을 적용해주세요.
ALTER TABLE article MODIFY COLUMN regDate DATETIME NOT NULL;
ALTER TABLE article MODIFY COLUMN title CHAR(100) NOT NULL;
ALTER TABLE article MODIFY COLUMN `body` TEXT NOT NULL;
# id 칼럼에 UNSIGNED 속성을 추가하세요.
ALTER TABLE article MODIFY COLUMN id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;
# 작성자(writer) 칼럼을 title 칼럼 다음에 추가해주세요.
ALTER TABLE article ADD COLUMN writer CHAR(100) AFTER title;
# 작성자(writer) 칼럼의 이름을 nickname 으로 변경해주세요.(ALTER TABLE article CHANGE oldName newName TYPE 조건)
ALTER TABLE article CHANGE COLUMN `writer` `nickname` CHAR(100);
# nickname 칼럼의 위치를 body 밑으로 보내주세요.(MODIFY COLUMN nickname)
ALTER TABLE article MODIFY COLUMN `nickname` CHAR(100) AFTER `body`;
SELECT * FROM article;
# hit 조회수 칼럼 추가 한 후 삭제해주세요.
ALTER TABLE article ADD COLUMN `hit` INT(10);
ALTER TABLE article DROP COLUMN `hit`;
# hit 조회수 칼럼을 다시 추가
ALTER TABLE article ADD COLUMN `hit` INT(10);
# 기존의 비어있는 닉네임 채워넣기(무명)
UPDATE article
SET nickname = '무명';
SELECT * FROM article;
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목3', body = '내용3', nickname = '홍길순', hit = 10)
INSERT INTO article
SET regDate = NOW(),
title = '제목3',
`body` = '내용3',
nickname = '홍길순',
hit = 10;
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목4', body = '내용4', nickname = '홍길동', hit = 55)
INSERT INTO article
SET regDate = NOW(),
title = '제목4',
`body` = '내용4',
nickname = '홍길동',
hit = 55;
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목5', body = '내용5', nickname = '홍길동', hit = 10)
INSERT INTO article
SET regDate = NOW(),
title = '제목5',
`body` = '내용5',
nickname = '홍길동',
hit = 10;
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목6', body = '내용6', nickname = '임꺽정', hit = 100)
INSERT INTO article
SET regDate = NOW(),
title = '제목6',
`body` = '내용6',
nickname = '임꺽정',
hit = 100;

INSERT INTO article
SET regDate = NOW(),
title = '제목7',
`body` = '내용7',
nickname = '홍길순순',
hit = 20;
# 조회수 가장 많은 게시물 3개 만 보여주세요., 힌트 : ORDER BY, LIMIT
SELECT * FROM article ORDER BY hit DESC LIMIT 3;
SELECT * FROM article ORDER BY hit ASC LIMIT 3;
# 작성자명이 '홍길'로 시작하는 게시물만 보여주세요., 힌트 : LIKE '홍길%'
SELECT * FROM article WHERE `nickname` LIKE '홍길%';
# 조회수가 10 이상 55 이하 인것만 보여주세요., 힌트 : WHERE 조건1 AND 조건2
SELECT * FROM article WHERE `hit` >= 10 AND `hit` <= 55;
# 작성자가 '무명'이 아니고 조회수가 50 이하인 것만 보여주세요., 힌트 : !=
SELECT * FROM article WHERE `hit` <= 50 AND `nickname` != '무명';
# 작성자가 '무명' 이거나 조회수가 55 이상인 게시물을 보여주세요. 힌트 : OR
SELECT * FROM article WHERE `hit` >= 55 OR `nickname` = '무명';

########################################

# 쿼리3 (0710)
# a5 데이터베이스 삭제/생성/선택
DROP DATABASE IF EXISTS `a5`;
CREATE DATABASE `a5`;
USE `a5`;
# 부서(dept) 테이블 생성 및 홍보부서 기획부서 추가
CREATE TABLE 부서(
                   부서명 CHAR(20)
);
INSERT INTO 부서
SET 부서명 = '홍보';
INSERT INTO 부서
SET 부서명 = '기획';
# 사원(emp) 테이블 생성 및 홍길동사원(홍보부서), 홍길순사원(홍보부서), 임꺽정사원(기획부서) 추가
CREATE TABLE 사원(
                   부서 CHAR(20),
                   성명 CHAR(20)
);
INSERT INTO 사원
SET 부서 = '홍보',
성명 = '홍길동';
INSERT INTO 사원
SET 부서 = '홍보',
성명 = '홍길순';
INSERT INTO 사원
SET 부서 = '기획',
성명 = '임꺽정';

SELECT * FROM 사원;
SELECT * FROM 부서;

# 홍보를 마케팅으로 변경
UPDATE 부서
SET 부서명 = '마케팅'
WHERE 부서명 = '홍보';
UPDATE 사원
SET 부서 = '마케팅'
WHERE 부서 = '홍보';
# 마케팅을 홍보로 변경
UPDATE 부서
SET 부서명 = '홍보'
WHERE 부서명 = '마케팅';
UPDATE 사원
SET 부서 = '홍보'
WHERE 부서 = '마케팅';
# 홍보를 마케팅으로 변경
# 구조를 변경하기로 결정(사원 테이블에서, 이제는 부서를 이름이 아닌 번호로 기억)
ALTER TABLE 부서 ADD COLUMN 번호 INT(10) FIRST;
UPDATE 부서
SET 번호 = 1
WHERE 부서명 = '마케팅';
UPDATE 부서
SET 번호 = 2
WHERE 부서명 = '기획';
ALTER TABLE 사원 CHANGE COLUMN `부서` `번호` INT(10);
UPDATE 사원
SET `번호` = 1
WHERE 성명 LIKE '홍길%';
UPDATE 사원
SET `번호` = 2
WHERE 성명 = '임꺽정';
# 사장님께 드릴 인명록을 생성
SELECT * FROM 사원;
# 사장님께서 부서번호가 아니라 부서명을 알고 싶어하신다.
# 그래서 dept 테이블 조회법을 알려드리고 혼이 났다.
SELECT * FROM 부서;
ALTER TABLE 사원 CHANGE COLUMN `번호` `부서번호` INT(10);
ALTER TABLE 사원 ADD COLUMN `번호` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT FIRST;
DESC 사원;
ALTER TABLE 부서 CHANGE COLUMN `번호` `부서번호` INT(10);
ALTER TABLE 부서 MODIFY COLUMN `부서번호` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
# 사장님께 드릴 인명록을 생성(v2, 부서명 포함, ON 없이)
# 이상한 데이터가 생성되어서 혼남
SELECT * FROM 사원 AS p INNER JOIN 부서;
# 사장님께 드릴 인명록을 생성(v3, 부서명 포함, 올바른 조인 룰(ON) 적용)
# 보고용으로 좀 더 편하게 보여지도록 고쳐야 한다고 지적받음
SELECT * FROM 사원 AS p INNER JOIN 부서 AS t ON p.부서번호 = t.부서번호;
# 사장님께 드릴 인명록을 생성(v4, 사장님께서 보시기에 편한 칼럼명(AS))
SELECT p.번호 AS 사원번호, p.성명, t.부서명, p.부서번호 FROM 사원 AS p INNER JOIN 부서 AS t ON p.부서번호 = t.부서번호;
SELECT p.번호, p.성명, t.부서번호, t.부서명 FROM 사원 AS p INNER JOIN 부서 AS t ON p.부서번호 = t.부서번호;
SELECT p.번호 AS 사원번호, p.성명, t.부서명 FROM 사원 AS p INNER JOIN 부서 AS t ON p.부서번호 = t.부서번호;

########################################

쿼리4 (0710) : 쇼핑몰 문제풀이1
#1번 방식으로 문제풀이

DROP DATABASE IF EXISTS mall;

CREATE DATABASE mall;

USE mall;

CREATE TABLE t_shopping(
                           id INT(5) PRIMARY KEY AUTO_INCREMENT,
                           userId CHAR(30) NOT NULL,
                           userPw CHAR(30) NOT NULL,
                           userName CHAR(30) NOT NULL,
                           address CHAR(50) NOT NULL,
                           pname CHAR(50) NOT NULL,
                           price INT(5) NOT NULL
);

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
address = '서울',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
address = '대전',
pname = '반바지',
price = 30000;

INSERT INTO t_shopping
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '대구',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '티셔츠',
price = 9000;

INSERT INTO t_shopping
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '운동화',
price = 200000;

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '울산',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '모자',
price = 30000;

##################################

SHOW TABLES;
SELECT * FROM t_shopping;

##################################

# 1. 손흥민의 주문 개수는?
SELECT COUNT(*) AS '손흥민의 주문 개수'
FROM t_shopping
WHERE userName = '손흥민';


# 2. 손흥민이 산 상품은?
SELECT userName AS '구매자', pname AS '구매 상품'
FROM t_shopping
WHERE userName = '손흥민';


# 3. 스커트를 산 사람은?
SELECT userName AS '구매자', pname AS '구매 상품'
FROM t_shopping
WHERE pname = '스커트';

# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는?
SELECT
    userId AS '아이디',
        userName AS '구매자',
        COUNT(userName) AS '구매횟수'
FROM t_shopping
GROUP BY userName
ORDER BY '구매횟수'
    LIMIT 1;

# 5. 소지섭이 사용한 총 금액은? ???
SELECT
    userId AS '아이디',
        userName AS '구매자',
        SUM(price) AS '총 금액'
FROM t_shopping
WHERE userName = '소지섭';

######################################################

# 쿼리 5 (0710) 쇼핑몰 문제풀이 2

#2번 방식으로 문제풀이

DROP DATABASE IF EXISTS mall;

CREATE DATABASE mall;

USE mall;

CREATE TABLE t_order(
                        id INT(5) PRIMARY KEY AUTO_INCREMENT,
                        userNo INT(5) NOT NULL,
                        productNo INT(5) NOT NULL
);

CREATE TABLE t_user(
                       id INT(5) PRIMARY KEY AUTO_INCREMENT,
                       userId CHAR(200) NOT NULL,
                       userPw CHAR(200) NOT NULL,
                       userName CHAR(50) NOT NULL,
                       addr CHAR(200) NOT NULL
);

CREATE TABLE t_product(
                          id INT(5) PRIMARY KEY AUTO_INCREMENT,
                          pname CHAR(100) NOT NULL,
                          price INT(10) NOT NULL
);


INSERT INTO t_product
SET pname = '운동화',
price = 1000000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '반바지',
price = 30000;

INSERT INTO t_product
SET pname = '스커트',
price = 15000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '티셔츠',
price = 9000;

INSERT INTO t_product
SET pname = '운동화',
price = 200000;

INSERT INTO t_product
SET pname = '모자',
price = 30000;



INSERT INTO t_user
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
addr = '런던';

INSERT INTO t_user
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
addr = '서울';

INSERT INTO t_user
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
addr = '대전';

INSERT INTO t_user
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
addr = '대구';

INSERT INTO t_user
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
addr = '부산';

INSERT INTO t_user
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
addr = '울산';


INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 2,
productNo = 2;

INSERT INTO t_order
SET userNo = 3,
productNo = 3;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 5,
productNo = 5;

INSERT INTO t_order
SET userNo = 6,
productNo = 6;

INSERT INTO t_order
SET userNo = 6,
productNo = 7;

INSERT INTO t_order
SET userNo = 1,
productNo = 5;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 5,
productNo = 8;

######################################
SHOW TABLES;
SELECT * FROM t_order;
SELECT * FROM t_product;
SELECT * FROM t_user;

# 1. 손흥민의 주문 개수는? ???
SELECT t_order.userNo, t_user.userId, t_user.userName, COUNT(*) AS '구매횟수'
FROM t_order
         INNER JOIN t_user
                    ON t_order.userNo = t_user.id
WHERE t_user.userName = '손흥민';


# 2. 손흥민이 산 상품은? ???
SELECT t_order.id AS '주문번호', t_user.userName AS '주문자', t_product.pname AS '상품명'
FROM t_order
         INNER JOIN t_product
                    ON t_order.productNo = t_product.id
         INNER JOIN t_user
                    ON t_order.userNo = t_user.id
WHERE t_user.userName = '손흥민';

# 3. 스커트를 산 사람은? ???
SELECT t_order.id AS '주문번호', t_product.pname AS '상품명', t_user.userName AS '주문자'
FROM t_order
         INNER JOIN t_product
                    ON t_order.productNo = t_product.id
         INNER JOIN t_user
                    ON t_order.userNo = t_user.id
WHERE t_product.pname = '스커트';


# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는? ???
SELECT t_user.userId, t_user.userName, COUNT(*)
FROM t_user
         INNER JOIN t_order
                    ON t_order.userNo = t_user.id
WHERE t_user.userName = '손흥민';

# 5. 소지섭이 사용한 총 금액은? ???
SELECT t_order.id, t_user.userId, t_user.userName, SUM(t_product.price) AS '사용금액'
FROM t_order
         INNER JOIN t_user
                    ON t_order.userNo = t_user.id
         INNER JOIN t_product
                    ON t_order.productNo = t_product.id
WHERE t_user.userName = '소지섭';

######################################################

#0711 SUM, MAX, MIN, COUNT 문제풀이

# a6 DB 삭제/생성/선택
DROP DATABASE IF EXISTS `a6`;
CREATE DATABASE a6;
USE a6;
# 부서(홍보, 기획)
CREATE TABLE dept(
                     id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                     regDate DATETIME,
                     `name` CHAR(100)
);
INSERT INTO dept
SET regDate = NOW(),
	`name` = '홍보';
INSERT INTO dept
SET regDate = NOW(),
	`name` = '기획';
SELECT * FROM dept;
# 사원(홍길동/홍보/5000만원, 홍길순/홍보/6000만원, 임꺽정/기획/4000만원)
CREATE TABLE emp(
                    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    regDate DATETIME,
                    `name` CHAR(100),
                    deptId INT(10),
                    wage INT(100) UNSIGNED
);
INSERT INTO emp
SET regDate = NOW(),
	`name` = '홍길동',
	deptId = 1,
	wage = 5000;
INSERT INTO emp
SET regDate = NOW(),
	`name` = '홍길순',
	deptId = 1,
	wage = 6000;
INSERT INTO emp
SET regDate = NOW(),
	`name` = '임꺽정',
	deptId = 2,
	wage = 4000;
SELECT * FROM emp;
# 사원 수 출력
SELECT COUNT(*) AS '사원 수'
FROM emp;
# 가장 큰 사원 번호 출력
SELECT MAX(id) AS '가장 큰 사원 번호'
FROM emp;
# 가장 고액 연봉
SELECT MAX(wage) AS '가장 고액 연봉'
FROM emp;
# 가장 저액 연봉
SELECT MIN(wage) AS '가장 저액 연봉'
FROM emp;
# 회사에서 1년 고정 지출(인건비)
SELECT CONCAT(SUM(wage), '만원') AS '회사 고정 지출'
FROM emp;
# 부서별, 1년 고정 지출(인건비)
SELECT dept.`name`, CONCAT(SUM(emp.wage), '만원') AS '부서별 고정 지출'
FROM emp
         INNER JOIN dept
                    ON emp.deptId = dept.id
GROUP BY deptId;
# 부서별, 최고연봉
SELECT dept.`name`, CONCAT(MAX(emp.wage), '만원') AS '부서별 최고 연봉'
FROM emp
         INNER JOIN dept
                    ON emp.deptId = dept.id
GROUP BY deptId;
# 부서별, 최저연봉
SELECT dept.`name`, CONCAT(MIN(emp.wage), '만원') AS '부서별 최저 연봉'
FROM emp
         INNER JOIN dept
                    ON emp.deptId = dept.id
GROUP BY deptId;
# 부서별, 평균연봉
SELECT dept.`name`, CONCAT(ROUND(AVG(emp.wage)), '만원') AS '부서별 평균 연봉'
FROM emp
         INNER JOIN dept
                    ON emp.deptId = dept.id
GROUP BY deptId;
# 부서별, 부서명, 사원리스트, 평균연봉, 최고연봉, 최소연봉, 사원수
## V1(조인 안한 버전)
SELECT
    deptId,
    GROUP_CONCAT(`name`) AS '사원리스트',
        CONCAT(ROUND(AVG(wage)), '만원') AS '평균연봉',
        CONCAT(MAX(wage), '만원') AS '최고연봉',
        CONCAT(MIN(wage), '만원') AS '최소연봉',
        CONCAT(COUNT(id), '명') AS '사원 수'
FROM emp
GROUP BY deptId;
## V2(조인해서 부서명까지 나오는 버전)
SELECT
    dept.`name` AS '부서명',
        GROUP_CONCAT(emp.`name`) AS '사원리스트',
        CONCAT(ROUND(AVG(emp.wage)), '만원') AS '평균연봉',
        CONCAT(MAX(emp.wage), '만원') AS '최고연봉',
        CONCAT(MIN(emp.wage), '만원') AS '최소연봉',
        CONCAT(COUNT(emp.id), '명') AS '사원 수'
FROM emp
         INNER JOIN dept
                    ON emp.deptId = dept.id
GROUP BY deptId;
## V3(V2에서 평균연봉이 5000이상인 부서로 추리기)
SELECT
    dept.`name` AS '부서명',
        GROUP_CONCAT(emp.`name`) AS '사원리스트',
        CONCAT(ROUND(AVG(emp.wage)), '만원') AS '평균연봉',
        CONCAT(MAX(emp.wage), '만원') AS '최고연봉',
        CONCAT(MIN(emp.wage), '만원') AS '최소연봉',
        CONCAT(COUNT(emp.id), '명') AS '사원 수'
FROM emp
         INNER JOIN dept
                    ON emp.deptId = dept.id
GROUP BY deptId
HAVING AVG(emp.wage) >= 5000;
## V4(V3에서 HAVING 없이 서브쿼리로 수행)
### HINT, UNION을 이용한 서브쿼리
# SELECT *
                # FROM (
                           #     select 1 AS id
#     union
#     select 2
#     UNION
#     select 3
# ) AS A
SELECT
    `부서명`,
    `사원리스트`,
    CONCAT(`평균연봉`, '만원') AS '평균연봉',
        `최고연봉`,
    `최소연봉`,
    `사원 수`
FROM (
         SELECT
             dept.`name` AS `부서명`,
             GROUP_CONCAT(emp.`name`) AS `사원리스트`,
             ROUND(AVG(emp.wage)) AS `평균연봉`,
             CONCAT(MAX(emp.wage), '만원') AS `최고연봉`,
             CONCAT(MIN(emp.wage), '만원') AS `최소연봉`,
             CONCAT(COUNT(emp.id), '명') AS `사원 수`
         FROM emp
                  INNER JOIN dept
                             ON emp.deptId = dept.id
         GROUP BY deptId
     ) AS a
WHERE a.`평균연봉` >= 5000;

###################################################################

#0711 SCOTT 문제풀이 1, 2, 3

DROP DATABASE IF EXISTS scott;

CREATE DATABASE scott;

USE scott;

CREATE TABLE DEPT (
                      DEPTNO DECIMAL(2),
                      DNAME VARCHAR(14),
                      LOC VARCHAR(13),
                      CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)
);
CREATE TABLE EMP (
                     EMPNO DECIMAL(4),
                     ENAME VARCHAR(10),
                     JOB VARCHAR(9),
                     MGR DECIMAL(4),
                     HIREDATE DATE,
                     SAL DECIMAL(7,2),
                     COMM DECIMAL(7,2),
                     DEPTNO DECIMAL(2),
                     CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
                     CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);
CREATE TABLE SALGRADE (
                          GRADE TINYINT,
                          LOSAL SMALLINT,
                          HISAL SMALLINT
);
INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-2-1981','%d-%m-%Y'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,STR_TO_DATE('13-7-1987','%d-%m-%Y')-85,3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,STR_TO_DATE('17-11-1981','%d-%m-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,STR_TO_DATE('8-9-1981','%d-%m-%Y'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,STR_TO_DATE('13-7-1987', '%d-%m-%Y'),1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,STR_TO_DATE('3-12-1981','%d-%m-%Y'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,STR_TO_DATE('3-12-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,STR_TO_DATE('23-1-1982','%d-%m-%Y'),1300,NULL,10);
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);


#1. 사원 테이블의 모든 레코드를 조회하시오.
SHOW TABLES;
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;

#2. 사원명과 입사일을 조회하시오.
SELECT ENAME, HIREDATE
FROM EMP;

#3. 사원번호와 이름을 조회하시오.
SELECT EMPNO, ENAME
FROM EMP;

#4. 사원테이블에 있는 직책의 목록을 조회하시오. (hint : distinct, group by)
SELECT DISTINCT JOB
FROM EMP;
SELECT JOB
FROM EMP
GROUP BY JOB;

#5. 총 사원수를 구하시오. (hint : count)
SELECT COUNT(*) AS '총 사원 수'
FROM EMP;

#6. 부서번호가 10인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE DEPTNO = 10;

#7. 월급여가 2500이상 되는 사원을 조회하시오.
SELECT *
FROM EMP
WHERE SAL >= 2500;

#8. 이름이 'KING'인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE ENAME = 'KING';

#9. 사원들 중 이름이 S로 시작하는 사원의 사원번호와 이름을 조회하시오. (hint : like)
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE 'S%';

#10. 사원 이름에 T가 포함된 사원의 사원번호와 이름을 조회하시오. (hint : like)
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%T%';

#11. 커미션이 300, 500, 1400 인 사원의 사번,이름,커미션을 조회하시오. (hint : OR, in )
SELECT EMPNO, ENAME, COMM
FROM EMP
WHERE COMM IN (300, 500, 1400);

SELECT EMPNO, ENAME, COMM
FROM EMP
WHERE COMM = 300 OR COMM = 500 OR COMM = 1400;

#12. 월급여가 1200 에서 3500 사이의 사원의 사번,이름,월급여를 조회하시오. (hint : AND, between)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL BETWEEN 1200 AND 3500;

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL >= 1200 AND SAL <= 3500;

#13. 직급이 매니저이고 부서번호가 30번인 사원의 이름,사번,직급,부서번호를 조회하시오.
SELECT ENAME, EMPNO, JOB, DEPTNO
FROM EMP
WHERE JOB = 'MANAGER' AND DEPTNO = 30;

#14. 부서번호가 30인 아닌 사원의 사번,이름,부서번호를 조회하시오. (not)
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE NOT DEPTNO = 30;

#15. 커미션이 300, 500, 1400 이 모두 아닌 사원의 사번,이름,커미션을 조회하시오. (hint : not in)
SELECT EMPNO, ENAME, COMM
FROM EMP
WHERE NOT COMM IN (300, 500, 1400);

#16. 이름에 S가 포함되지 않는 사원의 사번,이름을 조회하시오. (hint : not like)
SELECT EMPNO, ENAME
FROM EMP
WHERE NOT ENAME LIKE '%S%';

#17. 급여가 1200보다 미만이거나 3700 초과하는 사원의 사번,이름,월급여를 조회하시오. (hint : not, between)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE NOT SAL BETWEEN 1200 AND 3700;

#18. 직속상사가 NULL 인 사원의 이름과 직급을 조회하시오. (hint : is null, is not null)
SELECT * FROM EMP;

SELECT ENAME, JOB
FROM EMP
WHERE MGR IS NULL;

#19. 부서별 평균월급여를 구하는 쿼리 (hint : group by, avg())
SELECT AVG(EMP.SAL) AS '부서별 평균월급여', EMP.DEPTNO, DEPT.DNAME
FROM EMP
         INNER JOIN DEPT
                    ON EMP.DEPTNO = DEPT.DEPTNO
GROUP BY DEPTNO;

#20. 부서별 전체 사원수와 커미션을 받는 사원들의 수를 구하는 쿼리 (hint : group by, count())
SELECT COUNT(*) AS '부서별 사원수', COUNT(EMP.COMM) AS '커미션 받는 직원 수', EMP.DEPTNO, DEPT.DNAME
FROM EMP
         INNER JOIN DEPT
                    ON EMP.DEPTNO = DEPT.DEPTNO
GROUP BY EMP.DEPTNO;

#21. 부서별 최대 급여와 최소 급여를 구하는 쿼리 (hint : group by, min(), max())
SELECT MAX(EMP.SAL) AS '최대 급여',  MIN(EMP.SAL) AS '최소 급여', EMP.DEPTNO, DEPT.DNAME
FROM EMP
         INNER JOIN DEPT
                    ON EMP.DEPTNO = DEPT.DEPTNO
GROUP BY EMP.DEPTNO;

#22. 부서별로 급여 평균 (단, 부서별 급여 평균이 2000 이상만) (hint : group by, having)
SELECT AVG(EMP.SAL) AS '급여 평균', DEPT.DNAME AS '급여 평균 2000 이상 부서'
FROM EMP
         INNER JOIN DEPT
                    ON EMP.DEPTNO = DEPT.DEPTNO
GROUP BY EMP.DEPTNO
HAVING AVG(EMP.SAL) >= 2000;

#23. 월급여가 1000 이상인 사원만을 대상으로 부서별로 월급여 평균을 구하라. 단, 평균값이 2000 이상인 레코드만 구하라. (hint : group by, having)
SELECT AVG(EMP.SAL) AS '월급여 1000 이상 사원의 급여 평균', DEPT.DNAME
FROM EMP
         INNER JOIN DEPT
                    ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.SAL >= 1000
GROUP BY EMP.DEPTNO
HAVING AVG(EMP.SAL) >= 2000;

#24. 사원명과 부서명을 조회하시오. (hint : inner join)
SELECT EMP.ENAME, DEPT.DNAME
FROM EMP
         INNER JOIN DEPT
                    ON EMP.DEPTNO = DEPT.DEPTNO;

#25. 이름,월급여,월급여등급을 조회하시오. (hint : inner join, between)
SELECT * FROM SALGRADE;
SELECT * FROM EMP;

SELECT EMP.ENAME, EMP.SAL, SALGRADE.GRADE
FROM EMP
         INNER JOIN SALGRADE
                    ON EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL
ORDER BY SALGRADE.GRADE;

#26. 이름,부서명,월급여등급을 조회하시오.
SELECT EMP.ENAME, DEPT.DNAME, SALGRADE.GRADE
FROM EMP
INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO
INNER JOIN SALGRADE
ON EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL
ORDER BY SALGRADE.GRADE;

#27. 이름,직속상사이름을 조회하시오. (hint : self join
#확인용
SELECT E1.EMPNO AS '사번', E1.ENAME AS '성명', E1.MGR AS '직속상사 사번', E2.ENAME AS '직속상사'
FROM EMP AS E1
INNER JOIN EMP AS E2
ON E1.MGR = E2.EMPNO
ORDER BY E1.EMPNO;
#정답
SELECT E1.ENAME AS '성명', E2.ENAME AS '직속상사'
FROM EMP AS E1
INNER JOIN EMP AS E2
ON E1.MGR = E2.EMPNO
ORDER BY E1.EMPNO;

#28. 이름,직속상사이름을 조회하시오.(단 직속 상사가 없는 사람도 직속상사 결과가 null값으로 나와야 함) (hint : outer join)
###외부OUTER 조인. A LEFT JOIN B는 조인 조건에 만족하지 못하더라도 왼쪽 테이블 A의 행을 나타내고 싶을 때 사용한다.
###반대로 A RIGHT JOIN B는 조인 조건에 만족하지 못하더라도 오른쪽 테이블 B의 행을 나타내고 싶을 때 사용한다.
SELECT E1.ENAME AS '성명', E2.ENAME AS '직속상사'
FROM EMP AS E1
LEFT JOIN EMP AS E2
ON E1.MGR = E2.EMPNO
ORDER BY E1.EMPNO;

#29. 이름,부서명을 조회하시오.단, 사원테이블에 부서번호가 40에 속한 사원이 없지만 부서번호 40인 부서명도 출력되도록 하시오. (hint : outer join)
SELECT * FROM DEPT;
SELECT EMP.ENAME, DEPT.DEPTNO, DEPT.DNAME
FROM EMP
RIGHT JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

#서브 쿼리는 SELECT 문 안에서 ()로 둘러싸인 SELECT 문을 말하며 쿼리문의 결과를 메인 쿼리로 전달하기 위해 사용된다.
#사원명 'JONES'가 속한 부서명을 조회하시오.
#부서번호를 알아내기 위한 쿼리가 서브 쿼리로 사용.
SELECT JONES.ENAME, JONES.DEPTNO, DEPT.DNAME
FROM (
	SELECT ENAME, DEPTNO
	FROM EMP
	WHERE ENAME = 'JONES'
) AS JONES
INNER JOIN DEPT
ON JONES.DEPTNO = DEPT.DEPTNO;

#30. 10번 부서에서 근무하는 사원의 이름과 10번 부서의 부서명을 조회하시오. (hint : sub query)
SELECT DEPT10.ENAME, DEPT.DNAME
FROM (
	SELECT ENAME, DEPTNO
	FROM EMP
	WHERE DEPTNO = 10
) AS DEPT10
INNER JOIN DEPT
ON DEPT10.DEPTNO = DEPT.DEPTNO;

#31. 평균 월급여보다 더 많은 월급여를 받은 사원의 사원번호,이름,월급여 조회하시오. (hint : sub query)
SELECT EMP.EMPNO, EMP.ENAME, EMP.SAL
FROM EMP
INNER JOIN (
	SELECT AVG(SAL) AS `평균 월급여`
	FROM EMP
) AS AVGSAL
ON EMP.SAL > AVGSAL.`평균 월급여`;

#32. 부서번호가 10인 사원중에서 최대급여를 받는 사원의 사원번호, 이름을 조회하시오. (hint : sub query)
SELECT EMP.EMPNO, EMP.ENAME
FROM EMP
INNER JOIN (
	SELECT MAX(SAL) AS `최대급여`
	FROM EMP
	WHERE DEPTNO = 10
) AS MAXIN10
ON MAXIN10.`최대급여` = EMP.SAL;

SELECT * FROM EMP;