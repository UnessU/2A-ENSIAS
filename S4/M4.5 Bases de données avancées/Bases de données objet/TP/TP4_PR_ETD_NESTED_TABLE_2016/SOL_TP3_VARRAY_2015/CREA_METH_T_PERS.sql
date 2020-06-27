------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		CODAGE DES METHODES DU TYPE T_PERS
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
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

