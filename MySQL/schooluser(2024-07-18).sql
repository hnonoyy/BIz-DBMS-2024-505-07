-- schoolUser 로 접속한 화면
-- 학생정보테이블명세의 학생정보 sheet 를 다음 조건으로 완성
-- 학번 : PK, 학생이름, 학과, 전화번호는 NOT NULL 로
-- 학생정보테이블명세.학생정보 sheet를 기준으로 tbl_student 테이블을 생성
USE schooldb;
CREATE TABLE tbl_student(
	st_num	VARCHAR(5)	PRIMARY KEY,
	st_name	VARCHAR(20)	NOT NULL,	
	st_dept	VARCHAR(20)	NOT NULL,	
	st_grade TINYINT,	
	st_tel	VARCHAR(20)	NOT NULL,	
	st_addr	VARCHAR(125)		
);
SELECT * FROM tbl_student;
SELECT COUNT(*) FROM tbl_student;
drop table tbl_subject;

create table tbl_subject(
	sb_code	VARCHAR(5)		PRIMARY KEY,
	sb_name	VARCHAR(20)	NOT NULL,
	sb_prof	VARCHAR(20)		
);

create table tbl_score(
	sc_stnum	VARCHAR(5)	NOT NULL,	
	sc_sbcode	VARCHAR(5)	NOT NULL,	
	sc_score	INT	NOT NULL,	
	PRIMARY KEY(sc_stnum,sc_sbcode)
);

SELECT * FROM tbl_subject;
SELECT * FROM tbl_score;
select count(*) from tbl_score;
/*
학생정보, 성적정보, 과목정보 3개의 table을 join 하여
학번 S0001 인 학생의 성적을 출력 :selection

학번, 이름, 학과, 학년, 과목코드, 과목명 점수 : projection
*/

select st_num, st_name, st_dept, st_grade, sc_sbcode, sb_name, sc_score 
from tbl_student st_stu 
left join tbl_score sc on st_stu.st_num = sc.sc_stnum
left join tbl_subject stb on sc.sc_sbcode = stb.sb_code 
where st_stu.st_num = 'S0001';

select stu.st_num as 학번 , stu.st_name as 이름, stu.st_dept as 학과, stu.st_grade as 학년, sc.sc_score as 점수
from tbl_student stu
left join tbl_score sc
on stu.st_num = sc.sc_stnum
where stu.st_num = 'S0001';
-- =======================================================================
/* 앞으로 계속 쓸거같은 정보를 view로 만들어서 사용 무조건적으로 만드는게 좋은건 아님*/
CREATE VIEW view_scores
AS
(SELECT st_num AS 학번, st_name AS 이름, 
		st_dept AS 학과, st_grade AS 학년, 
		sc_sbcode AS 과목코드, sb_name AS 과목명, sc_score AS 점수
FROM tbl_student ST
	LEFT JOIN tbl_score SC
	ON ST.st_num = SC.sc_stnum
	LEFT JOIN tbl_subject SB
	ON SC.sc_sbcode = SB.sb_code);

SELECT * 
FROM view_scores
WHERE 학번 = 'S0001';

/*
전체 학생에 대한 
각 학생의 총점을 계산하여 다음과 같이 출력

학번 이름 학과 학년 총점

함수로 구분되지않은 칼럼은 그룹으로 묶어줘라..옛날 버전은 그렇게 안하면 오류가 생김
*/

SELECT st_num as 학번, st_name as 이름, st_dept as 학과, st_grade as 학년, sum(SC.sc_score) as 총점 
FROM tbl_student ST
	LEFT JOIN tbl_score SC
	ON ST.st_num = SC.sc_stnum
GROUP BY st_num, st_name, st_dept, st_grade;

SELECT st_num as 학번, st_name as 이름, st_dept as 학과, st_grade as 학년, sum(SC.sc_score) as 총점, avg(sc_score) as 평균
FROM tbl_student ST
	LEFT JOIN tbl_score SC
	ON ST.st_num = SC.sc_stnum
GROUP BY st_num, st_name, st_dept, st_grade;

-- 위(1)의 SQL을 응용하여 각 학생의 평균이 60점 이상, 69점 이하인 학생들만 나열
-- 성적순으로 내림차순정렬

SELECT st_num AS 학번, st_name AS 이름, st_dept AS 학과, st_grade AS 학년, SUM(SC.sc_score) AS 총점, AVG(sc_score) AS 평균
FROM tbl_student ST
	LEFT JOIN tbl_score SC
	ON ST.st_num = SC.sc_stnum
GROUP BY st_num, st_name, st_dept, st_grade
HAVING 평균 BETWEEN 60 AND 69
ORDER BY 평균 DESC;

-- 위(1) SQL 을 응용하여
-- 3학년인 학생들의 학생별 총점과 평균을 구하고
-- 평균이 60 이상 69 이하인 리스트만 출력 

SELECT st_num as 학번, st_name as 이름, st_dept as 학과, st_grade as 학년, sum(SC.sc_score) as 총점, avg(sc_score) as 평균
FROM tbl_student ST
	LEFT JOIN tbl_score SC
	ON ST.st_num = SC.sc_stnum
    WHERE st_grade = 3
GROUP BY st_num, st_name, st_dept, st_grade
HAVING 평균 BETWEEN 60 AND 69;





