/*-----------------------------------------------------
Clinical SAS Mastery
Lesson 1:SAS comments and statements
Data:Synthetic patient information only
-----------------------------------------------------*/

/*-----------------------------------------------
Guided Practice:Visit Dataset
-----------------------------------------------*/

/* create a dataset named patients*/
data patients; 

        
/*Read Subject ID,Age and treatment group*/
input subject_id age treatment_group $;    
datalines;
101 34 placebo
102 41 active
103 29 active
104 56 placebo
;
run;

/* Display the patients dataset*/
proc print data=patients;
run;






/*-----------------------------------------------
Independent Exercise:Visit Dataset
-----------------------------------------------*/

/*crete a dataset named visits*/
data visits;

/* read subject_id visit_number visit_status variables */
input subject_id visit_number visit_status $;
datalines;
201 1 complete
202 1 complete
203 1 missed
204 1 complete
;
run;

/*Display the visits Dataset*/
proc print data=visits;
run;


