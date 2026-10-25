/*------------------------------------------
Clinical SAS Mastery;
lesson 07:IF-THEN and IF-THEN-ELSE
Data: SASHELP sample datasets;
-------------------------------------------*/





/*------------------------------------------
            GUIDED EXAMPLE
-------------------------------------------*/

data work.class_age_group;
set sashelp.class;

length age_group $7;

if missing(age) then age_group = 'Missing';
else if age>= 13 then age_group ='Teen';
else age_group ='Child';
run;

proc contents data=work.class_age_group;
run;
proc print data=work.class_age_group;
run;


/*------------------------------------------
            INDEPENDENT EXERCISE
-------------------------------------------*/
data work.car_price_group;
set sashelp.cars;
length price_group $8;

if missing(MSRP) then price_group ='Missing';
else if MSRP >= 30000 then price_group = 'Premium';
else price_group = 'Standard';
run;

proc contents data= work.car_price_group;
run;

proc print data=work.car_price_group;
var make model msrp price_group;
run;

proc freq data=work.car_price_group;
tables price_group/missing;
run;

