------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		TEST DE LA METHODE AJOUETRE PROF
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-------------------------------------------------------------------

-- Y A ENCORE UNE PLACE
DECLARE
	COURS		T_COURS;

BEGIN
	SELECT VALUE(D) INTO COURS FROM TAB_COURS D WHERE D.NUMCOURS=3;
	COURS.AJOUTER_PROF('d12434');
END;
/

-------------------------------------------------------------------
--TEST PAS DE PLACE: LISTE SATUREE
DECLARE
	COURS		T_COURS;

BEGIN
	SELECT VALUE(D) INtO COURS FROM TAB_COURS D WHERE D.NUMCOURS=2;
	COURS.AJOUTER_PROF('F12434');
END;
/

-------------------------------------------------------------------
-- TEST LA LISTE NON CREE AU DEPART COURS NUMERO 4
DECLARE
	COURS		T_COURS;

BEGIN
	SELECT VALUE(D) INtO COURS FROM TAB_COURS D WHERE D.NUMCOURS=4;
	COURS.AJOUTER_PROF('F12434');
END;
/

-------------------------------------------------------------------
-- TEST LA LISTE  CREE VIDE AU DEPART COURS NUMERO 1
DECLARE
	COURS		T_COURS;

BEGIN
	SELECT VALUE(D) INtO COURS FROM TAB_COURS D WHERE D.NUMCOURS=1;
	COURS.AJOUTER_PROF('F12434');
END;
/

-------------------------------------------------------------------
-- TEST AVEC LA METHODE AJOUTER_PORF AVEC LA METHODE EXISTE_PROF
DECLARE
	COURS		T_COURS;
	EXC_PROF_EXISTE	EXCEPTION;

BEGIN
	SELECT VALUE(D) INtO COURS FROM TAB_COURS D WHERE D.NUMCOURS=3;
	IF COURS.EXISTE_PROF('F12434')
	THEN RAISE EXC_PROF_EXISTE;
	ELSE COURS.AJOUTER_PROF('F12434');
	END IF;
	EXCEPTION
		WHEN EXC_PROF_EXISTE THEN DBMS_OUTPUT.PUT_LINE ('ERR EXC_PROF_EXISTE: PROF EXISTE DEJA DANS LA LISTE!!');
END;
/

-------------------------------------------------------------------
-- TEST DE LA METHODE AJOUTER_COURS AVEC UNE SIMPLE AFFECTATION DE LA LISTE DES ENS
-- AVEC LE TEST DE LA PRIMARY KEY

DECLARE
	LP		T_LISTE_ENS;
	REF1		REF T_PERS;
	REF2		REF T_PERS;
BEGIN
	SELECT REF(D) INTO REF1 FROM TAB_PERS D WHERE D.CIN='F12434';
	SELECT REF(D) INTO REF2 FROM TAB_PERS D WHERE D.CIN='g12434';
	LP:=NEW T_LISTE_ENS(REF1, REF2); 
	T_COURS.AJOUTER_COURS(9, 'TOTO', 90, LP);
END;
/

-------------------------------------------------------------------
-- TEST DE LA METHODE AJOUTER_COURS

DECLARE
	LP		T_LISTE_ENS;
	REF1		REF T_PERS;
	REF2		REF T_PERS;
BEGIN
	SELECT REF(D) INTO REF1 FROM TAB_PERS D WHERE D.CIN='F12434';
	SELECT REF(D) INTO REF2 FROM TAB_PERS D WHERE D.CIN='g12434';
	LP:=NEW T_LISTE_ENS(REF1, REF2); 
	T_COURS.AJOUTER_COURS(1, 'TOTO', 90, LP);
END;
/

-------------------------------------------------------------------
-- TEST DE LA METHODE RETIRER_PROF (CIN_PROF IN varchar2)

DECLARE
	COURS		T_COURS;
BEGIN
	SELECT VALUE(D) INtO COURS FROM TAB_COURS D WHERE D.NUMCOURS=2;
	COURS.RETIRER_PROF('Z12434');
END;
/

-------------------------------------------------------------------
-- QUESTION : AFFICHER LA LSITE DES PROFESSEURS (CIN) QUI INTERVIENNENT DANS LE COURS NUMERO 2

-- AFFICHAGE DES CIN DES ENSEIGNANTS DU COURS NUMERO 2
DECLARE		
	TYPE T_LISTE_CIN IS VARRAY(3) OF VARCHAR2(20);
	LISTE_CIN		T_LISTE_CIN;
	LISTE_REF		T_LISTE_ENS;
	EXC_LISTE_VIDE		EXCEPTION;
	TAILLE			NUMBER;
	I			NUMBER;
	TEMP_CIN		VARCHAR2(20);
BEGIN
		
	SELECT LISTE_ENS INTO LISTE_REF 
	FROM TAB_COURS
	WHERE NUMCOURS=2;

	IF LISTE_REF IS NULL
	THEN RAISE EXC_LISTE_VIDE;
	ELSE	LISTE_CIN:=NEW T_LISTE_CIN();
		TAILLE:=LISTE_REF.COUNT();
		
		FOR I IN 1..TAILLE LOOP
			SELECT CIN INTO TEMP_CIN
			FROM TAB_PERS D
			WHERE REF(D)=LISTE_REF(I);

			LISTE_CIN.EXTEND();
			LISTE_CIN(I):=TEMP_CIN;

		END LOOP;

		-- AFFICHAGE
		FOR I IN 1..TAILLE LOOP
			DBMS_OUTPUT.PUT_LINE (LISTE_CIN(I));
		END LOOP;
	END IF;
		
	--TRAITEMENT DES EXCEPTIONS
	EXCEPTION
			WHEN  EXC_LISTE_VIDE THEN DBMS_OUTPUT.PUT_LINE ('ERR  EXC_LISTE_VIDE: LA LISTE EST VIDE!!');
END;
/

-------------------------------------------------------------------

-- QEUESTION: AFFICHER PAR UNE REQUETE LA LISTE DES PROFESSEURS QUI N'INTERVIENNENT DANS AUCUN COURS

-- LES ENS QUI N'ASSURENT AUCUN COURS

SELECT D.CIN
FROM TAB_PERS D
WHERE REF(D) NOT IN (SELECT R.* FROM TAB_COURS C, TABLE(C.LISTE_ENS) R);


-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------

-- QUESTION: DANS UN BLOC PL/SQL, TESTER LA METHODE LISTE_COURS_PROF

--	POUR AFFICHER LES COURS DE LA PERSONNE DE CIN X12434
-- ca marche pas
-- TEST DE LA METHODE MEMBER FUNCTION LISTE_COURS_PROF RETURN T_LISTE_COURS_PROF

DECLARE
	LISTE_COURS		T_LISTE_COURS_PROF:=NEW T_LISTE_COURS_PROF();
	PROF			T_PERS;
	NBR			NUMBER:=0;
	I			NUMBER;
	
BEGIN
	SELECT VALUE(D) INTO PROF FROM TAB_PERS D WHERE D.CIN='X12434';
	LISTE_COURS:=PROF.LISTE_COURS_PROF();
	NBR:=LISTE_COURS.COUNT();
	DBMS_OUTPUT.PUT_LINE ('NOMBRE DE COURS :'||'   '||NBR);
	FOR I IN 1..NBR LOOP
		DBMS_OUTPUT.PUT_LINE ('COURS NUMERO  :'||'   '||LISTE_COURS(I));
	END LOOP;
END;
/

-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------

--TEST DE LA MEME FONCTION AVEC UNE REQUETES

--QUESTION: DONNER PAR UNE REQUETES LA LISTE DES COURS OU INTERVIENT LE PROFESSEUR DE CIN X12434

SELECT C1.NUMCOURS
FROM TAB_COURS C1
WHERE (SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='X12434') 
	IN 
	(SELECT E.* FROM TAB_COURS C2, TABLE(C2.LISTE_ENS) E WHERE C1.NUMCOURS=C2.NUMCOURS);

-- QUESTION: TESTER LA MEME METHODE DIRECTEMENT DANS UNE REQUETE SQL

-- TEST DE LA MEME CHOSE AVEC LA FONCTION DANS LA REQUETE CA MARCHE PAS. CABOUCLE

SELECT D.LISTE_COURS_PROF() 
FROM TAB_PERS D
WHERE D.CIN='X12434';

-------------------------------------------------------------------
-------------------------------------------------------------------

-- QUESTION: AFFICHER LES CIN DES PROFS QUI INTERVIENNENT DANS LE COURS NUMERO é

-- test d'une fonction avec un retour de varray comme resultat
-- et test de l'affichage d'une ref dans dbms...
-- le test dans le T_cours et la fonction member function LISTE_PROF RETURN T_LISTE_ENS,

DECLARE
	LISTE_PROFS		T_LISTE_ENS:=NEW T_LISTE_ENS();
	COURS			T_COURS;
	NBR			NUMBER:=0;
	I			NUMBER;
	CIN_PROF		VARCHAR2(20);
	
BEGIN
	SELECT VALUE(D) INTO COURS FROM TAB_COURS D WHERE D.NUMCOURS=2;
	LISTE_PROFS:=COURS.LISTE_PROF();

	NBR:=LISTE_PROFS.COUNT();
	DBMS_OUTPUT.PUT_LINE ('NUMERO DU COURS :  '|| COURS.NUMCOURS||'  NOMBRE DU PROF :'||'   '||NBR);
	FOR I IN 1..NBR LOOP
		SELECT D.CIN INTO CIN_PROF FROM TAB_PERS D WHERE REF(D)=LISTE_PROFS(I);
		DBMS_OUTPUT.PUT_LINE ('CIN DU PROF INTERVENANT :  '||'   '||CIN_PROF);
	END LOOP;
END;
/

-- DBMS n'affiche pas les ref directement.
-------------------------------------------------------------------
-------------------------------------------------------------------

-- TEST DE LA FONCTION TRIM
DECLARE
	LISTE 		T_LISTE_ENS;
	COURS			T_COURS;
BEGIN
	SELECT LISTE_ENS INTO LISTE FROM TAB_COURS WHERE NUMCOURS=2;
	LISTE.TRIM(1);
	UPDATE TAB_COURS
	SET LISTE_ENS=LISTE
	WHERE NUMCOURS=2;
	COMMIT;
END;
/
