create database link db1.ensias3 connect to Inwis identified by azerty using 'ensias1';
create database link db1.ensias4 connect to Inwis identified by azerty using 'ensias2';



Create view client (No,Nom,prenom,Ville) as select No,Nom,Prenom,'Casablanca' 
from Client_1@db1.ensias3 Union select No,Nom,Prenom,'Rabat' from Client_2@db1.ensias4;


CREATE TRIGGER InseretClient
INSTEAD OF INSERT ON Client
FOR EACH ROW
BEGIN
IF :NEW.Ville='Rabat' THEN
INSERT INTO Client_2@db1.ensias4 VALUES(:NEW.No, :NEW.Nom, :NEW.Prenom) ;
ELSIF :NEW.Ville='Casablanca' THEN
INSERT INTO Client_1@db1.ensias3 VALUES(:NEW.No, :NEW.Nom, :NEW.Prenom) ;
ELSE RAISE_APPLICATION_ERROR (-20455,'Entrer Rabat ou Casablanca');
END IF;
END;
/

Create or replace Trigger trigclt 
Instead of Delete or update On Client
For each row
Declare
x number:=0;
Begin
IF :NEW.Ville='Rabat' THEN
Select count(*) into x from client_2@db1_ensias4
where :New.No=:old.No;
if x>0 then
RAISE_APPLICATION_ERROR(-20175,'Erreur client utilisée dans ensias 2');
END IF ;
ELSIF :NEW.Ville='Casablanca' THEN
Select count(*) into x from client_1@db1_ensias3
where :NEW.No=:old.No;
if x>0 then
RAISE_APPLICATION_ERROR(-20175,'Erreur client utilisée dans ensias 1');
END IF ;
END IF;
END;
/
