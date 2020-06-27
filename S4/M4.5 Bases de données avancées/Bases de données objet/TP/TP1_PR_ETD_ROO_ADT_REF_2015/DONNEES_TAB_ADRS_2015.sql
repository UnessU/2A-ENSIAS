set echo on
--test du schéma 
desc tab_adrs;

--insertion dans la table objets des adresses
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
insert into tab_adrs values ('rueQQ', 55, 'ville55', 'maroc');
insert into tab_adrs values ('rueWW', 66, 'ville66', 'maroc');


--validation
commit;

