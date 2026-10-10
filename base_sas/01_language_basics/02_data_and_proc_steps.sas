/*------------------------------------------
Clinical SAS Mastery;
lesson 2:DATA step and PROC step;
Data: SASHELP sample datasets;
-------------------------------------------*/


*create a dataset named student_copy;

data student_copy;
set sashelp.class;
run;


*dispaly the student_copy dataset;
proc print data=student_copy;
run;




/*------------------------------------------
       Independent exercise
--------------------------------------------*/

*create dataset named vehicle_review;

data vehicle_review;
set sashelp.cars;
run;


*display the vehicle_review dataset;

proc print data=vehicle_review;
run;
