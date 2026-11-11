/*------------------------------------------
Clinical SAS Mastery;
Lesson 09: Missing Value Handling
Data: SASHELP sample datasets;
-------------------------------------------*/


/*------------------------------------------
            GUIDED EXAMPLE
-------------------------------------------*/
data work.class_missing;
set sashelp.class;

if name = "Alice" then Height = .;
if name = "Carol" then weight = .;
if name ="Henry" then age = .;

if missing(age) then age_status ="Missing";
else age_status ="Present";

if missing(height) then height_status ="Missing";
else height_status ="Present";

if missing(weight) then weight_status ="Missing";
else weight_status = "Present";


numeric_missing_count = nmiss(age,height,weight);

label age_status ="Age Status"
      height_status = "Height Status"
      weight_status = "Weight Status"
      numeric_missing_count = "Number of Numeric Missing Values";
      format age_status height_status Weight_status $8.;
      run;
      
proc print data=work.class_missing;
var name age height weight age_status height_status weight_status numeric_missing_count;
run;

proc contents data=work.class_missing;
run;



      
      
      
      /*------------------------------------------
            INDEPENDENT EXERCISE
-------------------------------------------*/


data patient_data;
input patient_id $ age height weight ;


if missing(age) then age_status ="Missing";
else age_status = "Present";

if missing(height) then height_status ="Missing";
else height_status ="Present";

if missing(weight) then weight_status ="Missing";
else weight_status ="Present";

format age_status height_status weight_status $8.;

label age_status ="Age Status"
      height_status ="Height Status"
      weight_status = "Weight Status";
      
datalines;

P001 25 165 60
P002 .  170 72
P003 34 .   68
P004 29 158 .
P005 .  .   80
;
      
      run;
      
      proc print data=patient_data label;
      var  patient_id age height weight age_status height_status weight_status;
    run;
