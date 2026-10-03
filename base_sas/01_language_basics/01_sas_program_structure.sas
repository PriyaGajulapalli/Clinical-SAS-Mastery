/*----------------------------------------------------------
Program: 01_sas_program_structure.sas
Purpose: Create and print a simple synthetic SAS dataset
Folder: base_sas/01_language_basics
Data: Synthetic data only
----------------------------------------------------------*/

/* DATA step: create a temporary dataset in the WORK library */

data work.first_data;
input id name $ score;
datalines;
1 Alpha 81
2 Beta 92
3 Gamma 78
;
run;

/* PROC Step:display the dataset */

proc print data=work.first_data noobs;
run;
