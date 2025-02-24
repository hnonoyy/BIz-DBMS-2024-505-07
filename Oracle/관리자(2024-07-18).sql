-- tableSpace 생성
-- 이름 : schoolDB
-- datafile : c:/app/data/schoolDB.dbf
-- 초기사이즈 : 1MByte
-- 자동증가 : 1KByte씩 자동으로 크기 증가

CREATE TABLESPACE schooldb
DATAFILE 'c:/app/data/schoolDB.dbf'
SIZE 1M
AUTOEXTEND ON NEXT 1K; 


-- schooluser 사용자 생성, 비밀번호 : s1234
-- DBA 권한부여
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

CREATE USER schooluser IDENTIFIED BY s1234 DEFAULT TABLESPACE schooldb;
grant dba to schooluser;

-- schooluser 사용자 접속 프로파일 만들기
-- schooluser 사용자로 접속하여 tbl_student 테이블 생성
-- 학생정보 데이터 import 