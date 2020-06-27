BEGIN
  FOR i IN 1..10
  LOOP
     INSERT INTO system.customers(cust_code,name) 
     VALUES('C01','JOCKSPORTS');                

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B12','STADIUM SPORTS');            

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B02','HOOPS');                     

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B03','REBOUND SPORTS');            

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B04','THE POWER FORWARD');         

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B05','POINT GUARD');               

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B06','THE COLISEUM');              

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B07','FAST BREAK');                

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B08','AL AND BOB''S SPORTS');       

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B11','AT BAT');                    

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B12','ALL SPORT');                 

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B13','GOOD SPORT');                

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B14','AL''S PRO SHOP');             

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B15','BOB''S FAMILY SPORTS');       

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B16','THE ALL AMERICAN');          

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B17','HIT, THROW, AND RUN');       

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B18','THE OUTFIELD');              

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B21','WHEELS AND DEALS');          

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B22','JUST BIKES');                

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B23','VELO SPORTS');               

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B24','JOE''S BIKE SHOP');           

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B25','BOB''S SWIM, CYCLE, AND RUN');

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B26','CENTURY SHOP');              

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B27','THE TOUR');                  

     INSERT INTO system.customers(cust_code,name) 
     VALUES('B28','FITNESS FIRST');             
  END LOOP;
END;
/



UPDATE system.customers SET region='West' WHERE cust_code='C01';                       
UPDATE system.customers SET region='East' WHERE cust_code='B12';                       
UPDATE system.customers SET region='East' WHERE cust_code='B02';                       
UPDATE system.customers SET region='East' WHERE cust_code='B03';                       
UPDATE system.customers SET region='East' WHERE cust_code='B04';                       
UPDATE system.customers SET region='West' WHERE cust_code='B05';                       
UPDATE system.customers SET region='North' WHERE cust_code='B06';                      
UPDATE system.customers SET region='South' WHERE cust_code='B07';                      
UPDATE system.customers SET region='North' WHERE cust_code='B08';                      
UPDATE system.customers SET region='North' WHERE cust_code='B11';                      
UPDATE system.customers SET region='West' WHERE cust_code='B12';                       
UPDATE system.customers SET region='East' WHERE cust_code='B13';                       
UPDATE system.customers SET region='North' WHERE cust_code='B14';                      
UPDATE system.customers SET region='West' WHERE cust_code='B15';                       
UPDATE system.customers SET region='North' WHERE cust_code='B16';                      
UPDATE system.customers SET region='East' WHERE cust_code='B17';                       
UPDATE system.customers SET region='East' WHERE cust_code='B18';                       
UPDATE system.customers SET region='East' WHERE cust_code='B21';                       
UPDATE system.customers SET region='East' WHERE cust_code='B22';                       
UPDATE system.customers SET region='North' WHERE cust_code='B23';                      
UPDATE system.customers SET region='South' WHERE cust_code='B24';                      
UPDATE system.customers SET region='South' WHERE cust_code='B25';                      
UPDATE system.customers SET region='South' WHERE cust_code='B26';                      
UPDATE system.customers SET region='North' WHERE cust_code='B27';                      
UPDATE system.customers SET region='North' WHERE cust_code='B28';                      
