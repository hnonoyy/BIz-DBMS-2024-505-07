-- 관리로 접속한 화면
/* 
현재 화면은 USERNAME : SYS, 권한 : SYSDBA 로 접속한 화면이다
SYSDBA 는 Oracle DBMS 의 매우 중요한 권한을 나타낸다.
SYSDBA는 DB를 생성하고, 제거하고 사용자를 생성하고, 제거하고 여러가지 시스템 관리를 할 수 있는 권한이다.
따라서 SYS 사용자의 비밀번호는 잘 관리되어야 한다.
*/
-- Oracle DBMS 프로젝트를 처음 시작할 때는 관리자로 접속하여 TableSpace와 User 를 생성해 주어야 한다.
-- 클라우드로 사용시 tableSpace는 의미가 없다 클라우드에서 알아서 관리를 해주기 때문에
-- TableSpace는 C:/app/data 폴더에 생성할 것

CREATE TABLESPACE student -- student 라는 이름으로 TableSpace, 데이터 저장소를 선언
DATAFILE 'C:/app/data/student.dbf' -- c:/app/data 폴더에 student.dbf 라는 이름의 파일을 생성하고 데이터 저장소로 하겠다
SIZE 1M -- Data 저장소의 공간을 1MByte 만큼 예약하겠다. SIZE 1MB 처럼 사용하면 안된다.
AUTOEXTEND ON NEXT 1K; -- 기본 저장소 공간이 거의 채워지면, 1KB 씩 자동으로 계속 늘려라

DROP TABLESPACE student -- student 라는 TableSpace 를 제거하겠다 (이렇게 하면 데이터 찌꺼기가 남는다 INCLUDING 까지 다 적어줘야함)
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

/*
TableSpace : student
데이터 파일 : c:/app/data/student.dbf
최초크기 : 2M Byte
자동증가 크기 : 2K Byte
*/

CREATE TABLESPACE student
DATAFILE 'c:/app/data/student.dbf'
SIZE 2M
AUTOEXTEND ON NEXT 2K;

-- 사용자 생성
/*
오라클 12c 이후 버전에서 user 를 생성할 때 일반적인 문자열만으로 user를 생성할 수 없다
사용자 이름 앞에 반드시 C## 이 부착된 형태로 user name 을 생성해야한다.(클라우드에서는 c## 안붙여도 가능)
이 설정은 여러가지 불편함이 발생하고
특히 java 라던가 다른 곳에서 DBMS에 접속사는 프로그래밍을 수행할 때는 문제를 일으킬 수 있다.
*/

CREATE USER C##user1 -- user1 이라는 이름으로 사용자를 생성한다.
IDENTIFIED by 1234; -- 비밀번호는 1234로 설정한다. 

DROP User C##user1 Cascade;

/*
오라클 12c 이후 버전에서 영문+숫자 형식의 일반적인 사용자 ID를 설정하기 위하여
시스템 설정을 변경한 후 명령을 실행한다.
*/
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER user1 IDENTIFIED BY 1234;
DROP USER user1 CASCADE;

/*
USER 를 생성할 때
앞에서 생상한 TableSpace 와 USER 계정을 연결해주어야만
사용자 데이터가 새로 생성한 TableSpace 에 저장된다.
*/
CREATE USER user1 IDENTIFIED BY 1234 DEFAULT TABLESPACE student;

--새로 생성된 user1은 아무런 권한이 없어서 로그인 조차 할 수 없다
-- user1에게 여러가지 권한을 부여해야만 DBMS에 접근하여 업무를 수행할 수 있다.
/*
권한 부여 정책
생성된 USER(user1) 에게 로그인, 테이블생성, CRUD, 기타 여러가지 권한을 일일이 부여하는 것이 실무상 원칙
학습하는 입장에서, 로컬에 저장된 데이터에 접근한다는 제한적인 환경에서 여러가지 권한을 일일이 부여하는 것은 
상당히 불편함과 어려움이 있다.

여기서는 user1에게 DBA 권한을 부여할 것이다
오라클에서 DBA 권한 SYSDBA 보다 조금 제한된 권한이며, 로그인, 테이블생성 제거, CRUD 등의 
업무를 모두 수행할 수 있는 권한이다.
*/















