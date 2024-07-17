-- 여기는 USER1 으로 접속한 화면
USE mydb;
SELECT * FROM tbl_student;

-- S00001, 홍길동, 정보통신, 3, 010-1111-1111, 서울특별시 데이터를
-- tbl_student 테이블에 insert
DESC TBL_STUDENT;  
INSERT INTO TBL_STUDENT(ST_NUM, ST_NAME, ST_DEPT, ST_GRADE, ST_TEL, ST_ADDR) 
VALUES(
);

UPDATE tbl_student SET st_num='S00001' WHERE st_num = 'SC0001'; 
-- 학번이 S00001 인 학생의 주소를 서울특별시에서 강원도 원주로 변경하기
UPDATE tbl_student SET st_addr='강원도 원주' WHERE st_num = 'SC0001'; 


UPDATE tbl_student 
SET
st_name = #{st_name},
st_dept = #{st_dept},
st_grade = #{st_grade},
st_tel = #{st_tel}, 
st_addr = #{st_addr} 
WHERE st_num = 'S00001'; 
