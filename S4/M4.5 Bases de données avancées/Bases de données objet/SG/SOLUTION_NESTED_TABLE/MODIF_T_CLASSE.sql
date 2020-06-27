------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		AJOUT DE LA METHODE AJOUTER_SEANCE DANS LE T_CLASSE  
---- AVEC LES REGLES SUIVANTES:
---- SI LE COURS N'EST PAS PROGRAMME UNE EXCEPTION EST GENEREE
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

ALTER TYPE T_CLASSE 
ADD MEMBER PROCEDURE AJOUTER_SEANCE(N IN NUMBER, D IN DATE, HD IN NUMBER, HF IN NUMBER, NC IN NUMBER)
CASCADE;

-- CREATION DU CORPS DE LA METHODE
CREATE OR REPLACE TYPE BODY T_CLASSE AS
	MEMBER PROCEDURE AJOUTER_SEANCE(N IN NUMBER, D IN DATE, HD IN NUMBER, HF IN NUMBER, REFC IN REF T_COURS, NS IN NUMBER) IS
		REFCOURS		REF T_COURS;
		LISTEREFCOURS		T_LISTE_COURS;
		EXIST			BOOLEAN;
		I			INGTEGER;
		EXC_COURS_INEX		EXCEPTION;
		EXC_LCOURS_VIDE		EXCEPTION;
		EXC_COURS_NPROG		EXCEPTION;
	BEGIN
		--VERIFIER LA REF DU COURS EXISTE
		SELECT REF(D) INTO RECCOURS FROM TAB_COURS D
		WHERE D.NUMCOURS=NC;
		
		IF REFCOURS IS NULL
		THEN RAISE EXC_COURS_INEX;
		ELSE 	SELECT LISTE_COURS INTO LISTEREFCOURS 
			FROM TAB_CLASSES
			WHERE NUMCLASSE=SELF.NUMCLASSE;
			
			-- verifier si la liste des cours est vide
			IF LISTE_COURS IS NULL
			THEN RAISE EXC_LCOURS_VIDE;
			ELSIF 	EXIST:=FALSE; 
				WHILE NOT EXIST AND i<=LISTE_COURS.COUNT() LOOP
					IF RECCOURS=LISTE_COURS(I)
					THEN EXIST:=TRUE;
					END IF;
				END LOOP;
				IF NOT EXIST 
				THEN RAISE EXC_COURS_NPROG;
				ELSE -- VERFIFIER LES CONFLIST DE SEANCES ET DE SALLLE
					SELECT S.NUMSEAN INTO NS
					FROM TAB_CLASSES C, TABLE(C.LES_SEANCES) S
					WHERE S.DATESEAN=D AND S.HDEBUT=HD AND S.HFIN=HF AND S.NUMSALLE=NS
	END AJOUTER_SEANCE;
END;
/

--creation du type des TABLEAU DES COURS SUIVIS PAR UNE CLASSE

CREATE OR REPLACE TYPE T_LISTE_COURS AS VARRAY(10) OF REF T_COURS;
/

-- CREATION DU TYPE DES CLASSES.

CREATE OR REPLACE TYPE T_CLASSE AS OBJECT(
	NUMCLASSE	NUMBER(2),
	NIVCLASSE	VARCHAR2(20),
	LISTE_ELEVES	T_LISTE_ELEVES,
	LISTE_COURS	T_LISTE_COURS,
	LISTE_SEANCES	T_LISTE_SEANCES
);
/


------------------------------------------------------------------------------
----		FIN DU TYPE T_CLASSE 
------------------------------------------------------------------------------
