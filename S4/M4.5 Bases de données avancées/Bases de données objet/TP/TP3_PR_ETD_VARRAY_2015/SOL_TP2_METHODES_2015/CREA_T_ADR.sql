------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		T_ADR 
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

------------------------------------------------------------------------------
----		TYPE T_ADR ET LA TABLE OBJET DES ADRESSES TAB_ADRS
------------------------------------------------------------------------------

--creation de type adresse
create or replace type t_adr as object(
	rue			varchar2(20),
	mais		number(2),
	ville		varchar2(20),
	pays		varchar2(20),
	constructor function t_adr(r IN varchar2, m IN number, v IN varchar2) RETURN SELF AS RESULT,
	constructor function t_adr(r IN varchar2, m IN number) RETURN SELF AS RESULT,
	--- LES METHODES ORDER DOIVENT RENVOYER UN INTEGER ET NON UN BOOLEAN
	-- LA FONCTION ORDER RETOURNE -1 POUR <; 0 POUR = ET 1 POUR >
	order member function compare_adr(adr IN T_ADR) RETURN INTEGER,
	member procedure modif_rue (r IN varchar2),
	static procedure ajouter_adr(r IN varchar2, m IN number, v IN varchar2, p IN varchar2),
	static procedure ajouter_adr(a IN T_ADR),
	static procedure supprimer_adr(r IN varchar2, m IN number),
	static procedure supprimer_avec_maj(r IN varchar2, m IN number)   
);
/

------------------------------------------------------------------------------
----			FIN DU TYPE T_ADR 
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
