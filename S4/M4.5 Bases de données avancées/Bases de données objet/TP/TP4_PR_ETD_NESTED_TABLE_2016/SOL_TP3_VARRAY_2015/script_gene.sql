--script general

--     @E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\script_GENE.sql
--- tracage
set echo on


set serveroutput on;

spool E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\TRACES.txt


--nettopyage
drop  TYPE T_LISTE_COURS_PROF FORCE ;
drop table TAB_COURS;
DROP type T_COURS FORCE ;
DROP TYPE T_LISTE_ENS FORCE ;
drop table tab_pers;
drop type t_pers FORCE ;
drop table tab_adrs;
drop type t_adr FORCE ;

--1. creation du type T_ADR
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_T_ADR.SQL
show error

--2. creation de la tables des adresses
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_TAB_ADRS.SQL
show error

--3. creation du type T_PERS
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_T_PERS.SQL
show error

--4. creation de la table des personnes
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_TAB_PERS.SQL
show error

--5. creation du type T_COURS
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_T_COURS.SQL

show error

--6. creation de la table des COURS
@E:\THOR\BDOO_EM\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_TAB_COURS.SQL
show error

--7. codage des méthodes de T_ADR
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_METH_T_ADR.SQL
show error

--8. codage des méthodes de T_PERS
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_METH_T_PERS.SQL
show error

--9. codage des méthodes de T_COURS
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\CREA_METH_T_COURS.SQL

show error

--10. MODIFICATION DU TYPE T_PERS
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\MODIF_T_PERS.SQL
show error

--11. LES TESTS DES METHODES
@E:\THOR\BDOO\TP_ROO_2015\TP3_ROO_VARRAY_2015\TEST_METHODES.sql
show error

-- FIN DE TRACAGE
SPOOL OFF;

