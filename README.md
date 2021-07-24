# 교수/학생 정보관리 페이지
**아직 미완성이고, 학부생이라 발퀄입니다.**
* * *
## 사용된 프레임워크
-   Springboot

---
###  데이터베이스 구조
###### 현재 상태 : 로컬 DB, 추후 개발 상황에 따라 AWS 호스팅 예정



#### user 테이블 
###### 학생/교직원 등의 회원 정보 관리
    
|Filed|Type|Null|Key|
|---|---|---|---|
|id|varchar(15)|NO|PRI|
|classification|enum('staff','student','root')|NO||
|password|char(64)|NO||
|name|varchar(20)|NO||
|gender|enum('M','F')|NO||
|birthDay|date|NO||
|majorCode|varchar(10)|NO|MUL (Major 테이블을 참조)|

> 학과명을 보이기 위해 user bean 클래스에는 majorName 이라는 변수를 넣어 둔 상태입니다.

#### major 테이블 
###### 학과

|Filed|Type|Null|Key|
|---|---|---|---|
|majorCode|varchar(10)|NO|PRI|
|majorName|varchar(20)|NO||

#### subject 테이블 
###### 과목

|Filed|Type|Null|Key|
|---|---|---|---|
|subjectCode|int|NO|PRI|
|majorCode|varchar(10)|NO|MUL (major 테이블 참조)|
|subjectName|varchar(20)|NO||

---
