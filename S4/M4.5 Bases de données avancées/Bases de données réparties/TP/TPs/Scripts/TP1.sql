create table client (no number(7), nom varchar2(40), prenom varchar2(40), Adresse varchar2(40), Ville varchar2(50),
Constraint client_pk primary key (no));

create table agence (no number(7), nom varchar2(40), Adresse varchar2(40), Ville varchar2(50),
Constraint Agence_pk primary key (no));

create table type_compte (no number(7), libelle_compte varchar2(40), description varchar2(100),
Constraint type_compte_pk primary key (no));

create table compte (no number(7), type_compte_no number(7), dateOuverture date, decouvert_autorise number(7,2), 
solde number(11,2), client_no number(7), agence_no number(7),
Constraint compte_pk primary key (no), constraint type_compte_fk foreign key (type_compte_no) references type_compte(no), 
constraint client_fk foreign key (client_no) references client(no), 
constraint agence_fk foreign key (agence_no) references agence(no));


create table type_operation (no number(7), libelle_operation varchar2(40), description varchar2(100),
Constraint type_operation_pk primary key (no));


create table operation (no number(7), type_operation_no number(7), compte_no number(7),
Constraint operation_pk primary key (no), 
constraint type_opration_fk foreign key (type_operation_no) references type_operation(no));

create sequence seq_client order;
create sequence seq_agence order;
create sequence seq_compte order;
create sequence seq_type_compte order;
create sequence seq_operation order;
create sequence seq_type_operation order;


insert into client
values (seq_client.nextval, 'Naciri','Ahmed', 'Résidence Nassim N12', 'Casablanca');

insert into client
values (seq_client.nextval, 'Filali','Rachid', 'Rue 4 N52', 'Casablanca');


insert into client
values (seq_client.nextval, 'Alaoui','Soufiane', 'Agdal N42', 'Rabat');

insert into client
values (seq_client.nextval, 'Drissi','Zouhair', 'Youssofia N123', 'Rabat');



insert into client
values (seq_client.nextval, 'Rachidi','Badr', 'Souissi N45', 'Rabat');


insert into client
values (seq_client.nextval, 'Tlamssani','Youness', 'Dior ejjamaa N17', 'Rabat');

insert into client
values (seq_client.nextval, 'Doukkali','Brahim', 'Oasis N5', 'Casablanca');


insert into agence
values (seq_agence.nextval, 'Agence assaada', 'Maarif N5', 'Casablanca');

insert into agence
values (seq_agence.nextval, 'Grande poste','Souissi N156', 'Rabat');



insert into type_compte
values (seq_type_compte.nextval, 'Epargne','Compte epargne');
insert into type_compte
values (seq_type_compte.nextval, 'Courant','Compte courant');


insert into compte
values (seq_compte.nextval, 1,'01/01/1997',2000, 12000, 1, 1);

insert into compte
values (seq_compte.nextval, 2,'11/01/1997',3000, 120000, 2, 1);

insert into compte
values (seq_compte.nextval, 2,'11/12/1997',3000, 150000, 3, 2);

insert into compte
values (seq_compte.nextval, 2,'11/01/1998',3000, 17000, 4, 2);

insert into compte
values (seq_compte.nextval, 2,'11/11/1998',3000, 120000, 5, 2);

insert into compte
values (seq_compte.nextval, 1,'11/12/1998',3500, 1800000, 6, 2);

insert into compte
values (seq_compte.nextval, 2,'11/12/1999',3000, 150000, 6, 2);

insert into compte
values (seq_compte.nextval, 1,'11/01/2000',3000, 120000, 7, 1);


insert into type_operation
values (seq_type_operation.nextval, 'virement','virement');
insert into type_operation
values (seq_type_operation.nextval, 'retrait','retrait');


insert into operation
values (seq_operation.nextval,1,1);
insert into operation
values (seq_operation.nextval,1,2);
insert into operation
values (seq_operation.nextval,2,1);
insert into operation
values (seq_operation.nextval,2,3);
insert into operation
values (seq_operation.nextval,2,4);
insert into operation
values (seq_operation.nextval,1,5);
insert into operation
values (seq_operation.nextval,2,6);
insert into operation
values (seq_operation.nextval,2,7);

commit;












