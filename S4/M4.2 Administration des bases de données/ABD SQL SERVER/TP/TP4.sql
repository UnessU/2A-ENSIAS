USE [Evaluation]
GO

insert into Etudiants(Code, Nom, Prenom, Classe) values (14, 'Lh', 'SalahEddine', '2GL-GL3' );

insert into Examen (Code_Etud, Code_Mat, Date_Ex, Note, NoteAbs) values (14, 'M2.1', '2018-05-03', 15.00, 16.23 );
insert into Examen (Code_Etud, Code_Mat, Date_Ex, Note, NoteAbs) values (14, 'M2.2', '2018-05-03', 17.00, 18.23 );

insert into Matieres(Code, Nom, Coef) values ( 'M2.4', 'JAVA/JEE', 4);
insert into Examen (Code_Etud, Code_Mat, Date_Ex, Note, NoteAbs) values (14, 'M2.3', '2018-05-03', 14.00, 18.23 );
insert into Examen (Code_Etud, Code_Mat, Date_Ex, Note, NoteAbs) values (14, 'M2.4', '2018-05-03', 17.00, 18.23 );																	    (14, 'M2.4', '2018-05-03', 11.00, 14.23 );


BACKUP DATABASE Evaluation TO U_Evaluation WITH DIFFERENTIAL;

delete from Examen;
select * from Examen;

USE Evaluation1
go
select * from Examen;


RESTORE DATABASE Evaluation2 FROM U_Evaluation
WITH 
move 'F1' to 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\F1_1.ndf',
move 'F2' to 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\F1_2.ndf',
move 'F3' to 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\F1_3.ndf',
move 'F4' to 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\F1_4.ndf',
move 'Evaluation_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Evaluation2_log.ldf',
move 'Evaluation' to 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Evaluation2.mdf',
RECOVERY


use Evaluation2
go

select * from Examen;