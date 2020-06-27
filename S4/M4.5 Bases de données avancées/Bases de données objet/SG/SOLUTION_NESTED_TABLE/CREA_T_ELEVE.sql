------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		TYPE T_ELEVE
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--creation du type des ELEVES

CREATE OR REPLACE TYPE T_ELEVE AS OBJECT (
	NUMETD		NUMBER(10),
	NOM		VARCHAR2(20),
	PRENOM		VARCHAR2(20),
	ANNEINSCRIP	DATE

	--LES CINSTRUCTEURS
	--constructor function T_ELEVE (NETD IN NUMBER, N IN varchar2, P IN varchar2, D IN DATE) RETURN SELF AS RESULT,
	--constructor function T_ELEVE (NETD IN NUMBER, I IN varchar2 ) RETURN SELF AS RESULT,
	--member function DATE_INSCR_ELEVE RETURN DATE	
);
/


------------------------------------------------------------------------------
----		FIN DU TYPE T_ELEVE 
------------------------------------------------------------------------------

--creation du type TABLE IMBRIQUEE DES ELEVES D'UNE CLASSE

CREATE OR REPLACE TYPE T_LISTE_ELEVES AS TABLE OF REF T_ELEVE;
/
