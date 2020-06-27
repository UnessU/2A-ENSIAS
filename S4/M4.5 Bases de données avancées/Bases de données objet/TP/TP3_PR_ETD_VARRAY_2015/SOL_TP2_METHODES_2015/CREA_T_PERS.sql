------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		CREATION DU TYPE T_PERS
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--PARTAGE DES REFERENCES

CREATE OR REPLACE TYPE T_PERS AS OBJECT(
	CIN				VARCHAR2(20),
	NOM				VARCHAR2(20),
	PRENOM			VARCHAR2(20),
	AGE				NUMBER(2),
	ADR_PRIVE		T_ADR,
	ADR_PUB			REF T_ADR,

	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN NUMBER) RETURN SELF AS RESULT,
	constructor function T_PERS(c IN varchar2, n IN varchar2, p IN varchar2) RETURN SELF AS RESULT,

	member function AGE_PERS RETURN NUMBER,

	member procedure modif_ADR_PRIV_PERS (a IN T_ADR),
	member procedure modif_ADR_PUB_PERS (R IN REF T_ADR),

	member function MEME_ADR_PRIVEE_PERS(ADR_PRIVE IN T_ADR) RETURN BOOLEAN,

	static procedure ajouter_PERS(c IN varchar2, n IN varchar2, p IN varchar2, a IN number),
	static procedure ajouter_PERS(P IN T_PERS),

	static procedure supprimer_PERS(P IN T_PERS)
);
/

------------------------------------------------------------------------------
----		FIN CREATION DU TYPE T_PERS
------------------------------------------------------------------------------