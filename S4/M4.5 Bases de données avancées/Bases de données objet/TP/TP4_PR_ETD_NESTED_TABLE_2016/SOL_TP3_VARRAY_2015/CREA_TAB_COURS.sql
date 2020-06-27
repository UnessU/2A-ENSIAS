------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		CREATION DE LA TABLE OBJET DES COURS: TAB_COURS
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


--CREATION DE LA TABLE OBJETS DES COURS
CREATE TABLE TAB_COURS OF T_COURS(
	CONSTRAINT PK_TAB_COURS PRIMARY KEY (NUMCOURS),
	CONSTRAINT C_INTIT_COURS_NN CHECK (INTIT  IS not null)
);	

---------------------------------------------------------------------------------
--- 			INSERTION DES DONNEES DANS LA TAB_PERS
---------------------------------------------------------------------------------


-- MEME ADRESSE PUBLIQUES

INSERT INTO TAB_COURS VALUES ( 1, 'BD', 30, T_LISTE_ENS()
);

INSERT INTO TAB_COURS VALUES ( 2, 'BDO', 45,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='d12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='X12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='F12434')
    )
);

INSERT INTO TAB_COURS VALUES ( 3, 'BDR', 45,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='F12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='X12434')
    )
);

INSERT INTO TAB_COURS VALUES ( 5, 'MATH', 75,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='X12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='g12434')
    )
);

INSERT INTO TAB_COURS (NUMCOURS, INTIT, VOLH) VALUES (4, 'RES', 50);

INSERT INTO TAB_COURS VALUES ( 6, 'COM', 55,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='AQ12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='AQQ12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='BQ12434')
    )
);

INSERT INTO TAB_COURS VALUES ( 7, 'WEB', 60,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='CQQ12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='F12434')
    )
);

INSERT INTO TAB_COURS VALUES ( 8, 'TEL', 40,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='CQQ12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='F12434')
    )
);

INSERT INTO TAB_COURS VALUES ( 9, 'ALGO', 90,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='T12434')
    )
);

INSERT INTO TAB_COURS VALUES ( 10, 'GL', 20,
    T_LISTE_ENS( 
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='N12434'),
	(SELECT REF(D) FROM TAB_PERS D WHERE D.CIN='M12434')
    )
);


--validation
commit;

------------------------------------------------------------------------------
----			FIN DE LA TABLE TAB_COURS
------------------------------------------------------------------------------

