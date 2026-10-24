/*---------------------------------------------------------
Program: 06_libraries_and_work_library.sas
Folder path:base_sas/01_language_basics/06_libraries_and_work_library.sas
Author: Priya G
Date: Oct 2026
---------------------------------------------------------*/

/*---------------- GUIDED EXAMPLE ----------------------*/

data work.visits;
length subjid $4 visit_date $10;
input subjid $ visit_num visit_date $;
datalines;
S001 1 2026-10-01
S002 2 2026-10-15
S002 1 2026-10-03
;
run;

proc contents data=work.visits;
run;

proc print data=work.visits;
run;



/*---------------- INDEPENDENT EXERCISE ----------------------*/


data work.lab_results;

input subjid $ testcd $ result visit_num;

datalines;

S001 HGB 13.5 1
S001 ALT 22.0 1
S002 HGB 11.8 1
S002 ALT 30.5 1
;
run;

proc contents data=work.lab_results;
run;

proc print data=work.lab_results;
run;




