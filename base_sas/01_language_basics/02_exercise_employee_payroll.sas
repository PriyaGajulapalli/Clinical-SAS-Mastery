/*----------------------------------------------------------
Lesson 02: Independent Exercise Employee Payroll
Folder: base_sas/01_language_basics
Data: Synthetic data only
----------------------------------------------------------*/
data work.employee_payroll;
input employee_id hours_worked hourly_rate;
datalines;
201 40 25
202 35 30
203 45 22
204 38 28
205 42 26
;
run;

proc print data=work.employee_payroll noobs;
title "Employee Payroll";
run;
