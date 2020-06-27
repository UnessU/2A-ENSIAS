------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		T_ADR 
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--execution
-- @E:\THOR\BDOO\TP_ROO_2015\tests_2015\script_METHODES_2015.sql
---tracage

set serveroutput on;
spool E:\THOR\BDOO\TP_ROO_2015\tests_2015\trace_tests_METHODES_roo_2015.txt

set echo on;

--test des méthodes et des constructeurs

--nettopyage
drop table tab_pers;
drop type t_pers;
drop table tab_adrs;
drop type t_adr;

------------------------------------------------------------------------------
----		TYPE T_ADR ET LA TABLE OBJET DES ADRESSES TAB_ADRS
------------------------------------------------------------------------------

--creation de type adresse
create or replace type t_adr as object(
	rue		varchar2(20),
	mais		number(2),
	ville		varchar2(20),
	pays		varchar2(20),
	constructor function t_adr(r IN varchar2, m IN Number, v IN varchar2) RETURN SELF AS RESULT,
	constructor function t_adr(r IN varchar2, m IN Number) RETURN SELF AS RESULT,
	--- LES MTHODES ORDER DOIVENT RENVOYER UN INTEGER ET NON UN BOOLEAN
	-- LA FONCTION ORDER RETOURNE -1 POUR <; 0 POUR = ET 1 POUR >
	ORDER MEMBER FUNCTION COMPARE_ADR(ADR IN T_ADR) RETURN INTEGER,
	member procedure modif_rue (r IN varchar2),
	static procedure ajouter_adr(r IN varchar2, m IN number, v IN varchar2, p IN varchar2),
	static procedure ajouter_adr(A IN T_ADR),
	static procedure supprimer_adr(r IN varchar2, m IN number),
	static procedure supprimer_avec_maj(r IN varchar2, m IN number)   
);
/

--creation de la table objet des adresses
create table tab_adrs of t_adr(
	constraint pk_tab_adr primary key (rue, mais),
	ville not null
);

--test du schéma 
desc tab_adrs;

--insertion dans la table objets des adresses
insert into tab_adrs values ('rue1', 1, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 2, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 3, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 4, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 5, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 6, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 1, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 2, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 3, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 4, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 5, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 6, 'ville1', 'maroc');

--validation
commit;


------------------------------------------------------------------------------
----			FIN DU TYPE T_ADR ET DE LA TABLE TAB_ADRS
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------
----	TYPE T_PERS AVEC LES METHODES ET DE LA TABLE OBJET TAB_PERS
------------------------------------------------------------------------------

-- creation du type des adresses privées: liste_adr_priv
CREATE OR REPLACE TYPE T_LISTE_ADR_PRIV AS VARRAY(3) OF T_ADR;
/

-- CREATION DU TYPE DES COURS. LES ENSEIGANTS SERONT CREES APRES PAR ALTER TYPE

CREATE IR REPLACE T_COURS AS OBJECT(
	NUMCOURS	NUMBER(2),
	INTIT		VARCHAR2(20),
	VOLH		NUMBER(2)
);
/

--CREATION DU TYPE LISTE DES COURS
CREATE OR REPLACE TYPE T_LISTE_COURS AS VARRAY(5) OF REF T_COURS;
/

--PARTAGE DES REFERENCES
CREATE OR REPLACE TYPE T_PERS AS OBJECT(
	CIN			VARCHAR2(20),
	NOM			VARCHAR2(20),
	PRENOM			VARCHAR2(20),
	AGE			NUMBER(2),
	LISTE_ADR_PRIVE		T_LISTE_ADR_PRIV,
	ADR_PUB			REF T_ADR,
	LISTE_COURS		T_LISTE_COURS,

	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN NUMBER) RETURN SELF AS RESULT,
	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2) RETURN SELF AS RESULT,
	member function AGE_PERS RETURN NUMBER,
	member procedure modif_ADR_PRIV_PERS (a IN T_ADR),
	member procedure modif_ADR_PUB_PERS (R IN REF T_ADR),
	member FUNCTION MEME_ADR_PRIVEE_PERS(ADR_PRIVE IN T_ADR) RETURN BOOLEAN,
	static procedure ajouter_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN number),
	static procedure ajouter_PERS(P IN T_PERS),
	static procedure supprimer_PERS(P IN T_PERS),

	-- METHODES A AJOUTER
	MEMBER PROCEDURE ADD_COURS(LC IN T_LISTE_COURS),
	MEMBER PROCEDURE MODIF_COURS(OLDC IN T_COURS, NEWC IN T_COURS), 
	MEMBER PROCEDURE ADD_ADR_PRIV(LA IN T_LISTE_ADR_PRIV),
	MEMBER PROCEDURE MODIF_ADR_PRIV(OLDA IN T_ADR, NEWA IN T_ADR)
);
/


-- CREATION DE LA LISTE DES PERSONNES
CREATE OR REPLACE TYPE T_LISTE_PERS AS VARRAY(3) OF T_PERS;
/

ALTER TYPE T_COURS 
	ADD LISTE_PROFS T_LISTE_PERS;


--remarque si pas d'arguements pour la methodes----> pas de ()

---------------------------------------------------------------------------------
--- 				TAB_PERS
---------------------------------------------------------------------------------
--CREATION DE LA TABLE OBJETS DES PERSONNES
CREATE TABLE TAB_PERS OF T_PERS(
	CONSTRAINT PK_TAB_PERS PRIMARY KEY (CIN),
	CONSTRAINT C_NOM_NN CHECK (NOM  IS not null),
	CONSTRAINT C_AGE_NN CHECK (AGE  IS NOT NULL),
	--CONSTRAINT C_ADR_PRIV_NN CHECK (ADR_PRIVE  IS NOT NULL),
	CONSTRAINT C_REF ADR_PUB SCOPE IS TAB_ADRS
);	

---------------------------------------------------------------------------------
--- 			INSERTION DES DONNEES DANS LA TAB_PERS
---------------------------------------------------------------------------------


-- MEME ADRESSE PUBLIQUES

INSERT INTO TAB_PERS VALUES ('k12434', 'nom1', 'prenom1', 34, T_ADR('r1', 1, 'v1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=1 AND D.VILLE='ville1')
);

INSERT INTO TAB_PERS VALUES ('d12434', 'nom2', 'prenom2', 44, T_ADR('r2', 2, 'v2', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=1 AND D.VILLE='ville1')
);

-- ADRESSE PUBLIQUES DIFFERENTE

INSERT INTO TAB_PERS VALUES ('X12434', 'nom3', 'prenom3', 24, T_ADR('r3', 3, 'v3', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=2 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('Z12434', 'nom4', 'prenom4', 45, T_ADR('r1', 1, 'v1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=3 AND D.VILLE='ville1')
);

INSERT INTO TAB_PERS VALUES ('F12434', 'nom5', 'prenom5', 36, T_ADR('r4', 4, 'v4', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=2 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('g12434', 'nom6', 'prenom6', 66, T_ADR('r6', 6, 'v6', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

-- LES MEMES ADRESSES PUBLIQUES

INSERT INTO TAB_PERS VALUES ('T12434', 'nom7', 'prenom7', 55, T_ADR('r1', 1, 'v1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('M12434', 'nom8', 'prenom8', 23, T_ADR('r8', 8, 'v8', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('N12434', 'nom9', 'prenom9', 33, T_ADR('r9', 9, 'v9', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

-- MEME ADRESSE PUBLIQUE ET PRIVEE

INSERT INTO TAB_PERS VALUES ('AQ12434', 'nom9', 'prenom9', 33, T_ADR('rue1', 4, 'ville2', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('BQ12434', 'nom10', 'prenom10', 36, T_ADR('rue1', 6, 'ville2', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=6 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('QQ12434', 'nom11', 'prenom11', 63, T_ADR('rue2', 4, 'ville1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue2' AND D.MAIS=4 AND D.VILLE='ville1')
);

-- LES PERSONNES DONT L ADRESSE PUBLIQUE EST NULL
INSERT INTO TAB_PERS VALUES ('AQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue11', 11, 'ville11', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue11' AND D.MAIS=11 AND D.VILLE='ville11')
);

INSERT INTO TAB_PERS VALUES ('BQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue22', 22, 'ville22', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue22' AND D.MAIS=22 AND D.VILLE='ville22')
);

INSERT INTO TAB_PERS VALUES ('CQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue33', 33, 'ville33', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue33' AND D.MAIS=33 AND D.VILLE='ville33')
);

INSERT INTO TAB_PERS VALUES ('DQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue44', 44, 'ville44', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue44' AND D.MAIS=44 AND D.VILLE='ville44')
);

-- PERSONNES POUR SUPPRIMER SON ADRESSE REFERENCE
INSERT INTO TAB_PERS VALUES ('QQQQQ', 'nom55', 'prenom55', 43, T_ADR('rue55', 55, 'ville55', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rueQQ' AND D.MAIS=55 AND D.VILLE='ville55')
);

INSERT INTO TAB_PERS VALUES ('WWWWW', 'nom66', 'prenom66', 13, T_ADR('rue66', 66, 'ville66', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rueWW' AND D.MAIS=66 AND D.VILLE='ville66')
);

-- ADRESSE PUBLIQUE NULL
INSERT INTO TAB_PERS VALUES ('FFFFF', 'nom99', 'prenom99', 99, T_ADR('rue99', 99, 'ville99', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rueFFF' AND D.MAIS=99 AND D.VILLE='ville99')
);

INSERT INTO TAB_PERS VALUES ('XXXXX', 'nom88', 'prenom88', 88, T_ADR('rue88', 88, 'ville88', 'maroc'),
	NULL
);

--validation
commit;

------------------------------------------------------------------------------
----			FIN DU TYPE T_PERS ET DE LA TABLE TAB_PERS
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------
----		CODAGE DES METHODES DU TYPE T_ADR
------------------------------------------------------------------------------


--codage des méthodes

create or replace type body t_adr as
	constructor function t_adr(r IN varchar2, m IN Number, v IN varchar2) RETURN SELF AS RESULT IS
	BEGIN
		SELF.rue:=r;
		SELF.mais:=m;
		SELF.ville:=v;
		SELF.PAYS:='maroc';
		RETURN;
	END t_adr;


	constructor function t_adr(r IN varchar2, m IN Number) RETURN SELF AS RESULT IS
	BEGIN
		SELF.rue:=r;
		SELF.mais:=m;
		SELF.ville:='rabat';
		SELF.PAYS:='maroc';
		RETURN;
	END t_adr;

	ORDER MEMBER FUNCTION COMPARE_ADR(ADR IN T_ADR) RETURN INTEGER IS
	BEGIN
		IF 	SELF.RUE=ADR.RUE 
		  	AND SELF.MAIS=ADR.MAIS
			AND SELF.VILLE=ADR.VILLE
			AND SELF.PAYS=ADR.PAYS
		THEN RETURN 0;
		ELSE RETURN -1;
		END IF;
	END COMPARE_ADR;

	member procedure modif_rue (r IN varchar2) IS
	BEGIN
		UPDATE TAB_ADRS
		sET rue=r
		WHERE rue=SELF.rue;
	END modif_rue;

	static procedure ajouter_adr(r IN varchar2, m IN number, v IN varchar2, p IN varchar2) IS
	BEGIN
		insert into tab_adrs values (r, m, v, p);
	END ajouter_adr; 

	static procedure ajouter_adr(A IN T_ADR) IS
	BEGIN
		--insert into tab_adrs values (A.rue, A.mais, A.ville, A.pays);
		insert into tab_adrs values (A);
		commit;
	END ajouter_adr;
	

	static procedure supprimer_adr(r IN varchar2, m IN number) IS
		REF_ADR		REF T_ADR; -- LA REF DE L'OBJET A SUPPRIMER
	BEGIN
		
		DELETE TAB_ADRS WHERE RUE=r AND MAIS=m;

		COMMIT;
	END supprimer_adr;

	static procedure supprimer_avec_maj(r IN varchar2, m IN number) IS
		REF_ADR		REF T_ADR;
	BEGIN
		-- AU LIEU D'UTILISER UN TRIGGER, JE FAIS LE TRAITEMENT DIRECTEMENT DANS CETTE FONCTION
		SELECT REF(A) INTO REF_ADR FROM TAB_ADRS A WHERE A.RUE=R AND A.MAIS=M;
		UPDATE TAB_PERS 
		SET ADR_PUB=NULL
		WHERE ADR_PUB=REF_ADR;
		DELETE TAB_ADRS WHERE RUE=r AND MAIS=m;
		COMMIT;
	END supprimer_avec_maj;
END; --body
/

------------------------------------------------------------------------------
----			FIN DU CODAGE DES METHODES DU TYPE T_ADR 
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

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

--test de rollback!! méthode commit et rollback ou automatique
rollback;

--test de l'effet
select * from tab_adrs;

--remarque: les maj à travers les méthodes doivent être validés par commit et rollback comme d'habitude
-- POUR LES METHODES STATIQUES, IL FAUT LES APPLER AVEC LES OBJETS ET LES APPLIQUER AUX TABLES

--fin de tracage

--tester l'insertion d'un objet
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

--CA MARCHE
--RAMARQUE: IL FAUT DONNER LE NOMBRE EXACT DE VALEURS. TESTER AUSSI UNE METHODE INSERT AVEC UN OBJET

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
--ca marche
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
----		CODAGE DES METHODES DU TYPE T_PERS
------------------------------------------------------------------------------

-- LE CORPS DES METHODES
--codage des méthodes

create or replace type body T_PERS as

	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN NUMBER) RETURN SELF AS RESULT IS
	BEGIN
		SELF.CIN:=C;
		SELF.NOM:=N;
		SELF.PRENOM:=P;
		SELF.AGE:=A;
		SELF.ADR_PRIVE:=NULL;
		SELF.ADR_PUB:=NULL;
		RETURN;
	END T_PERS;


	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2) RETURN SELF AS RESULT IS
	BEGIN
		SELF.CIN:=C;
		SELF.NOM:=N;
		SELF.PRENOM:=P;
		SELF.AGE:=NULL;
		SELF.ADR_PRIVE:=NULL;
		SELF.ADR_PUB:=NULL;
		RETURN;
	END T_PERS;

	member function AGE_PERS RETURN NUMBER IS
	BEGIN
		RETURN SELF.AGE;
	END AGE_PERS;

	member procedure modif_ADR_PRIV_PERS (a IN T_ADR) IS
	BEGIN
		UPDATE TAB_PERS
		sET ADR_PRIVE=A
		WHERE CIN=SELF.CIN;
	END modif_ADR_PRIV_PERS;

	member procedure  modif_ADR_PUB_PERS (R IN REF T_ADR) IS
	BEGIN
		UPDATE TAB_PERS
		sET ADR_PUB=R
		WHERE CIN=SELF.CIN;
	END modif_ADR_PUB_PERS;

	member FUNCTION MEME_ADR_PRIVEE_PERS(ADR_PRIVE IN T_ADR) RETURN BOOLEAN IS
	BEGIN
		IF ADR_PRIVE=SELF.ADR_PRIVE
		THEN RETURN TRUE;
		ELSE RETURN FALSE;
		END IF; 
	END MEME_ADR_PRIVEE_PERS;

	static procedure ajouter_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN number) IS
		PERS	T_PERS;
	BEGIN
		PERS:= NEW T_PERS(c, n, p, a);
		insert into tab_pers values (PERS);
		COMMIT;
	END ajouter_PERS; 

	static procedure ajouter_PERS(P IN T_PERS) IS
	BEGIN
		insert into tab_pers values (P);
		commit;
	END ajouter_PERS;
	

	static procedure supprimer_PERS(P IN T_PERS)  IS
	BEGIN
		DELETE TAB_PERS WHERE CIN=P.CIN;
		COMMIT;
	END supprimer_PERS;
END; --body
/


------------------------------------------------------------------------------
----			FIN DU CODAGE DES METHODES DU TYPE T_PERS
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
	PERS		T_PERS;
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
--REMARQUE CE CODE NE MARCHE PAS. IL FAUT UNE FONCTION MAP OU ORDER 
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

---- TEST D'UN TRIGER POUR GERER AUTOMATIQUEMENT LA SUPPRESSION D'UNE ADRESSE
---- DANS LA TABLE TAB_ADRS REFERENCEE PAR UN OBJET DANS LA TABLE TAB_PERS
/*
CREATE OR REPLACE TRIGGER GEST_DELETE_ADR
BEFORE DELETE ON TAB_ADRS
FOR EACH ROW
BEGIN
	UPDATE TAB_PERS
	SET ADR_PUB=NULL
	WHERE ADR_PUB=:OLD.oidOBJECT;
END;
/

*/

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

-- REMARQUE: VU QUE LES TRIGGER SUR LES TABLES OBJETS  NE MARCHE PAS, LA MEILLEUR FACON DE FAIRE 
-- POUR EVITER LES REF DEGLINGUEE EST DE LES METTRE A JOUR AU MOMENT
-- DE LA SUPPRESSION DES OBJETS REFERENCES. AUTREMENT ADOPTER LA MEME DEMARCHE QUE DANS L'OBJET PUR

------------------------------------------------------------------------------
----			FIN DU TEST DES METHODES DU TYPE T_PERS
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
spool off;
