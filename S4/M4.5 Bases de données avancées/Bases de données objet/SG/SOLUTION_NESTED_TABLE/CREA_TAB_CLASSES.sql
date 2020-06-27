------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		TABLE DES CLASSES
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


--CREATION DE LA TABLE DES CLASSES

CREATE TABLE TAB_CLASSES OF T_CLASSE(
	CONSTRAINT PK_TAB_CL PRIMARY KEY (NUMCLASSE),
	CONSTRAINT CHECK_NIVCL_NN CHECK (NIVCLASSE IS NOT NULL)
)
NESTED TABLE LISTE_ELEVES STORE AS TAB_STOCK_ELEVES,
NESTED TABLE LISTE_SEANCES STORE AS TAB_STOCK_SEANCES;



--TABLES DES CLASSES

------------------------------------------------------------------------------
----		FIN DU TYPE T_COURS 
------------------------------------------------------------------------------
-- INSERTION

INSERT INTO TAB_CLASSES VALUES(
	1,
	'4IIR',
	T_LISTE_ELEVES(
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=1),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=2),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=3),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=4),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=5),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=6),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=7),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=8),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=9),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=10),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=11),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=12),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=13),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=14)
	),
	T_LISTE_COURS(
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3)
	),
	T_LISTE_SEANCES(
	   T_SEANCE(1,'10/9/2014', 8, 10, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(2,'10/9/2014', 10, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
	   T_SEANCE(3,'10/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(4,'10/9/2014', 16, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(5,'11/9/2014', 14, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
           T_SEANCE(6,'12/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3), 1 ),
	   T_SEANCE(7,'12/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3), 1 ),
	   T_SEANCE(8,'13/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(9,'14/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
	   T_SEANCE(10,'14/9/2014', 8, 10, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(11,'14/9/2014', 10, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
	   T_SEANCE(12,'14/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(13,'15/9/2014', 16, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(14,'16/9/2014', 14, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
           T_SEANCE(15,'16/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3), 1 ),
	   T_SEANCE(16,'17/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3), 1 ),
	   T_SEANCE(17,'18/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(18,'19/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
	   T_SEANCE(19,'20/9/2014', 8, 10, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(20,'20/9/2014', 10, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
	   T_SEANCE(21,'20/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(22,'20/9/2014', 16, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(23,'21/9/2014', 14, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
           T_SEANCE(24,'21/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3), 1 ),
	   T_SEANCE(25,'22/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3), 1 ),
	   T_SEANCE(26,'23/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(27,'24/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 )
	)
);


INSERT INTO TAB_CLASSES VALUES(
	2,
	'3IIR',
	T_LISTE_ELEVES(),
	T_LISTE_COURS(
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=6),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7)
	),
	T_LISTE_SEANCES()
);


INSERT INTO TAB_CLASSES VALUES(
	3,
	'2IIR',
	T_LISTE_ELEVES(
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=15),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=16),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=17),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=18),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=19),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=20),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=21),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=22),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=23),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=24),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=25),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=26),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=27),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=28)
	),
	T_LISTE_COURS(
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=6),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7)
	),
	T_LISTE_SEANCES()
);


-- TOUS LES COURS NE SONT PAS PROGRAMMES ET D'AUTRES NE FONT PAS PARTIE DE LA LISTE
-- COURS PREVUES ET NON PROGRAMMES: 6 ET 3
-- COURS PROGRAMMES ALORS QU'ILS NE SONT PAS PREVUS: 1 ET 2

INSERT INTO TAB_CLASSES VALUES(
	4,
	'2IIR',
	T_LISTE_ELEVES(
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=29),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=30),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=31),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=32),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=33),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=34),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=35),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=36),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=37),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=38),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=39),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=40),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=41),
		(SELECT REF(D) FROM TAB_ELEVES D WHERE NUMETD=42)
	),
	T_LISTE_COURS(
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=6),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7),
		(SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=3)
	),
	T_LISTE_SEANCES(
	   T_SEANCE(1,'10/9/2014', 8, 10, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4), 1 ),
	   T_SEANCE(2,'10/9/2014', 10, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5), 1 ),
	   T_SEANCE(3,'10/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(4,'10/9/2014', 16, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4), 1 ),
	   T_SEANCE(5,'11/9/2014', 14, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5), 1 ),
           T_SEANCE(6,'12/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5), 1 ),
	   T_SEANCE(7,'12/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5), 1 ),
	   T_SEANCE(8,'13/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(9,'14/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(10,'14/9/2014', 8, 10, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(11,'14/9/2014', 10, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(12,'14/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4), 1 ),
	   T_SEANCE(13,'15/9/2014', 16, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4), 1 ),
	   T_SEANCE(14,'16/9/2014', 14, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4), 1 ),
           T_SEANCE(15,'16/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=4), 1 ),
	   T_SEANCE(16,'17/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5), 1 ),
	   T_SEANCE(17,'18/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=5), 1 ),
	   T_SEANCE(18,'19/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(19,'20/9/2014', 8, 10, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(20,'20/9/2014', 10, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(21,'20/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(22,'20/9/2014', 16, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=1), 1 ),
	   T_SEANCE(23,'21/9/2014', 14, 18, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 ),
           T_SEANCE(24,'21/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(25,'22/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(26,'23/9/2014', 14, 16, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=7), 1 ),
	   T_SEANCE(27,'24/9/2014', 8, 12, (SELECT REF(D) FROM TAB_COURS D WHERE D.NUMCOURS=2), 1 )
	)
);
--VALIDATION
COMMIT;