set echo on

--INSERTION DANS LA TABLE TAB_PERS

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

