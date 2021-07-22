# 교수/학생 정보관리 페이지
**아직 미완성이고, 학부생이라 발퀄입니다.**
* * *
## 사용된 프레임워크
-   Springboot

***
###  데이터베이스 구조
#### user 테이블
    
|Filed|Type|Null|Key|
|---|---|---|---|
|id|varchar(15)|NO|PRI|
|classification|enum('staff','student','root')|NO||
|password|char(64)|NO||
|name|varchar(20)|NO||
|gender|enum('M','F')|NO||
|birthDay|date|NO||
|majorCode|varchar(10)|NO|MUL (Major 테이블을 참조)|

***
#### major 테이블

|Filed|Type|Null|Key|
|---|---|---|---|
|majorCode|varchar(10)|NO|PRI|
|majorName|varchar(20)|NO||
