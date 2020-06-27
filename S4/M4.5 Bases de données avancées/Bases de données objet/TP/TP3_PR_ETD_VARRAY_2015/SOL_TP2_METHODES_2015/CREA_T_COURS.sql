------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		TYPE T_COURS 
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--creation du type des enseignats

CREATE OR REPLACE TYPE T_LISTE_ENS AS VARRAY(3) OF REF T_PERS;
/

-- CREATION DU TYPE DES COURS. LES ENSEIGANTS SERONT CREES APRES PAR ALTER TYPE

CREATE OR REPLACE TYPE T_COURS AS OBJECT(
	NUMCOURS	NUMBER(2),
	INTIT		VARCHAR2(20),
	VOLH		NUMBER(2),
	LISTE_ENS	T_LISTE_ENS,
	--LES CINSTRUCTEURS
	constructor function T_COURS (N IN NUMBER, I IN varchar2, V IN NUMBER) RETURN SELF AS RESULT,
	constructor function T_COURS (N IN NUMBER, I IN varchar2) RETURN SELF AS RESULT,
	constructor function T_COURS(N IN NUMBER, I IN varchar2, V IN NUMBER, L IN T_LISTE_ENS) RETURN SELF AS RESULT,

	--- LES MTHODES ORDER DOIVENT RENVOYER UN INTEGER ET NON UN BOOLEAN
	-- LA FONCTION ORDER RETOURNE -1 POUR <; 0 POUR = ET 1 POUR >
	--ORDER MEMBER FUNCTION COMPARE_ADR(ADR IN T_ADR) RETURN INTEGER,

	member function VOLH_COURS RETURN NUMBER,
	member function EXISTE_PROF(CIN_PROF IN VARCHAR2) RETURN BOOLEAN,
	member function LISTE_PROF RETURN T_LISTE_ENS,
	member procedure modif_INTIT (NEW_IN IN varchar2),
	member procedure AJOUTER_PROF (CIN_PROF IN varchar2),
	member procedure AJOUTER_LISTE_PROF (CLISTE_PROF IN T_LISTE_ENS),
	member procedure RETIRER_PROF (CIN_PROF IN varchar2),
	static procedure AJOUTER_COURS(N IN NUMBER, I IN varchar2, V IN NUMBER, LP IN T_LISTE_ENS),
	static procedure AJOUTER_COURS(C IN T_COURS),
	static procedure SUPPRIMER_COURS(N IN NUMBER)	
);
/


------------------------------------------------------------------------------
----		FIN DU TYPE T_COURS 
------------------------------------------------------------------------------
