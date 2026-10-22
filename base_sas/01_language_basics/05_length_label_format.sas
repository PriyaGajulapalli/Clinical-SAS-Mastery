/*---------------------------------------------------------
Program: 05_length_label_format.sas
Purpose: Practice LENGTH,LABEL, and FORMAT statements
Author: Priya G
Date: Oct 2026
---------------------------------------------------------*/

/* ---------------- GUIDED EXAMPLE ----------------------*/

DATA participants;

length participant_id $6 
       participant_name $20
       age 8
       weight_kg 8
       visit_date 8;
       
input participant_id $ participant_name $ age weight_kg visit_date :date9.;

label participant_id = 'Participant ID'
    participant_name = 'Participant Name'
                 age = 'Age in Years'
          weight_kg  = 'Weight in Kilograms'
          visit_date = 'Visit Date';
 
 
 format participant_name $upcase20.
        age 3.
        weight_kg 6.1
        visit_date date9.;
        
        
 datalines;
 P001 anu 24 52.5 15OCT2026
 P002 ravi 31 68.75 20OCT2026
 P003 sita 28 60.0 25OCT2026
 ;
 run;

 proc print data=participants label;
 run;
 
 /* ---------------- INDEPENDENT EXERCISE ----------------------*/


data books;
length book_id $6
      book_title $25
      quantity 8
      unit_price 8
      stock_date 8;
      
input book_id $ book_title $ quantity unit_price stock_date :date9.;

label book_id = 'Book ID'
     book_title = 'Book Title'
     quantity = 'Quantity Available'
     unit_price = 'Unit Price'
     stock_date ='Stock Date';
  
  
  format  book_title $upcase25.
          quantity 3.
          unit_price comma8.2
          stock_date date9.;
          
          
          
    datalines;
  B001 SASBasics 12 450.50 01OCT2026
  B002 SQLGuide 8 725.00 05OCT2026
  b003 ClinicalSAS 15 1250.75 10OCT2026
  ;
   run;
   
   
   
          
 proc print data=books label;
 run;
        
  
 
 
 