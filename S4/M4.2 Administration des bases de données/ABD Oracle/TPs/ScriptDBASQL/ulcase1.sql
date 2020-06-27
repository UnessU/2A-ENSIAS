Rem  Copyright (c) 1991 by Oracle Corporation 
Rem    NAME
Rem      ulcase1.sql - <one-line expansion of the name>
Rem    DESCRIPTION
Rem      <short description of component this file declares/defines>
Rem    RETURNS
Rem 
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem    MODIFIED   (MM/DD/YY)
Rem     ksudarsh   03/01/93 -  comment out vms specific host command 
Rem     ksudarsh   12/29/92 -  Creation 
Rem     cheigham   08/28/91 -  Creation 
rem 
rem $Header: ulcase1.sql,v 1.2 1993/03/11 10:45:02 KSUDARSH Exp $ 
rem 
set termout off
rem host write sys$output "Building first demonstration tables.  Please wait"
set feedback off
drop table emp;
drop table dept;

create table emp
       (empno number(4) not null,
	ename char(10),
	job char(9),
	mgr number(4),
	hiredate date,
	sal number(7,2),
	comm number(7,2),
	deptno number(2));
 
create table dept
       (deptno number(2),
	dname char(14) ,
	loc char(13) ) ;

exit
