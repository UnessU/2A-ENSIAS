Create Table APPAREIL(No_Appareil number(7) PRIMARY KEY, Designation varchar(30), Designation number(7,2), caracteristiques_techniques varchar(50)); 

connect Inwis/azerty@ensias2;

Create Table Copie As Select * from Appareil@dbl_Ensias1;


Drop trigger Insertap;
CREATE TRIGGER Insertap
After INSERT ON Appareil
FOR EACH ROW
BEGIN
INSERT INTO Copie@dbl_Ensias2  VALUES(:NEW.No_Appareil, :NEW.Designation, :NEW.Prix, :NEW.caracteristiques_techniques) ;
END;
/


Drop trigger delap;
CREATE TRIGGER delap
After Delete ON Appareil
FOR EACH ROW
BEGIN
DELETE FROM copie@dbl_Ensias2 WHERE No_Appareil = :OLD.No_Appareil;
END;
/


Drop trigger updap;
CREATE TRIGGER updap
After update ON Appareil
FOR EACH ROW
BEGIN
Update copie@dbl_Ensias2
set No_APPAREIL = :NEW.No_Appareil, Designation = :NEW.Designation,Prix = :NEW.Prix,caracteristiques_techniques = :NEW.caracteristiques_techniques
WHERE No_APPAREIL = :OLD.No_Appareil;
END;
/





CREATE SNAPSHOT LOG ON Appareil;


CREATE SNAPSHOT Image_appareil
REFRESH FAST
START WITH SYSDATE
NEXT SYSDATE + 30
AS Select * from Appareil@dbl_Ensias1;
