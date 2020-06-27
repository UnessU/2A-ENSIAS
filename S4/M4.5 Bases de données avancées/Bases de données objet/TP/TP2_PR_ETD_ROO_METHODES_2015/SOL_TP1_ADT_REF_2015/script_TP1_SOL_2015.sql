--execution
-- @E:\THOR\BDOO_ENSIAS\BDOO_ENSIAS_2015\ROO_ENSIAS_2015\TP1_ROO_2015\SOL_TP1_2015\script_tp1_sol_2015.sql
---tracage
set echo on;
set serveroutput on;

spool E:\THOR\BDOO_ENSIAS\BDOO_ENSIAS_2015\ROO_ENSIAS_2015\TP1_ROO_2015\SOL_TP1_2015\trace_script_TP1.txt

set echo on;

--nettopyage (uniquement pour les tests)

drop type T_PERSONNE;
drop table TAB_PERS;
drop table tab_adrs;
drop type t_adr;

------------------------------------------------------------------------------------------
-- 1.	Créer le type objet T_ADR défini  par :
------------------------------------------------------------------------------------------

--creation de type adresse
create or replace type t_adr as object(
	rue		varchar2(20),
	mais		number(2),
	ville		varchar2(20),
	pays		varchar2(20)
);
/

--test du schéma du type
desc t_adr;

------------------------------------------------------------------------------------------
--- 2.	Créer la table objet des adresses TAB_ADRS à partir du type T_ADR avec 
--  les contraintes suivantes : (rue, mais, ville) est clé primaire et le pays ne doit pas 
--  être null.
--creation de la table objet des adresses
------------------------------------------------------------------------------------------

create table tab_adrs of t_adr(
	constraint pk_tab_adr primary key (rue, mais, ville),
	constraint c_ville_nn CHECK (ville  IS not null),
	constraint c_pays_nn  CHECK (pays  IS not null)
);

--test du schéma 
desc tab_adrs;

------------------------------------------------------------------------------------------
-- 3.	Insérer des  données dans la table TAB_ADRS
--insertion dans la table objets des adresses
------------------------------------------------------------------------------------------

insert into tab_adrs values ('rue1', 1, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 2, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 3, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 4, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 5, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 6, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 1, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 2, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 3, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 4, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 5, 'ville1', 'maroc');
insert into tab_adrs values ('rue2', 6, 'ville1', 'maroc');
insert into tab_adrs values ('rue1', 1, 'ville2', 'maroc');
insert into tab_adrs values ('rue1', 2, 'ville2', 'maroc');
insert into tab_adrs values ('rue1', 3, 'ville2', 'maroc');
insert into tab_adrs values ('rue1', 4, 'ville2', 'maroc');
insert into tab_adrs values ('rue1', 5, 'ville2', 'maroc');
insert into tab_adrs values ('rue1', 6, 'ville2', 'maroc');

-- LES ADRESSE A SUPPRIMER
insert into tab_adrs values ('rueQQ', 55, 'ville55', 'maroc');
insert into tab_adrs values ('rueWW', 66, 'ville66', 'maroc');


--validation
commit;

------------------------------------------------------------------------------------------
--- 4.	Afficher le contenu de la table
------------------------------------------------------------------------------------------

SELECT * FROM TAB_ADRS;

------------------------------------------------------------------------------------------
--- 5.	Afficher les références des objets de la table tab_adrs
--TEST DES REFERENCES DANS LA TABLE TAB_ADRS
--1. Afficher les références des objets de la table tab_adrs
------------------------------------------------------------------------------------------

SELECT REF(D) FROM TAB_ADRS D;

------------------------------------------------------------------------------------------
--- 6.	Afficher les différents champs de la table TAB_ADRS avec leurs références
-- AFFICHAGE DES REFERENCES AVEC LES OBJETS 
------------------------------------------------------------------------------------------
SELECT REF(D), D.* FROM TAB_ADRS D;

-- ou bien
SELECT REF(D), VALUE(D) FROM TAB_ADRS D;

------------------------------------------------------------------------------------------
--- 7. Afficher les adresses d’une ville avec leurs références
--SELECTIONNER LES ADRESSES DE LA MEME VILLE VILLE2 AVEC LEURS REFERENCES
------------------------------------------------------------------------------------------

SELECT REF(D), D.* FROM TAB_ADRS D WHERE D.VILLE='ville2';

-- ou bien
SELECT REF(D), VALUE(D) FROM TAB_ADRS D WHERE D.VILLE='ville2';


------------------------------------------------------------------------------------------
--- 8.	Créer  le type personne T_PERSONNE définir par :
--PARTAGE DES REFERENCES
------------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE T_PERSONNE AS OBJECT(
	CIN		VARCHAR2(20),
	NOM		VARCHAR2(20),
	PRENOM		VARCHAR2(20),
	AGE		NUMBER(2),
	ADR_PRIVE	T_ADR,
	ADR_PUB		REF T_ADR
);
/

------------------------------------------------------------------------------------------
--- 9.	Créer la table objet TAB_PERS à partir du type T_PERSONNE avec les contraintes suivantes : 
-- cin comme clé primaire, nom, prenom et age ne doivent pas être nuls, 
-- adr_prive ne doit pas être nulle, et adr_pub doit faire référence uniquement sur les objets 
-- de la table TAB_ADRS
--CREATION DE LA TABLE OBJETS DES PERSONNES
------------------------------------------------------------------------------------------

CREATE TABLE TAB_PERS OF T_PERSONNE(
	CONSTRAINT PK_TAB_PERS PRIMARY KEY (CIN),
	CONSTRAINT C_NOM_NN CHECK (NOM  IS not null),
	CONSTRAINT C_AGE_NN CHECK (AGE  IS NOT NULL),
	CONSTRAINT C_ADR_PRIV_NN CHECK (ADR_PRIVE  IS NOT NULL),
	CONSTRAINT C_REF ADR_PUB SCOPE IS TAB_ADRS
);	

------------------------------------------------------------------------------------------
--10.  INSERTION DANS LA TABLE TAB_PERS
------------------------------------------------------------------------------------------

-- MEME ADRESSE PUBLIQUES

INSERT INTO TAB_PERS VALUES ('k12434', 'nom1', 'prenom1', 34, T_ADR('r1', 1, 'v1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=1 AND D.VILLE='ville1')
);

INSERT INTO TAB_PERS VALUES ('d12434', 'nom2', 'prenom2', 44, T_ADR('r2', 2, 'v2', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=1 AND D.VILLE='ville1')
);

-- ADRESSE PUBLIQUES DIFFERENTE

INSERT INTO TAB_PERS VALUES ('X12434', 'nom3', 'prenom3', 24, T_ADR('r3', 3, 'v3', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=2 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('Z12434', 'nom4', 'prenom4', 45, T_ADR('r1', 1, 'v1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=3 AND D.VILLE='ville1')
);

INSERT INTO TAB_PERS VALUES ('F12434', 'nom5', 'prenom5', 36, T_ADR('r4', 4, 'v4', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=2 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('g12434', 'nom6', 'prenom6', 66, T_ADR('r6', 6, 'v6', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

-- LES MEMES ADRESSES PUBLIQUES

INSERT INTO TAB_PERS VALUES ('T12434', 'nom7', 'prenom7', 55, T_ADR('r1', 1, 'v1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('M12434', 'nom8', 'prenom8', 23, T_ADR('r8', 8, 'v8', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('N12434', 'nom9', 'prenom9', 33, T_ADR('r9', 9, 'v9', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

-- MEME ADRESSE PUBLIQUE ET PRIVEE

INSERT INTO TAB_PERS VALUES ('AQ12434', 'nom9', 'prenom9', 33, T_ADR('rue1', 4, 'ville2', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=4 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('BQ12434', 'nom10', 'prenom10', 36, T_ADR('rue1', 6, 'ville2', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue1' AND D.MAIS=6 AND D.VILLE='ville2')
);

INSERT INTO TAB_PERS VALUES ('QQ12434', 'nom11', 'prenom11', 63, T_ADR('rue2', 4, 'ville1', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue2' AND D.MAIS=4 AND D.VILLE='ville1')
);

-- LES PERSONNES DONT L ADRESSE PUBLIQUE EST NULL
INSERT INTO TAB_PERS VALUES ('AQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue11', 11, 'ville11', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue11' AND D.MAIS=11 AND D.VILLE='ville11')
);

INSERT INTO TAB_PERS VALUES ('BQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue22', 22, 'ville22', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue22' AND D.MAIS=22 AND D.VILLE='ville22')
);

INSERT INTO TAB_PERS VALUES ('CQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue33', 33, 'ville33', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue33' AND D.MAIS=33 AND D.VILLE='ville33')
);

INSERT INTO TAB_PERS VALUES ('DQQ12434', 'nom11', 'prenom11', 63, T_ADR('rue44', 44, 'ville44', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rue44' AND D.MAIS=44 AND D.VILLE='ville44')
);

-- PERSONNES POUR SUPPRIMER SON ADRESSE REFERENCE
INSERT INTO TAB_PERS VALUES ('QQQQQ', 'nom55', 'prenom55', 43, T_ADR('rue55', 55, 'ville55', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rueQQ' AND D.MAIS=55 AND D.VILLE='ville55')
);

INSERT INTO TAB_PERS VALUES ('WWWWW', 'nom66', 'prenom66', 13, T_ADR('rue66', 66, 'ville66', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rueWW' AND D.MAIS=66 AND D.VILLE='ville66')
);

-- ADRESSE PUBLIQUE NULL
INSERT INTO TAB_PERS VALUES ('FFFFF', 'nom99', 'prenom99', 99, T_ADR('rue99', 99, 'ville99', 'maroc'),
	(SELECT REF(D) FROM TAB_ADRS D WHERE D.RUE='rueFFF' AND D.MAIS=99 AND D.VILLE='ville99')
);

INSERT INTO TAB_PERS VALUES ('XXXXX', 'nom88', 'prenom88', 88, T_ADR('rue88', 88, 'ville88', 'maroc'),
	NULL
);

--validation
commit;

------------------------------------------------------------------------------------------
-- 11.	Afficher les adresses privées de toutes les personnes
-- AFFICHAGE DES ADRESSES PRIVEES
------------------------------------------------------------------------------------------

SELECT ADR_PRIVE FROM TAB_PERS;

------------------------------------------------------------------------------------------
-- 12.	Afficher la rue et le numéro de maison des adresses privées de toutes les personnes
--APPLATISSEMENT DES RUE ET MAISON
-- REMARQUE: SANS ALIAS CA NE MARCHE PAS
------------------------------------------------------------------------------------------

SELECT D.ADR_PRIVE.RUE, D.ADR_PRIVE.MAIS FROM TAB_PERS D;

------------------------------------------------------------------------------------------
-- 13.	Afficher les adresses publiques de toutes les personnes
-- directement les références stockées dans la colonne ADR_PUB
------------------------------------------------------------------------------------------

SELECT ADR_PUB FROM TAB_PERS;

-- si on veut les adresses référencées et non les références
--LES ADRESSES PUBLIQUES DES PERSONNES
SELECT DEREF(ADR_PUB) FROM TAB_PERS;

------------------------------------------------------------------------------------------
-- 14.	Afficher la rue et le numéro de maison des adresses publiques de toutes les personnes
--LES RUES ET LES MAISONS DES ADRESSES PUBLIQUES
------------------------------------------------------------------------------------------

SELECT D.ADR_PUB.RUE, D.ADR_PUB.MAIS FROM TAB_PERS D;

-- on peut le faire également en passant par la table des adresses

select d.rue, d.mais
from tab_adrs d
where REF(d) IN (select ADR_PUB from tab_pers);

-- ESSAI AVEC DEREF ET PROJECTION
-- REMARQUE: AVEC DEREF CA NE MARCHE PAS

SELECT DEREF(ADR_PUB) AS AP, AP.RUE, AP.MAIS FROM TAB_PERS;

------------------------------------------------------------------------------------------
-- 15.	Afficher les personnes qui habitent la même rue de la même ville (adresses privées)
---LES PERSONNES QUI HABITENT LA MEME RUE DE LA MEME VILLE (ADRESSES PRIVEES)
------------------------------------------------------------------------------------------

SELECT DISTINCT(A.CIN), A.NOM, A.PRENOM --,A.ADR_PRIVE.RUE, B.ADR_PRIVE.RUE,A.ADR_PRIVE.VILLE,B.ADR_PRIVE.VILLE   
FROM TAB_PERS A, TAB_PERS B
WHERE A.ADR_PRIVE.RUE=B.ADR_PRIVE.RUE AND A.ADR_PRIVE.VILLE=B.ADR_PRIVE.VILLE AND A.CIN<>B.CIN; 

------------------------------------------------------------------------------------------
-- 16.	Afficher les personnes qui ont la même adresse privée que la personne de cin t12434
------------------------------------------------------------------------------------------

SELECT DISTINCT(B.CIN), B.NOM, B.PRENOM --,A.ADR_PRIVE.RUE, B.ADR_PRIVE.RUE,A.ADR_PRIVE.VILLE,B.ADR_PRIVE.VILLE   
FROM TAB_PERS A, TAB_PERS B
WHERE A.CIN='T12434' AND A.ADR_PRIVE.RUE=B.ADR_PRIVE.RUE AND A.ADR_PRIVE.VILLE=B.ADR_PRIVE.VILLE AND A.CIN<>B.CIN; 

------------------------------------------------------------------------------------------
-- 17.	Afficher  les personnes qui ont la même adresse publique
-- LES PERSONNES QUI ONT LA MEME ADRESSE PRIVEE QUE LA PERSONNE DE CIN T12434
------------------------------------------------------------------------------------------

SELECT DISTINCT(CIN), NOM, PRENOM
FROM TAB_PERS 
WHERE ADR_PUB =(SELECT ADR_PUB FROM TAB_PERS WHERE CIN='T12434');

-- MEME CHOSE AVEC in
SELECT DISTINCT(CIN), NOM, PRENOM
FROM TAB_PERS 
WHERE ADR_PUB IN (SELECT ADR_PUB FROM TAB_PERS WHERE CIN='T12434');

-- autre façon: jointure
select distinct(CIN), nom, prenom
from tab_pers p1, tab_pers p2
where p1.cin='T12434' AND p1.ADR_PUB=p2.ADR_PUB AND p1.CIN<>p2.CIN;

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- LES PERSONNES QUI ONT LA MEME ADRESSE PUBLIQUE
SELECT DISTINCT(A.CIN), A.NOM, A.PRENOM
FROM TAB_PERS A, TAB_PERS B 
WHERE A.ADR_PUB = B.ADR_PUB AND A.CIN<>B.CIN;

------------------------------------------------------------------------------------------
-- 18.	Afficher les personnes qui ont la même adresse publique et prive 
-- (adresse privée=adresse publique)
-- LES PERSONNES QUI ONT LA MEME ADRESSE PUBLIQUE ET PRIVE
------------------------------------------------------------------------------------------

SELECT DISTINCT(A.CIN), A.NOM, A.PRENOM
FROM TAB_PERS A, TAB_PERS B 
WHERE A.ADR_PUB.RUE = B.ADR_PRIVE.RUE AND A.ADR_PUB.VILLE = B.ADR_PRIVE.VILLE 
	AND A.ADR_PUB.PAYS = B.ADR_PRIVE.PAYS AND A.ADR_PUB.MAIS = B.ADR_PRIVE.MAIS AND A.CIN=B.CIN;


------------------------------------------------------------------------------------------
---19.	Afficher les personnes dont l adresse publique est nulle
-- LES PERSONNES DONT L ADRESSE PUBLIQUE EST NULL
------------------------------------------------------------------------------------------

SELECT DISTINCT(A.CIN), A.NOM, A.PRENOM
FROM TAB_PERS A
WHERE A.ADR_PUB IS NULL;

------------------------------------------------------------------------------------------
-- 20.	Dans la table TAB_ADRS, supprimer quelques adresses connaissant les personnes 
-- qui les utilisent
-- TEST DE SUPPRESSION D UNE ADRESSE REFERENCEE
-- TEST DES PERSONNES CONCERNEES
------------------------------------------------------------------------------------------

SELECT CIN, NOM, PRENOM, ADR_PUB
FROM TAB_PERS
WHERE CIN='QQQQQ' OR CIN='WWWWW';

-- SUPPRESSION DES ADRESSES PUBLIQUES 
DELETE FROM TAB_ADRS D
WHERE REF(D) IN (SELECT ADR_PUB FROM TAB_PERS WHERE CIN='QQQQQ' OR CIN='WWWWW');

-- TEST DES PERSONNES DONT L ADRESSE PUBLIQUES EST NULL
SELECT DISTINCT(A.CIN), A.NOM, A.PRENOM
FROM TAB_PERS A
WHERE A.ADR_PUB IS NULL;

------------------------------------------------------------------------------------------
-- 21.	Afficher les personnes dont l’adresse publique est déglingué 
-- (l’objet référencé n’existe plus dans la table TAB_ADRS)
-- CHERCHER LES PERSONNES DONT L ADRESSE PUB EST DEGLINGUEE
------------------------------------------------------------------------------------------

SELECT CIN, NOM, PRENOM
FROM TAB_PERS
WHERE ADR_PUB NOT IN (SELECT REF(D) FROM TAB_ADRS D) AND ADR_PUB  IS NOT NULL;

-- SI ON ELEVE NULL
-- CETTE REQUETE NE PREND QUE LES REF NOT NULL
SELECT CIN, NOM, PRENOM
FROM TAB_PERS
WHERE ADR_PUB NOT IN (SELECT REF(D) FROM TAB_ADRS D);

-- CETTE REQUETE DONNE D'AUTRES NOMS--> LE NULL N EST PAS CONSIDRE COMME FAISANT PARTIE DES REF DE TAB_ADRS
SELECT CIN, NOM, PRENOM
FROM TAB_PERS
WHERE ADR_PUB IS NULL;

-- METTRE A JOUR LES REF DEGLINGUEES A NULL
UPDATE TAB_PERS
SET ADR_PUB=NULL
WHERE ADR_PUB NOT IN (SELECT REF(D) FROM TAB_ADRS D);

------------------------------------------------------------------------------------------
-- normalement y a une fonction prédéfinie dans Oracle pour tester les références
-- diglinguées. Mais, on peut le faire tout simplement comme ci-dessus
------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
--P.S. pour les fautes de frappe dans les commentaires, corrigez-les vous même. Ca vous fera
-- un exercice.
------------------------------------------------------------------------------------------

spool off;
