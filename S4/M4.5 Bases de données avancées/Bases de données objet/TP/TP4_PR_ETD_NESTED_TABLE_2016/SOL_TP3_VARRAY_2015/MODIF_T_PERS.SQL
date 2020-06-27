------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		MODIFICATION DU TYPE T_PERS
---- 	ON AJOUTE LA METHODE QUI RETOURNE LA LISTE DES COURS D'UN PROF
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--- 			INSERTION DES DONNEES DANS LA TAB_PERS
---------------------------------------------------------------------------------
CREATE OR REPLACE TYPE T_LISTE_COURS_PROF AS VARRAY(5) OF NUMBER;
/



---------------------------------------------------------------------------------
--- 			AJOUTE DE LA METHODE PAR ALTER DU TYPE
---------------------------------------------------------------------------------
ALTER TYPE T_PERS 
	ADD MEMBER FUNCTION LISTE_COURS_PROF RETURN T_LISTE_COURS_PROF CASCADE;

---------------------------------------------------------------------------------
--- 			RECREATION DU CORPS DES METHODES DU T_PERS
---			AVEC LA NOUVELLE METHODE
---------------------------------------------------------------------------------

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

	--------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------

	-- LA NOUVELLE METHODE C EST UNE DEUXIEME VESRION AVEC UN CURSEUR QUI CALCULE DIRECTEMENT LA LISTE

	MEMBER FUNCTION LISTE_COURS_PROF RETURN T_LISTE_COURS_PROF IS

		CURSOR LISTE_COURS IS 
			SELECT C1.NUMCOURS
			FROM TAB_COURS C1
			WHERE (SELECT REF(D) FROM TAB_PERS D WHERE D.CIN=SELF.CIN) 
				IN 
			(SELECT E.* FROM TAB_COURS C2, TABLE(C2.LISTE_ENS) E WHERE C1.NUMCOURS=C2.NUMCOURS);

		LT		T_LISTE_COURS_PROF:=NEW T_LISTE_COURS_PROF();
		COMPT		NUMBER:=0;
	BEGIN
		FOR N IN LISTE_COURS LOOP
			LT.EXTEND();
			COMPT:=COMPT+1;
			LT(COMPT):=N.NUMCOURS;
		END LOOP;
		RETURN LT;
	END LISTE_COURS_PROF;
	--------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------

END; --body
/

------------------------------------------------------------------------------
----			FIN DU CODAGE DES METHODES DU TYPE T_PERS
------------------------------------------------------------------------------