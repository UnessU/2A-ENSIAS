use Evaluation;
go

--A3
select Examen.Code_Etud as code, SUM(Examen.Note) as somme_note, SUM(Examen.Note * Matieres.Coef) as somme_note_coef
from Matieres, Examen
where 
Examen.Code_Mat = Matieres.Code
group by Examen.Code_Etud;


--B4 create view V1 as select * from Examen where Note < 12;
select Etudiants.Nom as nom, V1.Note as note
from Etudiants, V1
where
Etudiants.Code = V1.Code_Etud
and
Etudiants.Nom like 'B%'
order by Etudiants.Nom ASC, V1.Note DESC;

insert into V1(Code_Etud, Code_Mat, Date_Ex, Note) values (12, 'M2.1', '2018-04-30', 10.32 );

--select * from V1;
Alter View v1 as Select * From Examen Where Note < 12 With Check Option;

insert into V1(Code_Etud, Code_Mat, Date_Ex, Note) values (12, 'M2.1', '2018-04-30', 15.32 );

create view V2 as
select Etudiants.Code as code, Etudiants.Nom as nom, Matieres.Nom as matiere, Matieres.Coef as coef, Examen.Date_Ex as dateEx, Examen.Note as note
from Etudiants, Matieres, Examen
where 
Examen.Code_Etud = Etudiants.Code
and
Examen.Code_Mat = Matieres.Code;

sp_helptext V2;

alter view V2 with Encryption as
select Etudiants.Code as code, Etudiants.Nom as nom, Matieres.Nom as matiere, Matieres.Coef as coef, Examen.Date_Ex as dateEx, Examen.Note as note
from Etudiants, Matieres, Examen
where 
Examen.Code_Etud = Etudiants.Code
and
Examen.Code_Mat = Matieres.Code;

create procedure PS1 AS
BEGIN
set nocount on;
select Examen.Code_Etud as code_etud, count(Examen.Code) as nbr_exams, MIN(Examen.Note) note_min, MAX(Examen.Note) as note_max, AVG(Examen.Note) as moyenne
from Examen
group by Examen.Code_Etud;
end
go

exec PS1;

alter procedure PS2 @notePar decimal(4,2), @codePar int AS
BEGIN
set nocount on;
select Examen.Code_Etud as code_etud, count(Examen.Code) as nbr_exams, MIN(Examen.Note) note_min, MAX(Examen.Note) as note_max, AVG(Examen.Note) as moyenne
from Examen
where Examen.Code_Etud = @codePar
group by Examen.Code_Etud
Having min(Note) >= @notePar;
end
go

exec PS2 1, 9;

update Examen set Examen.NoteAbs = Examen.Note;

select * from Examen;

--D15
CREATE TRIGGER T1
ON Examen AFTER INSERT
AS DECLARE
@CodeEx int, @NoteEx decimal(4,2) BEGIN SET NOCOUNT ON;
select @CodeEx= Code from inserted; select @NoteEx= Note from inserted;
update Examen set Examen.NoteAbs=@NoteEx where Code=@CodeEx;
END
GO

--D16

CREATE TRIGGER T2
ON Absence AFTER INSERT
AS DECLARE
@CodeEtd int, @CodeMat char(5) BEGIN
SET NOCOUNT ON;
select @CodeEtd= Code_Etud from inserted;
select @CodeMat= Code_Mat from inserted;
update Examen set Examen.NoteAbs=Examen.NoteAbs*0.9;
end
go















