# Lesson 07: IF-THEN and IF-THEN-ELSE

## Lesson Overview

This lesson explains how to use the `IF-THEN` and `IF-THEN-ELSE` statements in a SAS DATA step.

In this lesson, I will learn how to:

- Apply conditional logic in SAS.
- Execute a statement when a condition is true.
- Execute alternative statements when a condition is false.
- Create derived variables using conditions.
- Filter observations using conditional logic.
- Understand the difference between `IF-THEN` and `IF-THEN-ELSE`.
- Review the SAS Log.
- Apply conditional logic in Clinical SAS programming.

## Learning Objectives

After completing this lesson, I should be able to:

1. Explain the purpose of the `IF-THEN` statement.
2. Explain the purpose of the `IF-THEN-ELSE` statement.
3. Use comparison operators in SAS.
4. Create a derived variable using conditional logic.
5. Use character and numeric conditions.
6. Use multiple conditions with `AND` and `OR`.
7. Understand how missing values affect conditions.
8. Predict the output of conditional SAS code.
9. Identify and correct common conditional logic errors.
10. Explain the relevance of conditional logic in Clinical SAS programming.

## Data Policy

This lesson uses a SAS-provided sample dataset and simulated values for learning practice.

No personal, confidential, or real patient-level data is used.

## What Is Conditional Logic?

Conditional logic allows a SAS program to make a decision based on whether a condition is true or false.

For example:

- If age is greater than or equal to 18, classify a person as an adult.
- If a score is greater than or equal to 50, classify the result as pass.
- If treatment is equal to `"Active"`, identify the subject as belonging to the active treatment group.

Conditional logic is commonly used to:

- Create derived variables.
- Categorize observations.
- Apply data-cleaning rules.
- Identify abnormal values.
- Flag records for review.
- Prepare clinical datasets.

## IF-THEN Statement

The `IF-THEN` statement executes a SAS statement only when a condition is true.

### General Syntax

```sas
if condition then statement;
```

### Example

```sas
if age >= 18 then adult_flag = "Y";
```

### Explanation

```sas
if age >= 18
```

This checks whether the value of `AGE` is greater than or equal to 18.

```sas
then adult_flag = "Y";
```

If the condition is true, SAS assigns `"Y"` to the variable `ADULT_FLAG`.

### Important Point

If the condition is false, SAS does not execute the statement.

For example, if `AGE` is 15:

```sas
if age >= 18 then adult_flag = "Y";
```

The variable `ADULT_FLAG` will not receive `"Y"` from this statement.

## IF-THEN-ELSE Statement

The `IF-THEN-ELSE` statement executes one statement when the condition is true and another statement when the condition is false.

### General Syntax

```sas
if condition then statement1;
else statement2;
```

### Example

```sas
if age >= 18 then age_group = "Adult";
else age_group = "Minor";
```

### Explanation

- If `AGE` is greater than or equal to 18, SAS assigns `"Adult"` to `AGE_GROUP`.
- If `AGE` is less than 18, SAS assigns `"Minor"` to `AGE_GROUP`.

## Difference Between IF-THEN and IF-THEN-ELSE

| Feature | IF-THEN | IF-THEN-ELSE |
|---|---|---|
| True condition | Executes the THEN statement | Executes the THEN statement |
| False condition | Does nothing | Executes the ELSE statement |
| Use | One-sided decision | Two-sided decision |
| Example | Flag only adults | Classify adults and minors |
| Output | May leave a variable missing | Assigns one of two values |

### Simple Explanation

> `IF-THEN` performs an action only when the condition is true. `IF-THEN-ELSE` performs one action when the condition is true and another action when the condition is false.

## Comparison Operators

SAS uses comparison operators to compare values.

| Operator | Meaning |
|---|---|
| `=` | Equal to |
| `^=` or `NE` | Not equal to |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal to |
| `<=` | Less than or equal to |

### Examples

```sas
if age = 18 then age_flag = "Y";
```

```sas
if age > 18 then age_flag = "Y";
```

```sas
if age <= 18 then age_flag = "Y";
```

```sas
if sex ne "M" then non_male_flag = "Y";
```

## Logical Operators

Logical operators are used to combine multiple conditions.

| Operator | Meaning |
|---|---|
| `AND` | Both conditions must be true |
| `OR` | At least one condition must be true |
| `NOT` | Reverses the condition |

### AND Example

```sas
if age >= 18 and sex = "F" then group = "Adult Female";
```

Both conditions must be true:

- `AGE` must be greater than or equal to 18.
- `SEX` must be equal to `"F"`.

### OR Example

```sas
if age = 14 or age = 15 then young_group = "Y";
```

At least one condition must be true.

### NOT Example

```sas
if not missing(age) then age_available = "Y";
```

This checks whether `AGE` is not missing.

## Guided Practice

### Step 1: Create a Sample Dataset

```sas
data work.student_lesson07;
    input student_id $ age score sex $;
    datalines;
S001 17 45 F
S002 18 72 M
S003 20 88 F
S004 16 35 M
S005 19 61 F
;
run;
```

This DATA step creates a simulated student dataset.

The variables are:

- `STUDENT_ID`
- `AGE`
- `SCORE`
- `SEX`

### Step 2: Create a Pass or Fail Variable

```sas
data work.student_result_lesson07;
    set work.student_lesson07;

    if score >= 50 then result = "Pass";
    else result = "Fail";
run;
```

This code creates the derived variable `RESULT`.

- If `SCORE` is greater than or equal to 50, `RESULT` is `"Pass"`.
- If `SCORE` is less than 50, `RESULT` is `"Fail"`.

### Step 3: Create an Age Group Variable

```sas
data work.student_result_lesson07;
    set work.student_lesson07;

    if age >= 18 then age_group = "Adult";
    else age_group = "Minor";
run;
```

This code creates the derived variable `AGE_GROUP`.

### Step 4: Create Multiple Derived Variables

```sas
data work.student_result_lesson07;
    set work.student_lesson07;

    if score >= 50 then result = "Pass";
    else result = "Fail";

    if age >= 18 then age_group = "Adult";
    else age_group = "Minor";
run;
```

This program creates two derived variables:

- `RESULT`
- `AGE_GROUP`

## Complete Guided SAS Program

```sas
/*
    Clinical-SAS-Mastery
    Folder: base_sas/01_language_basics
    Lesson 07: IF-THEN and IF-THEN-ELSE

    Purpose:
    - Understand conditional logic in SAS.
    - Use IF-THEN and IF-THEN-ELSE statements.
    - Create derived variables.
    - Review the SAS Log.

    Data policy:
    Simulated learning data used for practice.
*/

data work.student_lesson07;
    input student_id $ age score sex $;
    datalines;
S001 17 45 F
S002 18 72 M
S003 20 88 F
S004 16 35 M
S005 19 61 F
;
run;

data work.student_result_lesson07;
    set work.student_lesson07;

    if score >= 50 then result = "Pass";
    else result = "Fail";

    if age >= 18 then age_group = "Adult";
    else age_group = "Minor";
run;

proc print data=work.student_result_lesson07;
run;
```

## Expected Output

The expected derived values are:

| Student ID | Age | Score | Sex | Result | Age Group |
|---|---:|---:|---|---|---|
| S001 | 17 | 45 | F | Fail | Minor |
| S002 | 18 | 72 | M | Pass | Adult |
| S003 | 20 | 88 | F | Pass | Adult |
| S004 | 16 | 35 | M | Fail | Minor |
| S005 | 19 | 61 | F | Pass | Adult |

## IF-THEN Example

```sas
data work.adult_flag_lesson07;
    set work.student_lesson07;

    if age >= 18 then adult_flag = "Y";
run;
```

### Expected Result

| Student ID | Age | Adult Flag |
|---|---:|---|
| S001 | 17 | Missing |
| S002 | 18 | Y |
| S003 | 20 | Y |
| S004 | 16 | Missing |
| S005 | 19 | Y |

### Explanation

The `IF-THEN` statement assigns `"Y"` only when `AGE` is greater than or equal to 18.

For observations where the condition is false, `ADULT_FLAG` remains missing.

## IF-THEN-ELSE Example

```sas
data work.adult_status_lesson07;
    set work.student_lesson07;

    if age >= 18 then adult_status = "Adult";
    else adult_status = "Minor";
run;
```

### Expected Result

| Student ID | Age | Adult Status |
|---|---:|---|
| S001 | 17 | Minor |
| S002 | 18 | Adult |
| S003 | 20 | Adult |
| S004 | 16 | Minor |
| S005 | 19 | Adult |

### Explanation

The `IF-THEN-ELSE` statement assigns a value for every observation:

- `"Adult"` when the condition is true.
- `"Minor"` when the condition is false.

## Multiple Conditions

### Example Using AND

```sas
data work.female_pass_lesson07;
    set work.student_lesson07;

    if sex = "F" and score >= 50 then female_pass = "Y";
    else female_pass = "N";
run;
```

Both conditions must be true:

1. `SEX` must be `"F"`.
2. `SCORE` must be greater than or equal to 50.

### Expected Result

| Student ID | Sex | Score | Female Pass |
|---|---|---:|---|
| S001 | F | 45 | N |
| S002 | M | 72 | N |
| S003 | F | 88 | Y |
| S004 | M | 35 | N |
| S005 | F | 61 | Y |

### Example Using OR

```sas
data work.selected_age_lesson07;
    set work.student_lesson07;

    if age = 17 or age = 19 then selected_age = "Y";
    else selected_age = "N";
run;
```

At least one condition must be true.

## Multiple IF-THEN-ELSE Conditions

When there are more than two categories, use an `ELSE IF` structure.

### Example

```sas
data work.score_category_lesson07;
    set work.student_lesson07;

    if score >= 80 then score_category = "High";
    else if score >= 50 then score_category = "Pass";
    else score_category = "Fail";
run;
```

### Logic

- If `SCORE` is 80 or higher, assign `"High"`.
- Otherwise, if `SCORE` is 50 or higher, assign `"Pass"`.
- Otherwise, assign `"Fail"`.

### Expected Result

| Student ID | Score | Score Category |
|---|---:|---|
| S001 | 45 | Fail |
| S002 | 72 | Pass |
| S003 | 88 | High |
| S004 | 35 | Fail |
| S005 | 61 | Pass |

## Important Point About ELSE IF

The order of the conditions is important.

Correct order:

```sas
if score >= 80 then score_category = "High";
else if score >= 50 then score_category = "Pass";
else score_category = "Fail";
```

If the lower condition is written first, the higher category may never be reached.

Example of a problematic order:

```sas
if score >= 50 then score_category = "Pass";
else if score >= 80 then score_category = "High";
else score_category = "Fail";
```

A score of 88 satisfies `score >= 50` first, so it is classified as `"Pass"` instead of `"High"`.

## Missing Values and Conditional Logic

Missing values should be handled carefully.

### Example

```sas
data work.missing_score_lesson07;
    input student_id $ score;
    datalines;
S001 45
S002 72
S003 .
S004 35
;
run;

data work.missing_score_result_lesson07;
    set work.missing_score_lesson07;

    if missing(score) then result = "Not Available";
    else if score >= 50 then result = "Pass";
    else result = "Fail";
run;
```

### Logic

- If `SCORE` is missing, assign `"Not Available"`.
- Otherwise, if `SCORE` is 50 or higher, assign `"Pass"`.
- Otherwise, assign `"Fail"`.

## Filtering Observations Using IF

An `IF` statement without `THEN` can be used to keep observations.

### Example

```sas
data work.adult_students_lesson07;
    set work.student_lesson07;

    if age >= 18;
run;
```

This keeps only observations where `AGE` is greater than or equal to 18.

### Important Difference

```sas
if age >= 18 then adult_flag = "Y";
```

This creates a flag but keeps all observations.

```sas
if age >= 18;
```

This keeps only observations where the condition is true.

## Independent Exercise

Create a new dataset using the following simulated employee data:

```sas
data work.employee_lesson07;
    input employee_id $ department $ experience salary;
    datalines;
E001 SAS 2 45000
E002 SQL 5 65000
E003 SAS 7 85000
E004 SDTM 1 40000
E005 ADAM 4 70000
;
run;
```

Create the following derived variables:

1. `experience_group`
   - `"Experienced"` if experience is greater than or equal to 5.
   - `"Developing"` otherwise.

2. `salary_group`
   - `"High"` if salary is greater than or equal to 70000.
   - `"Standard"` otherwise.

3. `career_level`
   - `"Senior"` if experience is greater than or equal to 5.
   - `"Intermediate"` if experience is between 3 and 4.
   - `"Junior"` otherwise.

### Independent Exercise Template

```sas
data work.employee_result_lesson07;
    set work.employee_lesson07;

    /* Create experience_group */

    /* Create salary_group */

    /* Create career_level */

run;

proc print data=work.employee_result_lesson07;
run;
```

## Output Prediction Task

Predict the value of `RESULT` and `AGE_GROUP` before running the code.

```sas
data work.prediction_lesson07;
    input student_id $ age score;
    datalines;
S001 17 45
S002 18 50
S003 21 91
;
run;

data work.prediction_result_lesson07;
    set work.prediction_lesson07;

    if score >= 50 then result = "Pass";
    else result = "Fail";

    if age >= 18 then age_group = "Adult";
    else age_group = "Minor";
run;
```

### My Prediction

| Student ID | Result | Age Group |
|---|---|---|
| S001 |  |  |
| S002 |  |  |
| S003 |  |  |

### Correct Prediction

| Student ID | Result | Age Group |
|---|---|---|
| S001 | Fail | Minor |
| S002 | Pass | Adult |
| S003 | Pass | Adult |

## Debugging Task 1: Missing Semicolon

### Incorrect Code

```sas
data work.debug_lesson07;
    set work.student_lesson07;

    if score >= 50 then result = "Pass"
    else result = "Fail";
run;
```

### Problem

The `THEN` statement is missing a semicolon.

Incorrect statement:

```sas
if score >= 50 then result = "Pass"
```

### Correct Code

```sas
data work.debug_lesson07;
    set work.student_lesson07;

    if score >= 50 then result = "Pass";
    else result = "Fail";
run;
```

## Debugging Task 2: Incorrect ELSE Placement

### Incorrect Code

```sas
data work.debug_else_lesson07;
    set work.student_lesson07;

    if age >= 18 then age_group = "Adult";
    age_group = "Minor";
    else age_group = "Unknown";
run;
```

### Problem

The `ELSE` statement must immediately follow the related `IF-THEN` statement.

### Correct Code

```sas
data work.debug_else_lesson07;
    set work.student_lesson07;

    if age >= 18 then age_group = "Adult";
    else age_group = "Minor";
run;
```

## Debugging Task 3: Incorrect Character Comparison

### Incorrect Code

```sas
data work.debug_character_lesson07;
    set work.student_lesson07;

    if sex = F then sex_group = "Female";
    else sex_group = "Other";
run;
```

### Problem

Character values must be enclosed in quotation marks.

Incorrect comparison:

```sas
if sex = F
```

### Correct Code

```sas
data work.debug_character_lesson07;
    set work.student_lesson07;

    if sex = "F" then sex_group = "Female";
    else sex_group = "Other";
run;
```

## SAS Log Review

After running the program, review the SAS Log.

### Log Items to Check

Check whether the log contains:

- `ERROR:`
- `WARNING:`
- Notes about observations read.
- Notes about observations created.
- Notes about variables created.
- Notes about uninitialized variables.

### Expected Result

```text
Errors: 0
Warnings: 0
Uninitialized variables: 0
```

### Quality Checks

Confirm that:

- The condition is written correctly.
- Character values are enclosed in quotation marks.
- Every SAS statement ends with a semicolon.
- The ELSE statement follows the correct IF-THEN statement.
- The order of ELSE IF conditions is correct.
- Missing values are handled appropriately.

## Clinical SAS Relevance

Conditional logic is frequently used in Clinical SAS programming.

It can be used to:

- Create treatment flags.
- Create population flags.
- Identify safety subjects.
- Categorize laboratory results.
- Derive severity categories.
- Create analysis flags.
- Identify protocol deviations.
- Create baseline flags.
- Apply inclusion and exclusion criteria.
- Perform data validation checks.

## Clinical SAS Example: Treatment Flag

```sas
data work.subject_treatment_lesson07;
    input subject_id $ treatment $;
    datalines;
SUB001 Active
SUB002 Placebo
SUB003 Active
SUB004 Placebo
;
run;

data work.subject_treatment_flag_lesson07;
    set work.subject_treatment_lesson07;

    if treatment = "Active" then active_flag = "Y";
    else active_flag = "N";
run;
```

## Clinical SAS Example: Safety Population Flag

```sas
data work.safety_population_lesson07;
    input subject_id $ treated;
    datalines;
SUB001 1
SUB002 0
SUB003 1
SUB004 1
;
run;

data work.safety_population_flag_lesson07;
    set work.safety_population_lesson07;

    if treated = 1 then safety_flag = "Y";
    else safety_flag = "N";
run;
```

## Clinical SAS Example: Severity Category

```sas
data work.lab_result_lesson07;
    input subject_id $ lab_value;
    datalines;
SUB001 4
SUB002 8
SUB003 15
SUB004 25
;
run;

data work.lab_severity_lesson07;
    set work.lab_result_lesson07;

    if lab_value < 5 then severity = "Normal";
    else if lab_value < 10 then severity = "Mild";
    else if lab_value < 20 then severity = "Moderate";
    else severity = "Severe";
run;
```

## Clinical Programming Flow

```text
Raw Clinical Data
        |
        v
DATA Step
        |
        v
IF-THEN-ELSE Logic
        |
        v
Derived Variables and Flags
        |
        v
SDTM or ADaM Dataset
        |
        v
Validation and Reporting
```

## Interview Questions and Answers

### Question 1: What Is the Purpose of an IF-THEN Statement?

**Answer:**

> The IF-THEN statement executes a SAS statement only when a specified condition is true.

### Question 2: What Is the Difference Between IF-THEN and IF-THEN-ELSE?

**Answer:**

> IF-THEN performs an action only when the condition is true. IF-THEN-ELSE performs one action when the condition is true and another action when the condition is false.

### Question 3: What Happens When an IF-THEN Condition Is False?

**Answer:**

> When an IF-THEN condition is false, the THEN statement is not executed. If the variable is not assigned another value, it may remain missing.

### Question 4: How Do You Compare a Character Value in SAS?

**Answer:**

> Character values must be enclosed in quotation marks. For example, `if sex = "F" then female_flag = "Y";`.

### Question 5: How Do You Combine Two Conditions in SAS?

**Answer:**

> I can use the `AND` operator when both conditions must be true, or the `OR` operator when at least one condition must be true.

### Question 6: Why Is the Order of ELSE IF Conditions Important?

**Answer:**

> SAS evaluates ELSE IF conditions from top to bottom. Once a true condition is found, SAS executes that statement and does not evaluate the remaining conditions.

### Question 7: How Is IF-THEN-ELSE Used in Clinical SAS?

**Answer:**

> IF-THEN-ELSE logic is used to derive treatment flags, analysis population flags, severity categories, baseline flags, and other clinical programming variables.

### Question 8: How Do You Handle Missing Values in Conditional Logic?

**Answer:**

> I check for missing values explicitly before applying other conditions. For example, I can use the `MISSING` function to assign a separate category such as `"Not Available"`.

## Certification-Style Questions

### Question 1

Which statement executes only when a condition is true?

A. `IF-THEN`

B. `SET`

C. `KEEP`

D. `LABEL`

### Answer

**A. `IF-THEN`**

The `IF-THEN` statement executes an action only when the condition is true.

### Question 2

Which statement provides an alternative action when the condition is false?

A. `ELSE`

B. `OUTPUT`

C. `FORMAT`

D. `LENGTH`

### Answer

**A. `ELSE`**

The `ELSE` statement provides an alternative action.

### Question 3

Which code correctly compares a character variable?

A.

```sas
if sex = F then flag = "Y";
```

B.

```sas
if sex = "F" then flag = "Y";
```

C.

```sas
if sex = 'F then flag = "Y";
```

D.

```sas
if sex F then flag = "Y";
```

### Answer

**B.**

```sas
if sex = "F" then flag = "Y";
```

Character values must be enclosed in quotation marks.

### Question 4

What is the output of the following code?

```sas
score = 75;

if score >= 50 then result = "Pass";
else result = "Fail";
```

A. Missing

B. Fail

C. Pass

D. Error

### Answer

**C. Pass**

The value 75 is greater than or equal to 50.

### Question 5

Which operator requires both conditions to be true?

A. `OR`

B. `AND`

C. `NOT`

D. `NE`

### Answer

**B. `AND`**

The `AND` operator requires both conditions to be true.

### Question 6

What happens after SAS finds a true condition in an ELSE IF structure?

### Answer

SAS executes the statement associated with the true condition and does not evaluate the remaining ELSE IF conditions.

## Professional English Explanation

> The IF-THEN statement is used to execute a statement when a condition is true. The IF-THEN-ELSE statement provides an alternative statement when the condition is false. In this lesson, I used conditional logic to derive result and age-group variables. In Clinical SAS programming, similar logic can be used to derive treatment flags, analysis population flags, severity categories, and validation flags.

## Lesson Summary

In this lesson, I learned that:

- Conditional logic allows SAS to make decisions.
- `IF-THEN` executes a statement only when a condition is true.
- `IF-THEN-ELSE` provides an alternative action when the condition is false.
- `ELSE IF` is used when there are more than two categories.
- Comparison operators are used to compare values.
- `AND` requires both conditions to be true.
- `OR` requires at least one condition to be true.
- Character values must be enclosed in quotation marks.
- The order of ELSE IF conditions is important.
- Missing values should be handled explicitly.
- IF-THEN-ELSE logic is important in Clinical SAS programming.

## Validation Checklist

Before considering this lesson complete, confirm the following:

- [ ] I can explain the purpose of IF-THEN.
- [ ] I can explain the purpose of IF-THEN-ELSE.
- [ ] I can use comparison operators.
- [ ] I can use `AND` and `OR`.
- [ ] I can create a derived variable.
- [ ] I can create a flag variable.
- [ ] I can use an ELSE IF structure.
- [ ] I can handle missing values.
- [ ] I checked the SAS Log.
- [ ] I completed the independent exercise.
- [ ] I completed the output prediction task.
- [ ] I completed the debugging tasks.
- [ ] I reviewed the Clinical SAS examples.
- [ ] I completed the interview questions.
- [ ] I completed the certification-style questions.
- [ ] I can explain this lesson in professional English.

## GitHub Commit Message

```text
Add Lesson 07 IF-THEN-ELSE practice
```

### Alternative Conventional Commit

```text
feat(base-sas): add IF-THEN-ELSE lesson
```

## File Location

```text
Clinical-SAS-Mastery/
└── base_sas/
    └── 01_language_basics/
        └── 07_if_then_else.md
```

Correct file name:

07_if_then_else.md

Correct file path:

base_sas/01_language_basics/07_if_then_else.md

