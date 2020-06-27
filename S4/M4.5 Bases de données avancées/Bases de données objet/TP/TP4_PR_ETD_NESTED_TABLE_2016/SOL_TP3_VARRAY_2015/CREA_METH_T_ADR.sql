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

