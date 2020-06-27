COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias2 APPEND Client_Rabat (no, nom, prenom, adresse) USING Select no, nom, prenom, adresse FROM Client Where Ville='Rabat' ;

COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias1 APPEND Client_Casablanca (no, nom, prenom, adresse) USING Select no, nom, prenom, adresse FROM Client Where Ville='Casablanca' ;


COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias2 REPLACE Compte_Rabat (no, type_compte_no, dateouverture, decouvert_autorise, solde, client_no, agence_no) USING select no, type_compte_no, dateouverture, decouvert_autorise, solde, client_no, agence_no from compte where client_no in ( select no from client where ville='Rabat');


COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias1 REPLACE Compte_Casablanca (no, type_compte_no, dateouverture, decouvert_autorise, solde, client_no, agence_no) USING select no, type_compte_no, dateouverture, decouvert_autorise, solde, client_no, agence_no from compte where client_no in ( select no from client where ville='Casablanca');


COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias2 REPLACE Operation_Rabat (no, type_operation_no, compte_no) using select no,type_operation_no,compte_no from operation where compte_no in (select no from compte where client_no in (select no from client where ville = 'Rabat'));

COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias1 REPLACE Operation_Casablanca (no, type_operation_no, compte_no) using select no,type_operation_no,compte_no from operation where compte_no in (select no from compte where client_no in (select no from client where ville = 'Casablanca'));

COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias2 REPLACE Type_Compte_Rabat(no,libelle_compte,description) using select no,libelle_compte, description from type_compte;


COPY FROM haddouchi/roudani8@ensias1 TO haddouchi/roudani8@ensias2 REPLACE Type_Operation_Rabat(no, libelle_operation, decription) using select no, libelle_operation, description from type_operation;

create database link dbl_ensias1 connect to bouchra identified by bouchra using 'ensias1';


CREATE OR REPLACE TRIGGER tensias1
  BEFORE
    UPDATE of no OR
    DELETE 
  ON agence
FOR EACH ROW 
DECLARE
x number:=0;
BEGIN
  select count(*) into x from compte_2@db1_ensias2 where agence_no=:OLD.no;
  if x>0 then 
  RAISE_APPLICATION_ERROR(-20175,'erreur: agence utilisée dans ensias2');
  END IF;	
END;
/

CREATE OR REPLACE TRIGGER tensias2
  BEFORE
    UPDATE of agence_no OR
    insert
  ON compte_2
FOR EACH ROW 
DECLARE
x number:=0;
BEGIN
  select count(*) into x from agence@db1_ensias1 where no=:NEW.agence_no;
  if x=0 then 
  RAISE_APPLICATION_ERROR(-20176,'erreur: aucune agence trouvée');
  END IF;	
END;
/

CREATE VIEW Client (no,Nom,Prenom,Adresse,Ville) AS
SELECT no,Nom,Prenom,Adresse,'Casablanca' FROM Client_1
UNION
SELECT no,Nom,Prenom,Adresse,'Rabat' FROM Client_2@db1_ensias2;

CREATE VIEW Client (no,Nom,Prenom,Adresse,Ville) AS
SELECT no,Nom,Prenom,Adresse,'Casablanca' FROM Client_1@db1_ensias1
UNION
SELECT no,Nom,Prenom,Adresse,'Rabat' FROM Client_2;


CREATE VIEW compte (No, Type_Compte_No, DateOuverture, Decouvert_autorise, Solde, Client_No, Agence_No) AS
SELECT No, Type_Compte_No, DateOuverture, Decouvert_autorise, Solde, Client_No, Agence_No FROM compte_1
UNION
SELECT No, Type_Compte_No, DateOuverture, Decouvert_autorise, Solde, Client_No, Agence_No FROM Compte_2@db1_ensias2;





CREATE VIEW operation (No, Type_Operation_No, Compte_No) AS
SELECT No, Type_Operation_No, Compte_No FROM operation_1
UNION
SELECT No, Type_Operation_No, Compte_No FROM operation_2@db1_ensias2;



CREATE VIEW operation (No, Type_Operation_No, Compte_No) AS
SELECT No, Type_Operation_No, Compte_No FROM operation_1@db1_ensias1
UNION
SELECT No, Type_Operation_No, Compte_No FROM operation_2;
