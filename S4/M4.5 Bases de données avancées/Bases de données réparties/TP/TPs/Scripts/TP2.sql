connect Inwis/azerty@ensias2;

COPY FROM  Inwis/azerty@ensias1 TO Inwis/azerty@ensias2 REPLACE Type_Compte_2(no,libelle_compte,description) using select no,libelle_compte, description from type_compte;

COPY FROM Inwis/azerty@ensias1 TO Inwis/azerty@ensias2 REPLACE Type_Operation_2(no, libelle_operation, decription) using select no, libelle_operation, description from type_operation;

Drop Table Type_Compte;

Drop Table Type_Operation;



Create Database Link dbl_Ensias1 connect to Inwis identified by azerty using 'ensias1';

Create Database Link dbl_Ensias2 connect to Inwis identified by azerty using 'ensias2';

SELECT * FROM client_1@dbl_Ensias1;

SELECT * FROM client_2@dbl_Ensias2;




ensias1

Create or replace Trigger trig1
Before Delete or update of No On Agence
For each row
Declare
x number:=0;
Begin
Select count(*) into x from Compte_2@dbl_Ensias2
where Agence_No=:old.No;
if x>0 then
RAISE_APPLICATION_ERROR(-20175,'Erreur agence utilisée dans ensias 2');
END IF ;
END;
/

ensias2

Create or replace Trigger trig2
Before Insert or update of Agence_No On Compte_2
For each row
Declare
x number:=0;
Begin
Select count(*) into x from Agence@dbl_Ensias1
where No=:new.Agence_NO;
if x=0 then
RAISE_APPLICATION_ERROR(-20175,'agence inconnue');
END IF; 
END;
/






