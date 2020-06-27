------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------
----		CODAGE DES METHODES DU TYPE T_PERS
------------------------------------------------------------------------------


--codage des méthodes

create or replace type body T_PERS as
	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN NUMBER) 
	RETURN SELF AS RESULT IS
	BEGIN
		SELF.CIN:=c;
		SELF.NOM:=n;
		SELF.PRENOM:=p;
		SELF.AGE:=a;
		RETURN;
	END T_PERS;


	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2) 
	RETURN SELF AS RESULT IS
	BEGIN
		SELF.CIN:=c;
		SELF.NOM:=n;
		SELF.PRENOM:=p;
		RETURN;
	END T_PERS;


	member function AGE_PERS RETURN NUMBER IS
	BEGIN
		RETURN SELF.AGE;
	END AGE_PERS;



	member procedure modif_ADR_PRIV_PERS (a IN T_ADR) IS
	BEGIN
		UPDATE TAB_PERS
		sET ADR_PRIVE=a
		WHERE ADR_PRIVE=SELF.ADR_PRIVE;
		COMMIT;
	END modif_ADR_PRIV_PERS;


	member procedure modif_ADR_PUB_PERS (R IN REF T_ADR) IS
	BEGIN
		UPDATE TAB_PERS
		sET ADR_PUB=R
		WHERE ADR_PUB=SELF.ADR_PUB;
		COMMIT;
	END modif_ADR_PUB_PERS ;


	ORDER member FUNCTION MEME_ADR_PRIVEE_PERS(ADR_PRIVE IN T_ADR) 
	RETURN BOOLEAN IS
	BEGIN
		IF 	SELF.ADR_PRIVE=ADR_PRIVE 
		THEN RETURN TRUE;
		ELSE RETURN FALSE;
		END IF;
	END MEME_ADR_PRIVEE_PERS;


	static procedure ajouter_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN number) IS
	BEGIN
		insert into tab_pers values (c,n,p,a);
		COMMIT;
	END ajouter_PERS; 



	static procedure ajouter_PERS(P IN T_PERS) IS
	BEGIN
		--insert into tab_adrs values (P.CIN, P.NOM, P.PRENOM, P.AGE);
		insert into tab_PERS values (P);
		commit;
	END ajouter_PERS;



	static procedure supprimer_PERS(P IN T_PERS) IS		
	BEGIN
		
		DELETE TAB_PERS WHERE CIN=P.CIN;
		COMMIT;
	END supprimer_PERS;


END; --body
/

------------------------------------------------------------------------------
----			FIN DU CODAGE DES METHODES DU TYPE T_PERS 
------------------------------------------------------------------------------

