------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
----		TAB_ADRS 
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--creation de la table objet des adresses
create table tab_adrs of t_adr(
	constraint pk_tab_adr primary key (rue, mais, ville),
	ville not null
);

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

--validation
commit;


------------------------------------------------------------------------------
----			FIN TAB_ADRS
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
