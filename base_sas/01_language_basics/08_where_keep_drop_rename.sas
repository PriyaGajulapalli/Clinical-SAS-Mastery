/*-----------------------------------------------------
Clinical SAS Mastery
Lesson 08:wHERE ,KEEP ,DROP AND RENAME LESSON
Data:Synthetic patient information only
-----------------------------------------------------*/

/*------------------------------------------
            GUIDED EXAMPLE
-------------------------------------------*/

data work.student_scores;
 input student_id score subject $;
 datalines;
 301 75 SAS
 302 60 SQL
 303 48 Python
 304 90 SAS
 305 55 SQL
 ;
 run;
 
 data work.passed_students;
 set work.student_scores;
 
 where score>=60;
 keep student_id score subject;
 rename score= exam_score;
 run;
 
 
 
 
 /*------------------------------------------
            INDEPENDENT EXERCISE
-------------------------------------------*/

data work.student_scores2;
length subject $9;
input student_id score subject $;
datalines;
401 82 Biology
402 50 Chemistry
403 67 Physics
404 45 Biology
405 91 Chemistry
;
run;


data work.high_score_students;
set work.student_scores2;

where score>50;
keep student_id subject score;
rename subject = course
       score = final_score;
       run;