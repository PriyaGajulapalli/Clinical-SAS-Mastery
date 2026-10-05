/*----------------------------------------------------------
Lesson 02: Create a Simple SAS Dataset
Folder: base_sas/01_language_basics
Data: Synthetic data only
----------------------------------------------------------*/

data work.product_sales;
input product_id quantity unit_price;
datalines;
101 5 250
102 2 480
103 10 75
104 1 1250
105 7 150
;
run;

proc print data=work.product_sales noobs;
title "Synthetic Product Sales Dataset";
run;