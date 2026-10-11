/*-----------------------------------------------
Clinical SAS Mastery
lesson 3:DATALINES and INPUT
Data:Synthetic Data only
-----------------------------------------------*/

/*------------------------------------------------
      Guided Example: Subject-Level Data
 -----------------------------------------------*/
/*create the dataset named subjects*/

data subjects;

/* input reads the raw data*/
input subject_no subject_id $ sex $ age;

/*datalines provide raw data*/
datalines;
1001 SUBJ001 M 34
1002 SUBJ002 F 29
1003 SUBJ003 M 41
1004 SUBJ004 F 37
;
run;

/* display the subjects dataset*/
proc print data=subjects;
run;


/*------------------------------------------------------------
      Independent Exercise: Laboratory Results details
 -------------------------------------------------------------*/


/*create a dataset named lab_reults*/
data lab_results;

/*input reads the values of the raw data*/
input subject_id $  visit $ test_name $ result;

/*datalines provide raw data*/
datalines;
SUBJ001 BASELINE HGB 13.2
SUBJ001 WEEK4 HGB 13.5
SUBJ002 BASELINE HGB 12.8
SUBJ002 WEEK4 HGB 13.1
SUBJ003 BASELINE HGB 14.0
;
run;

/* display the lab_results dataset*/
proc print data=lab_results;
run;