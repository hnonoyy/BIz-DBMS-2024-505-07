-- root 접속화면

-- MySQL의 데이터 저장소(Schema) 생성하기
create database mydb;

-- myDB 데이터 저장소 사용승인 받기(사용하기 위한 준비)
use mydb;
/*
MySQL의 데이터 칼럼 type 
문자열은 char, varchar 가 있다
char : 고정문자열, varchar(가변문자열)
한글, 영문 구분없이 같은 type으로 저장가능

정수형 TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT
	  1Byte	   2Byte 	3Byte	   4Byte 8Byte
      
실수형 FLOAT 	DOUBLE, REAL
*/
create table tbl_student (
	st_num varchar(6) primary key,
    st_name varchar(20) not null,
    st_dept varchar(20) not null,
    st_grade tinyint not null,
    st_tel varchar(20),
    st_addr varchar(125)
);
-- 시스템에 어떤 데이터베이스(저장소)가 있는가
show databases;
-- mydb 데이터베이스를 사용하겠다
use mydb;
-- mydb 데이터베이스에 어떤 테이블이 있는가
show tables;
-- tbl_student 테이블의 구조를 보고싶다(desc는 축약형)
describe tbl_student;
desc tbl_student; 

-- localhost 에서만 접근 가능한 user1 사용자를 생성
create user 'user1'@'localhost' identified by '12341234';
-- localhost 의 user1은 mydb batabase의 모든 테이블(*)에
-- crud와 테이블생성, 테이블삭제 등 모든 권한을 실행할 수 있다.
grant all privileges on mydb.* to 'user1'@'localhost' ;

drop user 'user1'@'localhost';



