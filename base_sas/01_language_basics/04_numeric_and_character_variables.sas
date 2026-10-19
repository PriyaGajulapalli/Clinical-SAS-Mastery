/*-----------------------------------------------
*Program: 04_numeric_and_character_variables.sas
*Purpose:Practice numeric and character variables using the INPUT statement
*Author: Priya G
*Date: October 2026
------------------------------------------------*/

/*------------------------------------------------
              GUIDED EXAMPLE
------------------------------------------------*/

data guided_subjects;

/* Read character and numeric varaibles */

input subject_id $ sex $ age weight_kg;

/* create a derived numeric varaible */

age_next_year = age + 1;

datalines;

SUBJ001 M 34 68.5
SIBJ002 F 29 59.2
SUBJ003 M 41 82.0
;
run;

/* Display the guided dataset */
proc print data=guided_subjects;
run;


/*----------------------------------------------------
            INDEPENDENT EXERCISE
----------------------------------------------------*/

data independent_visits;

/* Read character and numeric variables */
input patient_id $ visit_label $ visit_num systolic_bp;

/* create a derived numeric varaible */

next_visit_num = visit_num + 1;


datalines;
PAT001 SCREENING 1 128
PAT002 BASELINE 2 135
PAT003 WEEK4 3 122
;
run;


/* Display the independent_visits*/

proc print data=independent_visits;
run;





