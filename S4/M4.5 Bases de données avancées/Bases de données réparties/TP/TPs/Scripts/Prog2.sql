declare 

 cursor c_employe is
   select no, dt_entree, salaire  from e_employe;
   v_no		e_employe.no%type;
   v_dt_entree	date;
   v_salaire	e_employe.salaire%type;

begin

open c_employe;
fetch c_employe INTO v_no, v_dt_entree, v_salaire;

while(c_employe%FOUND) LOOP
    if TO_CHAR(v_dt_entree, 'yyyy')='1995' then
       update e_employe
       set salaire=salaire*1.50  
       where no=v_no ;
 
       insert into e_augmentation 
       values(seq.nextval,0.5*values, sysdate, v_no);
    
elsif  TO_CHAR(v_dt_entree, 'yyyy')='1996' then
        update e_employe
       set salaire=salaire*1.25  
       where no=v_no ;
 
       insert into e_augmentation 
       values(seq.nextval,0.25*values, sysdate, v_no);

     elsif  TO_CHAR(v_dt_entree, 'yyyy')='1997' then
       update e_employe
       set salaire=salaire*1.1  
       where no=v_no ;
 
       insert into e_augmentation 
       values(seq.nextval,0.1*values, sysdate, v_no);
     end if ;
 
 FETCH c_emp INTO v_no, v_dt_entree, v_salaire;

end loop;
close c_emp;
commit;
end ;
/
