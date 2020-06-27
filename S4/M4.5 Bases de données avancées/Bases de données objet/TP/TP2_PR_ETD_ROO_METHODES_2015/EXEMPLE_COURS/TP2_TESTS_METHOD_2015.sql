--execution
-- @E:\THOR\BDOO_ENSIAS\BDOO_ENSIAS_2015\ROO_ENSIAS_2015\TP2_ROO_ADT_METHODES_2015\EXEMPLE_COURS\TP2_TESTS_METHOD_2015.sql

---tracage

set serveroutput on;
spool E:\THOR\BDOO_ENSIAS\BDOO_ENSIAS_2015\ROO_ENSIAS_2015\TP2_ROO_ADT_METHODES_2015\EXEMPLE_COURS\TP2_TRACE_TESTS_METHOD_2015.txt

set echo on;

--test des méthodes et des constructeurs



------------------------------------------------------------------------------
----			TEST DES METHODES DU TYPE T_ADR 
------------------------------------------------------------------------------

--test de méthodes

-- TEST DES CONSTRUCTEUR
	-- ON PEUT INVOQUER UN CONSTRUCTEUR DIRECTEMENT DANS INSERT INTO COMME:
	-- IL FAUT JUSTE QUE LE CONSTRUTEUR CONSTRUIT LES DIFFERENTS CHAMPS DE L'OBJET

	INSERT INTO TAB_ADRS VALUES ( T_ADR('XXX',11) );


--test de ajouter_adr

DECLARE 
BEGIn
	t_adr.ajouter_adr('marue', 11, 'maville', 'mon pays');
	commit;
END;
/

--test d'insertion
select * from tab_adrs;


--test de supprimer
DECLARE 
BEGIn
	t_adr.supprimer_adr('marue', 11);
	commit;
END;
/

--tester de la suppression d'un objet
select * from tab_adrs;

--test des constructeur
DECLARE
	ADR	T_ADR;
BEGIN
	ADR:=NEW T_ADR('sarue', 11);
	t_adr.ajouter_adr(ADR);
	commit;
END;
/

--test d'insertion 
select * from tab_adrs;


--TEST AVEC UNIQUEMENT DES VALEURS DE L OBJET ADR
DECLARE
	ADR	T_ADR;
BEGIN
	ADR:=NEW T_ADR('sarue', 22);
	t_adr.ajouter_adr(ADR.RUE, ADR.MAIS, ADR.VILLE, ADR.PAYS);
	commit;
END;
/

SELECT * FROM TAB_ADRS;


--TEST D INSERTION AVEC UN OBJET COMME ARGUMENT
DECLARE
	ADR	T_ADR;
BEGIN
	ADR:=NEW T_ADR('RIEN', 99);
	t_adr.ajouter_adr(ADR);
	commit;
END;
/

SELECT * FROM TAB_ADRS;

---------------------------------------------------------------------
-- commande sur le dictionnaire pour avoir les infos des méthodes 
-- la description des méthodes

COL TYPE_NAME FORMAT A15
COL METHOD_NAME FORMAT A20
COL METHOD_TYPE FORMAT A15


SELECT TYPE_NAME, METHOD_NAME, METHOD_TYPE, PARAMETERS, RESULTS
	FROM USER_TYPE_METHODS WHERE TYPE_NAME = 'T_ADR';

COL PARAM_NAME FORMAT A15
COL METHOD_NAME FORMAT A15
COL PARAM_TYPE_NAME FORMAT A20

SELECT METHOD_NAME, METHOD_NO, PARAM_NAME, PARAM_TYPE_NAME 
	FROM USER_METHOD_PARAMS WHERE TYPE_NAME = 'T_ADR';

SELECT METHOD_NAME, METHOD_NO,RESULT_TYPE_NAME
	FROM USER_METHOD_RESULTS WHERE TYPE_NAME = 'T_ADR';
---------------------------------------------------------------------

--TEST DE REF
select ref(d) from tab_adrs d;

--test de value
select value(d) from tab_adrs d;


--test de value et le lien de l'objet avec l'objet dans la table

DECLARE
	ADR		T_ADR;
	PAYSTEST	varchar2(20);
BEGIN
	SELECT VALUE(D) INtO ADR FROM TAB_ADRS D WHERE D.RUE='rue1' and D.MAIS=1;
        DBMS_OUTPUT.PUT_LINE('objet recupere : '||ADR.RUE ||'  '||ADR.MAIS||'  '||ADR.VILLE||'  '||ADR.PAYS);
	ADR.PAYS:='TOTO';
	DBMS_OUTPUT.PUT_LINE('objet modif : '||ADR.RUE ||'  '||ADR.MAIS||'  '||ADR.VILLE||'  '||ADR.PAYS);
	SELECT VALUE(D) INtO ADR FROM TAB_ADRS D WHERE D.RUE='rue1' and D.MAIS=1;
	DBMS_OUTPUT.PUT_LINE('objet table : '||ADR.RUE ||'  '||ADR.MAIS||'  '||ADR.VILLE||'  '||ADR.PAYS);
END;
/

--test d'insertion d'un objet diretement avec insert
DECLARE
	ADR		T_ADR;
BEGIN
	ADR:=NEW T_ADR('saruexxx', 22);
	insert into tab_adrs values (ADR);
	commit;
END;
/


------------------------------------------------------------------------------
----			FIN DU TEST DES METHODES DU TYPE T_ADR
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
spool off;
