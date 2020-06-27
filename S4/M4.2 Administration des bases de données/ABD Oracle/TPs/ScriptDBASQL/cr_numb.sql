CREATE TABLE system.numbers(
no NUMBER,
odd_even varchar2(1))
TABLESPACE data01
/

BEGIN
  FOR i IN 1..10000
  LOOP
    IF mod(i,2)=1
    THEN
      INSERT INTO system.numbers
      VALUES(i,'O');
    ELSE
      INSERT INTO system.numbers
      VALUES(i,'E');
    END IF;
    IF mod(i,500)=0
    THEN
      COMMIT;
    END IF;
  END LOOP;
END;
/
