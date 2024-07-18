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