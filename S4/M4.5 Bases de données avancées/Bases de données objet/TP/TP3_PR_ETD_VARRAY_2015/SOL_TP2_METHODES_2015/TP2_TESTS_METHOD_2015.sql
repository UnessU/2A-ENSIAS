--execution
-- E:\THOR\BDOO\TP_ROO_2015\TP2_ROO_METHODES_2015\SOL_TP2_METHODES_2015\TP2_TESTS_METHOD_2015.sql
---tracage

set serveroutput on;
spool E:\THOR\BDOO\TP_ROO_2015\TP2_ROO_METHODES_2015\SOL_TP2_METHODES_2015\TP2_TRACE_TESTS_METHOD_2015.txt

set echo on;

--test des méthodes et des constructeurs

--nettopyage
drop table tab_pers;
drop type t_pers;
drop table tab_adrs;
drop type t_adr;




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

--TEST DE REF
select ref(d) from tab_adrs d;

--test de value
select value(d) from tab_adrs d;

--test de value et le lien de l'objet avec l'objet dans la table

DECLARE
	ADR			T_ADR;
	PAYSTEST	varchar2(20);
BEGIN
	SELECT VALUE(D) INTO ADR FROM TAB_ADRS D WHERE D.RUE='rue1' and D.MAIS=1;
    DBMS_OUTPUT.PUT_LINE('objet recupere : '||ADR.RUE ||'  '||ADR.MAIS||'  '||ADR.VILLE||'  '||ADR.PAYS);
	ADR.PAYS:='TOTO';
	DBMS_OUTPUT.PUT_LINE('objet modif : '||ADR.RUE ||'  '||ADR.MAIS||'  '||ADR.VILLE||'  '||ADR.PAYS);
	SELECT VALUE(D) INTO ADR FROM TAB_ADRS D WHERE D.RUE='rue1' and D.MAIS=1;
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


------------------------------------------------------------------------------
----		TEST DES METHODES DU TYPE T_PERS
------------------------------------------------------------------------------

-- TEST DE FUNCTION DANS UNE REQUETE SQL

	SELECT C.CIN, C.NOM, C.PRENOM,C.AGE_PERS() FROM TAB_PERS C;

-- TEST DE FUNCTION DANS UN BLOC PL/SQL
	-- SI L'AGE EST < 25 AUGMENTER L'AGE DE 10 DE LA PERSONNE DE CIN WWWWW

DECLARE
	PERS	T_PERS;
	A		NUMBER; --- AGE
BEGIN
	SELECT VALUE(D) INTO PERS FROM TAB_PERS D WHERE D.CIN='WWWWW';
	A:=PERS.AGE_PERS();
	IF A<25 
	THEN	UPDATE TAB_PERS 
		SET AGE=A+10
		WHERE CIN=PERS.CIN;
	END IF;
	COMMIT;
END;
/

--TEST 
SELECT * FROM TAB_PERS WHERE CIN='WWWWW';

------------------------------------------------------------------
-- TEST DE MEME_ADR_PRIVEE_PERS
-- IL FAUT UNE FONCTION MAP OU ORDER 
-- 	POUR COMPARER LES OBJETS DANS PL/SLQ
-- L'APPEL DE LA FONCTION ORDER EST IMPLICITE LORS DE LA COMPARAISON
-- IL FAUT UNE SEULE FUNCTION ORDER PAR TYPE OU MAP
-- IL EST INTERDIT DE METTRE A LA FOIS UNE FONCTION ORDER ET UNE FONCTION MAP

DECLARE
	CURSOR LISTE_PERS IS
	SELECT CIN, NOM, PRENOM, ADR_PRIVE
	FROM TAB_PERS;

	PERS		T_PERS;
BEGIN
	SELECT VALUE(D) INTO PERS FROM TAB_PERS D WHERE D.CIN='k12434';
	DBMS_OUTPUT.PUT_LINE('MEME ADRESSE PRIVE QUE : '||PERS.CIN ||'  '||PERS.NOM||'  '||PERS.PRENOM);
	DBMS_OUTPUT.PUT_LINE('ADRESSE PRIVE: '||PERS.ADR_PRIVE.RUE ||'  '||PERS.ADR_PRIVE.MAIS||'  '||PERS.ADR_PRIVE.VILLE||'  '||PERS.ADR_PRIVE.PAYS);
	DBMS_OUTPUT.PUT_LINE('---------------------------------------');
	DBMS_OUTPUT.PUT_LINE('---------------------------------------');
	FOR LIGNE IN LISTE_PERS LOOP
		IF (PERS.ADR_PRIVE=LIGNE.ADR_PRIVE)
		THEN 	DBMS_OUTPUT.PUT_LINE(LIGNE.CIN ||'  '||LIGNE.NOM||'  '||LIGNE.PRENOM);
			DBMS_OUTPUT.PUT_LINE('ADRESSE PRIVE: '||LIGNE.ADR_PRIVE.RUE ||'  '||LIGNE.ADR_PRIVE.MAIS||'  '||LIGNE.ADR_PRIVE.VILLE||'  '||LIGNE.ADR_PRIVE.PAYS);
			DBMS_OUTPUT.PUT_LINE('---------------------------------------');
		END IF;
	END LOOP;
END;
/


--test 
SELECT CIN, DEREF(ADR_PUB) FROM TAB_PERS D;


-- TEST DE SUUPRIMER_ADR AVEC LA MISE A JOUR DE LA REFERENCE DE ADR_PUB DANS TAB_PERS A NULL
DECLARE
BEGIN
	T_ADR.supprimer_avec_maj('rue1', 1);
END;
/

--test 
SELECT CIN, DEREF(ADR_PUB) FROM TAB_PERS D;

-- LA MEILLEUR FACON DE FAIRE 
-- POUR EVITER LES REF DEGLINGUEE EST DE LES METTRE A JOUR AU MOMENT
-- DE LA SUPPRESSION DES OBJETS REFERENCES. AUTREMENT ADOPTER LA MEME DEMARCHE QUE DANS L'OBJET PUR

------------------------------------------------------------------------------
----			FIN DU TEST DES METHODES DU TYPE T_PERS
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
spool off;
