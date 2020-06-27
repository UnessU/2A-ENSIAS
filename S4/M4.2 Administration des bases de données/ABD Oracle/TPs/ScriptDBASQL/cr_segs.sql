-- Script cr_segs.sql to create segments
-- for Lab11, Q1 O8DBA class
-- Created : 14-OCT-97
-- Author  : vvijayan

-- Dependencies :
-- needs SYSTEM account to run
-- needs DATA01 tablespace with exactly 2M free space
-- needs INDX01 tablespace with at least 100K free space

connect system/manager
CREATE TABLE emp(
empno NUMBER(4),
ename VARCHAR2(30),
job VARCHAR2(9),
mgr NUMBER(4),
hiredate DATE,
sal NUMBER(7,2),
comm NUMBER(7,2),
deptno NUMBER(2))
TABLESPACE data01
STORAGE (INITIAL 100K
	NEXT 100K
	PCTINCREASE 0
	MINEXTENTS 8
	MAXEXTENTS 10)
/


CREATE TABLE fragment1(
a NUMBER)
TABLESPACE data01
STORAGE(INITIAL 10K)
/


CREATE TABLE dept(
deptno NUMBER,
dname VARCHAR2(15),
loc VARCHAR2(20))
TABLESPACE data01
STORAGE(INITIAL 50K
NEXT 50K)
/

CREATE TABLE fragment2(
a NUMBER)
TABLESPACE data01
STORAGE(INITIAL 8K)
/

CREATE TABLE big_emp(
empno NUMBER(4),
ename VARCHAR2(30))
TABLESPACE data01
STORAGE (INITIAL 1M
	NEXT 1M
	MAXEXTENTS 10)
/

CREATE INDEX i_e_empno
	ON emp(ename)
	TABLESPACE indx01
	STORAGE(INITIAL 50K
		NEXT 50K)
/

DROP TABLE fragment1
/

DROP TABLE fragment2
/

