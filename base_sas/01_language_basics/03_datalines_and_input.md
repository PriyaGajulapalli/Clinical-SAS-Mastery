# Lesson 3: DATALINES and INPUT

## Learning Objective

In this lesson, I learned how to create SAS datasets from raw data using the `DATALINES` statement and the `INPUT` statement.

I also learned how to:

- Read raw data values in SAS
- Define numeric and character variables
- Use the dollar sign (`$`) for character variables
- Create a subject-level dataset
- Create a laboratory-results dataset
- Display datasets using `PROC PRINT`
- Predict the number of observations and variables
- Compare predicted output with actual output
- Check the SAS Log and Output window

---

## 1. The INPUT Statement

The `INPUT` statement tells SAS how to read values from raw data.

It defines:

- The variable names
- The order in which the values are read
- Whether a variable is numeric or character

### General Syntax

```sas
input variable1 variable2 $ variable3;

Variables without a dollar sign are numeric by default.

Variables with a dollar sign are character variables.

Example
input subject_no subject_id $ sex $ age;

This statement tells SAS to read:

Variable

Type

Reason

subject_no

Numeric

It contains numbers

subject_id

Character

It contains values such as SUBJ001

sex

Character

It contains values such as M and F

age

Numeric

It contains numbers

2. The DATALINES Statement
The DATALINES statement allows raw data to be entered directly inside a SAS program.

General Structure
data dataset_name;
    input variable_list;

    datalines;
    raw data values
    ;
run;

The semicolon after the last raw-data line tells SAS that the DATALINES section has ended.

Each complete raw-data row normally becomes one observation.

3. Guided Example: Subject-Level Dataset
The following program creates a dataset named subjects.

data subjects;

    input subject_no subject_id $ sex $ age;

    datalines;
1001 SUBJ001 M 34
1002 SUBJ002 F 29
1003 SUBJ003 M 41
1004 SUBJ004 F 37
;
run;

proc print data=subjects;
run;

4. Guided Example Explanation
data subjects;

This starts the DATA step and creates a SAS dataset named subjects.

input subject_no subject_id $ sex $ age;

This tells SAS how to read the raw data.

subject_no is numeric.
subject_id $ is character.
sex $ is character.
age is numeric.
datalines;

This tells SAS that raw data will be entered directly in the program.

1001 SUBJ001 M 34
1002 SUBJ002 F 29
1003 SUBJ003 M 41
1004 SUBJ004 F 37

These are the four raw-data records.

;

This marks the end of the raw data.

run;

This completes the DATA step.

proc print data=subjects;
run;

This displays the subjects dataset in the Output window.

5. Guided Example Output Prediction
Before running the code, I predicted that the subjects dataset would contain:

4 observations
4 variables
Variables
subject_no
subject_id
sex
age

Actual Output
Obs

subject_no

subject_id

sex

age

1

1001

SUBJ001

M

34

2

1002

SUBJ002

F

29

3

1003

SUBJ003

M

41

4

1004

SUBJ004

F

37

Result
The actual output matched my prediction.

Observations: 4
Variables: 4

6. Independent Exercise: Laboratory Results Dataset
The independent exercise creates a dataset named lab_results.

data lab_results;

    input subject_id $ visit $ test_name $ result;

    datalines;
SUBJ001 BASELINE HGB 13.2
SUBJ001 WEEK4 HGB 13.5
SUBJ002 BASELINE HGB 12.8
SUBJ002 WEEK4 HGB 13.1
SUBJ003 BASELINE HGB 14.0
;
run;

proc print data=lab_results;
run;

7. Independent Exercise Explanation
data lab_results;

This creates a SAS dataset named lab_results.

input subject_id $ visit $ test_name $ result;

This tells SAS how to read the four variables.

Variable

Type

Example

subject_id

Character

SUBJ001

visit

Character

BASELINE, WEEK4

test_name

Character

HGB

result

Numeric

13.2, 13.5

The dollar sign is required for the character variables:

subject_id $
visit $
test_name $

The result variable is numeric, so it does not require a dollar sign.

8. Independent Exercise Output Prediction
The DATALINES section contains five complete data rows:

1. SUBJ001 BASELINE HGB 13.2
2. SUBJ001 WEEK4 HGB 13.5
3. SUBJ002 BASELINE HGB 12.8
4. SUBJ002 WEEK4 HGB 13.1
5. SUBJ003 BASELINE HGB 14.0

Therefore, I predicted:

Observations: 5
Variables: 4

9. Actual Laboratory Results Output
The actual output was:

Obs

subject_id

visit

test_name

result

1

SUBJ001

BASELINE

HGB

13.2

2

SUBJ001

WEEK4

HGB

13.5

3

SUBJ002

BASELINE

HGB

12.8

4

SUBJ002

WEEK4

HGB

13.1

5

SUBJ003

BASELINE

HGB

14.0

Result
The actual output matched my prediction.

Observations: 5
Variables: 4

The dataset contains five observations because five complete data rows were provided in the DATALINES section.

No additional observation is created automatically.

10. Observation and Variable Count
subjects Dataset
Observations: 4
Variables: 4

lab_results Dataset
Observations: 5
Variables: 4

Important Rule
Each complete raw-data row normally becomes one observation.

For example:

datalines;
A 10
B 20
C 30
;

This creates three observations.

The semicolon after the last data line only indicates the end of the raw data. It does not create an additional observation.

11. SAS Log and Output Check
After running the complete SAS program, I checked the Output window.

The Output window showed:

Four observations for the subjects dataset
Five observations for the lab_results dataset
Four variables in each dataset
Correct assignment of character and numeric values
The SAS Log should be checked for:

ERROR
WARNING
Invalid numeric data
Uninitialized variables
Incorrect variable names
Incorrect observation counts
Incorrect variable counts
The program should be considered complete only after checking both the SAS Log and the Output window.

12. Debugging Points
Missing Dollar Sign
Incorrect:

input subject_no subject_id sex age;

If subject_id and sex contain character values, the dollar sign is required.

Correct:

input subject_no subject_id $ sex $ age;

Incorrect Variable Order
The order of the variables in the INPUT statement must match the order of the raw-data values.

Correct:

input subject_id $ visit $ test_name $ result;

Correct raw data:

SUBJ001 BASELINE HGB 13.2

The values are read in this order:

subject_id → visit → test_name → result

Missing Space Between Values
Each value in a raw-data row should be separated correctly.

Correct:

1004 SUBJ004 F 37

The values are:

1004
SUBJ004
F
37

Missing Data Row
If five complete data rows are provided, SAS creates five observations.

For example:

datalines;
row 1
row 2
row 3
row 4
row 5
;

This creates five observations.

SAS does not create an additional observation automatically.

13. Clinical Programming Relevance
This exercise is related to Clinical SAS programming because clinical datasets commonly contain:

Subject identifiers
Visit information
Laboratory test names
Laboratory results
Demographic variables
Treatment information
The subjects dataset represents basic subject-level information.

The lab_results dataset represents a simple laboratory-results dataset.

The subject_id variable identifies the subject.

The visit variable identifies the visit at which the laboratory result was collected.

The test_name variable identifies the laboratory test.

The result variable contains a numeric laboratory result.

In real clinical programming projects, data may be read from external files instead of DATALINES. However, the concepts of variable types, input order, observation counts, and data validation remain important.

14. Quality and Validation Checks
Before using a dataset, I should check:

Is subject_id present?
Are subject IDs in the expected format?
Are character variables read as character?
Are numeric variables read as numeric?
Are laboratory results numeric?
Are visit values consistent?
Is the number of observations correct?
Is the number of variables correct?
Does the actual output match the expected output?
Are there any errors or warnings in the SAS Log?
15. Key Learning Points
The INPUT statement tells SAS how to read raw data.
The DATALINES statement allows raw data to be entered directly into a SAS program.
The dollar sign ($) identifies a character variable.
Variables without $ are numeric by default.
The variable order in the INPUT statement must match the raw-data order.
Each complete raw-data row normally becomes one observation.
PROC PRINT displays a SAS dataset.
The SAS Log should be checked after running the program.
The Output window should be compared with the predicted output.
The subjects dataset contains four observations and four variables.
The lab_results dataset contains five observations and four variables.
Subject-level and laboratory-results data are relevant to Clinical SAS programming.
16. Interview-Style Questions
What is the purpose of the INPUT statement?
What is the purpose of the DATALINES statement?
What does the $ symbol represent in SAS?
Which variables are character variables in the subjects dataset?
Why is result a numeric variable in the lab_results dataset?
How many observations are created in the lab_results dataset?
What happens if the variable order in the INPUT statement does not match the raw-data order?
How can you check the number of observations and variables?
Why should the SAS Log be checked after running a program?
How is subject_id relevant to Clinical SAS programming?
17. Certification-Style Questions
Question 1
Which statement is used to read raw data values into SAS variables?

A. OUTPUT
B. INPUT
C. PRINT
D. LABEL

Answer:

B. INPUT

Question 2
What does the $ symbol indicate?

A. Date variable
B. Numeric variable
C. Character variable
D. Missing value

Answer:

C. Character variable

Question 3
How many observations are created from the following data?

datalines;
A 10
B 20
C 30
;

Answer:

3 observations

Question 4
In the following statement, which variables are character variables?

input subject_id $ visit $ result;

Answer:

subject_id and visit

18. English Interview Practice
Simple Explanation
The INPUT statement tells SAS how to read raw data and assign values to variables. The dollar sign identifies character variables. The DATALINES statement allows raw data to be entered directly into the SAS program.

30-Second Interview Answer
In SAS, I use the INPUT statement to define how raw data should be read. Variables with a dollar sign are character variables, while variables without a dollar sign are numeric by default. I use the DATALINES statement when I want to enter raw data directly inside the program. After running the code, I check the SAS Log and Output to confirm that the dataset was created correctly.

Exercise Explanation
In this exercise, I created a subject-level dataset and a laboratory-results dataset using the DATA step, INPUT statement, and DATALINES statement. I identified character variables using the dollar sign and kept numeric variables without the dollar sign. I used PROC PRINT to display the datasets and verified that the observation and variable counts matched my predictions.

19. Files for This Lesson
SAS Code File
03_datalines_and_input.sas

Markdown Documentation File
03_datalines_and_input.md

Repository Location
Clinical-SAS-Mastery/base_sas/01_language_basics/

20. GitHub Commit Message
If both files are uploaded together, use:

Add DATALINES and INPUT lesson

If the files are uploaded separately, use:

Add DATALINES and INPUT documentation

and:

Add DATALINES and INPUT practice code

Lesson Completion Status
[x] Theory completed
[x] Guided example completed
[x] Independent exercise completed
[x] Guided and independent code placed in one SAS file
[x] Complete SAS file executed
[x] subjects output checked
[x] lab_results output checked
[x] Output prediction compared with actual output
[x] Observation and variable counts verified
[x] Clinical relevance documented
[x] Interview questions prepared
[x] Certification-style questions prepared
[x] English interview practice prepared
[ ] Final SAS Log review
[ ] Upload both files to GitHub
[ ] Add the GitHub commit

ఈ content నీ current exercise కి match అవుతుంది:

```text
subjects    = 4 observations, 4 variables
lab_results = 5 observations, 4 variables

GitHub లో upload చేయాల్సినవి ఇవి రెండే:

03_datalines_and_input.md
03_datalines_and_input.sas

README.md ని ఈ lesson కోసం మార్చకూడదు.

03_datalines_and_input.md
deenikosam copy paste laga ivvu?

అవును. క్రింద ఉన్న content ని పూర్తిగా copy చేసి, exact filename తో save చేయి:

03_datalines_and_input.md

Folder:

Clinical-SAS-Mastery/base_sas/01_language_basics/

# Lesson 3: DATALINES and INPUT

## Learning Objective

In this lesson, I learned how to create SAS datasets from raw data using the `DATALINES` statement and the `INPUT` statement.

I also learned how to:

- Read raw data values in SAS
- Define numeric and character variables
- Use the dollar sign (`$`) for character variables
- Create a subject-level dataset
- Create a laboratory-results dataset
- Display datasets using `PROC PRINT`
- Predict the number of observations and variables
- Compare predicted output with actual output
- Check the SAS Log and Output window

---

## 1. The INPUT Statement

The `INPUT` statement tells SAS how to read values from raw data.

It defines:

- The variable names
- The order in which the values are read
- Whether a variable is numeric or character

### General Syntax

```sas
input variable1 variable2 $ variable3;

Variables without a dollar sign are numeric by default.

Variables with a dollar sign are character variables.

Example
input subject_no subject_id $ sex $ age;

This statement tells SAS to read:

Variable

Type

Reason

subject_no

Numeric

It contains numbers

subject_id

Character

It contains values such as SUBJ001

sex

Character

It contains values such as M and F

age

Numeric

It contains numbers

2. The DATALINES Statement
The DATALINES statement allows raw data to be entered directly inside a SAS program.

General Structure
data dataset_name;
    input variable_list;

    datalines;
    raw data values
    ;
run;

The semicolon after the last raw-data line tells SAS that the DATALINES section has ended.

Each complete raw-data row normally becomes one observation.

3. Guided Example: Subject-Level Dataset
The following program creates a dataset named subjects.

data subjects;

    input subject_no subject_id $ sex $ age;

    datalines;
1001 SUBJ001 M 34
1002 SUBJ002 F 29
1003 SUBJ003 M 41
1004 SUBJ004 F 37
;
run;

proc print data=subjects;
run;

4. Guided Example Explanation
data subjects;

This starts the DATA step and creates a SAS dataset named subjects.

input subject_no subject_id $ sex $ age;

This tells SAS how to read the raw data.

subject_no is numeric.
subject_id $ is character.
sex $ is character.
age is numeric.
datalines;

This tells SAS that raw data will be entered directly in the program.

1001 SUBJ001 M 34
1002 SUBJ002 F 29
1003 SUBJ003 M 41
1004 SUBJ004 F 37

These are four raw-data records.

;

This marks the end of the raw data.

run;

This completes the DATA step.

proc print data=subjects;
run;

This displays the subjects dataset in the Output window.

5. Guided Example Output Prediction
Before running the code, I predicted that the subjects dataset would contain:

4 observations
4 variables
Variables
subject_no
subject_id
sex
age

Actual Output
Obs

subject_no

subject_id

sex

age

1

1001

SUBJ001

M

34

2

1002

SUBJ002

F

29

3

1003

SUBJ003

M

41

4

1004

SUBJ004

F

37

Result
The actual output matched my prediction.

Observations: 4
Variables: 4

6. Independent Exercise: Laboratory Results Dataset
The independent exercise creates a dataset named lab_results.

data lab_results;

    input subject_id $ visit $ test_name $ result;

    datalines;
SUBJ001 BASELINE HGB 13.2
SUBJ001 WEEK4 HGB 13.5
SUBJ002 BASELINE HGB 12.8
SUBJ002 WEEK4 HGB 13.1
SUBJ003 BASELINE HGB 14.0
;
run;

proc print data=lab_results;
run;

7. Independent Exercise Explanation
data lab_results;

This creates a SAS dataset named lab_results.

input subject_id $ visit $ test_name $ result;

This tells SAS how to read the four variables.

Variable

Type

Example

subject_id

Character

SUBJ001

visit

Character

BASELINE, WEEK4

test_name

Character

HGB

result

Numeric

13.2, 13.5

The dollar sign is required for the following character variables:

subject_id $
visit $
test_name $

The result variable is numeric, so it does not require a dollar sign.

8. Independent Exercise Output Prediction
The DATALINES section contains five complete data rows:

1. SUBJ001 BASELINE HGB 13.2
2. SUBJ001 WEEK4 HGB 13.5
3. SUBJ002 BASELINE HGB 12.8
4. SUBJ002 WEEK4 HGB 13.1
5. SUBJ003 BASELINE HGB 14.0

Therefore, I predicted:

Observations: 5
Variables: 4

9. Actual Laboratory Results Output
The actual output was:

Obs

subject_id

visit

test_name

result

1

SUBJ001

BASELINE

HGB

13.2

2

SUBJ001

WEEK4

HGB

13.5

3

SUBJ002

BASELINE

HGB

12.8

4

SUBJ002

WEEK4

HGB

13.1

5

SUBJ003

BASELINE

HGB

14.0

Result
The actual output matched my prediction.

Observations: 5
Variables: 4

The dataset contains five observations because five complete data rows were provided in the DATALINES section.

SAS does not create an additional observation automatically.

10. Observation and Variable Count
subjects Dataset
Observations: 4
Variables: 4

lab_results Dataset
Observations: 5
Variables: 4

Important Rule
Each complete raw-data row normally becomes one observation.

For example:

datalines;
A 10
B 20
C 30
;

This creates three observations.

The semicolon after the last data line only indicates the end of the raw data. It does not create an additional observation.

11. SAS Log and Output Check
After running the complete SAS program, I checked the Output window.

The Output window showed:

Four observations for the subjects dataset
Five observations for the lab_results dataset
Four variables in each dataset
Correct assignment of character and numeric values
The SAS Log should be checked for:

ERROR
WARNING
Invalid numeric data
Uninitialized variables
Incorrect variable names
Incorrect observation counts
Incorrect variable counts
The program should be considered complete only after checking both the SAS Log and the Output window.

12. Debugging Points
12.1 Missing Dollar Sign
Incorrect:

input subject_no subject_id sex age;

If subject_id and sex contain character values, the dollar sign is required.

Correct:

input subject_no subject_id $ sex $ age;

12.2 Incorrect Variable Order
The order of the variables in the INPUT statement must match the order of the raw-data values.

Correct:

input subject_id $ visit $ test_name $ result;

Correct raw data:

SUBJ001 BASELINE HGB 13.2

The values are read in this order:

subject_id → visit → test_name → result

12.3 Missing Space Between Values
Each value in a raw-data row should be separated correctly.

Correct:

1004 SUBJ004 F 37

The values are:

1004
SUBJ004
F
37

12.4 Missing Data Row
If five complete data rows are provided, SAS creates five observations.

For example:

datalines;
row 1
row 2
row 3
row 4
row 5
;

This creates five observations.

SAS does not create an additional observation automatically.

13. Clinical Programming Relevance
This exercise is related to Clinical SAS programming because clinical datasets commonly contain:

Subject identifiers
Visit information
Laboratory test names
Laboratory results
Demographic variables
Treatment information
The subjects dataset represents basic subject-level information.

The lab_results dataset represents a simple laboratory-results dataset.

The subject_id variable identifies the subject.

The visit variable identifies the visit at which the laboratory result was collected.

The test_name variable identifies the laboratory test.

The result variable contains a numeric laboratory result.

In real clinical programming projects, data may be read from external files instead of DATALINES. However, the concepts of variable types, input order, observation counts, and data validation remain important.

14. Quality and Validation Checks
Before using a dataset, I should check:

Is subject_id present?
Are subject IDs in the expected format?
Are character variables read as character?
Are numeric variables read as numeric?
Are laboratory results numeric?
Are visit values consistent?
Is the number of observations correct?
Is the number of variables correct?
Does the actual output match the expected output?
Are there any errors or warnings in the SAS Log?
15. Key Learning Points
The INPUT statement tells SAS how to read raw data.
The DATALINES statement allows raw data to be entered directly into a SAS program.
The dollar sign ($) identifies a character variable.
Variables without $ are numeric by default.
The variable order in the INPUT statement must match the raw-data order.
Each complete raw-data row normally becomes one observation.
PROC PRINT displays a SAS dataset.
The SAS Log should be checked after running the program.
The Output window should be compared with the predicted output.
The subjects dataset contains four observations and four variables.
The lab_results dataset contains five observations and four variables.
Subject-level and laboratory-results data are relevant to Clinical SAS programming.
16. Interview-Style Questions
What is the purpose of the INPUT statement?
What is the purpose of the DATALINES statement?
What does the $ symbol represent in SAS?
Which variables are character variables in the subjects dataset?
Why is result a numeric variable in the lab_results dataset?
How many observations are created in the lab_results dataset?
What happens if the variable order in the INPUT statement does not match the raw-data order?
How can you check the number of observations and variables?
Why should the SAS Log be checked after running a program?
How is subject_id relevant to Clinical SAS programming?
17. Certification-Style Questions
Question 1
Which statement is used to read raw data values into SAS variables?

A. OUTPUT
B. INPUT
C. PRINT
D. LABEL

Answer:

B. INPUT

Question 2
What does the $ symbol indicate?

A. Date variable
B. Numeric variable
C. Character variable
D. Missing value

Answer:

C. Character variable

Question 3
How many observations are created from the following data?

datalines;
A 10
B 20
C 30
;

Answer:

3 observations

Question 4
In the following statement, which variables are character variables?

input subject_id $ visit $ result;

Answer:

subject_id and visit

18. English Interview Practice
Simple Explanation
The INPUT statement tells SAS how to read raw data and assign values to variables. The dollar sign identifies character variables. The DATALINES statement allows raw data to be entered directly into the SAS program.

30-Second Interview Answer
In SAS, I use the INPUT statement to define how raw data should be read. Variables with a dollar sign are character variables, while variables without a dollar sign are numeric by default. I use the DATALINES statement when I want to enter raw data directly inside the program. After running the code, I check the SAS Log and Output to confirm that the dataset was created correctly.

Exercise Explanation
In this exercise, I created a subject-level dataset and a laboratory-results dataset using the DATA step, INPUT statement, and DATALINES statement. I identified character variables using the dollar sign and kept numeric variables without the dollar sign. I used PROC PRINT to display the datasets and verified that the observation and variable counts matched my predictions.

19. Files for This Lesson
SAS Code File
03_datalines_and_input.sas

Markdown Documentation File
03_datalines_and_input.md

Repository Location
Clinical-SAS-Mastery/base_sas/01_language_basics/

20. GitHub Commit Message
If both files are uploaded together, use:

Add DATALINES and INPUT lesson

If the files are uploaded separately, use:

Add DATALINES and INPUT documentation

and:

Add DATALINES and INPUT practice code

Lesson Completion Status
[x] Theory completed
[x] Guided example completed
[x] Independent exercise completed
[x] Guided and independent code placed in one SAS file
[x] Complete SAS file executed
[x] subjects output checked
[x] lab_results output checked
[x] Output prediction compared with actual output
[x] Observation and variable counts verified
[x] Clinical relevance documented
[x] Interview questions prepared
[x] Certification-style questions prepared
[x] English interview practice prepared
[ ] Final SAS Log review
[ ] Upload both files to GitHub
[ ] Add the GitHub commi