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

쿼리3
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