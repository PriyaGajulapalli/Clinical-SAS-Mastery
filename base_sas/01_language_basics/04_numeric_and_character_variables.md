# Lesson 4: Numeric and Character Variables

## Program Information

```text
Program: 04_numeric_and_character_variables.sas
Topic: Numeric and Character Variables
Date: October 9, 2026
```

---

## Learning Objectives

By the end of this lesson, I should be able to:

- Explain the difference between numeric and character variables.
- Identify numeric and character variables in a SAS program.
- Use the dollar sign (`$`) for character variables in an `INPUT` statement.
- Read numeric and character values from raw data.
- Match the `INPUT` statement with the order of values in the raw data.
- Create a derived numeric variable using an arithmetic calculation.
- Predict the output before running the program.
- Check the SAS Log for errors and warnings.
- Validate the number of observations and variables.
- Explain the topic using professional interview language.
- Connect numeric and character variables to Clinical SAS programming.

---

# 1. Key Concept

SAS variables can mainly be classified into two types:

1. Character variables
2. Numeric variables

The variable type depends on the kind of information stored in the variable.

---

# 2. Character Variables

Character variables store text, letters, words, codes, labels, or identifiers.

Examples:

```text
SUBJ001
PAT001
M
F
SCREENING
BASELINE
WEEK4
```

In the SAS `INPUT` statement, the dollar sign (`$`) tells SAS that a variable is character.

Example:

```sas
input subject_id $ sex $ age weight_kg;
```

In this statement:

```text
subject_id $ → Character variable
sex $        → Character variable
```

The dollar sign must be placed after every character variable.

---

# 3. Numeric Variables

Numeric variables store numbers and can be used in arithmetic calculations.

Examples:

```text
34
29
68.5
128
1
2
3
```

Numeric variables do not require the dollar sign (`$`) in the `INPUT` statement.

Example:

```sas
input subject_id $ sex $ age weight_kg;
```

In this statement:

```text
age       → Numeric variable
weight_kg → Numeric variable
```

Numeric variables can be used in calculations.

Example:

```sas
age_next_year = age + 1;
```

---

# 4. Character and Numeric Variable Comparison

| Variable | Example Value | Type | Reason |
|---|---:|---|---|
| `subject_id` | `SUBJ001` | Character | It is an identifier containing text |
| `sex` | `M` | Character | It contains text |
| `age` | `34` | Numeric | It represents a number |
| `weight_kg` | `68.5` | Numeric | It represents a measurement |
| `patient_id` | `PAT001` | Character | It is an identifier |
| `visit_label` | `SCREENING` | Character | It contains text |
| `visit_num` | `1` | Numeric | It represents a visit number |
| `systolic_bp` | `128` | Numeric | It represents a measurement |

---

# 5. The Dollar Sign in the INPUT Statement

The dollar sign (`$`) tells SAS to read a variable as character.

```sas
input patient_id $ visit_label $ visit_num systolic_bp;
```

Variable interpretation:

```text
patient_id  $ → Character
visit_label $ → Character
visit_num     → Numeric
systolic_bp   → Numeric
```

The dollar sign is not used for numeric variables.

---

# 6. Variable Order in the INPUT Statement

The order of the variables in the `INPUT` statement must match the order of the values in the raw data.

Raw data:

```text
PAT001 SCREENING 1 128
```

INPUT statement:

```sas
input patient_id $ visit_label $ visit_num systolic_bp;
```

SAS reads the values in this order:

```text
PAT001    → patient_id
SCREENING → visit_label
1         → visit_num
128       → systolic_bp
```

If the order is incorrect, SAS may assign the values to the wrong variables.

---

# 7. Derived Variables

A derived variable is a new variable created from one or more existing variables using a calculation or logical expression.

Example:

```sas
age_next_year = age + 1;
```

In this statement:

```text
age           → Existing numeric variable
age_next_year → New derived numeric variable
```

Example calculation:

```text
age = 34
age_next_year = 34 + 1
age_next_year = 35
```

`age_next_year` is called a derived numeric variable because:

- It is newly created.
- Its value is calculated from an existing variable.
- The result of the calculation is numeric.

Another example:

```sas
next_visit_num = visit_num + 1;
```

Here:

```text
visit_num      → Existing numeric variable
next_visit_num → Derived numeric variable
```

---

# 8. Guided Example

## 8.1 Guided Example Code

```sas
/*======================================================================
  GUIDED EXAMPLE
======================================================================*/

data guided_subjects;

    /* Read character and numeric variables */
    input subject_id $ sex $ age weight_kg;

    /* Create a derived numeric variable */
    age_next_year = age + 1;

    datalines;
SUBJ001 M 34 68.5
SUBJ002 F 29 59.2
SUBJ003 M 41 82.0
;
run;

/* Display the guided dataset */
proc print data=guided_subjects;
run;
```

---

## 8.2 DATA Statement

```sas
data guided_subjects;
```

This starts a DATA step and creates a dataset named:

```text
guided_subjects
```

---

## 8.3 INPUT Statement

```sas
input subject_id $ sex $ age weight_kg;
```

This statement reads four variables from the raw data.

```text
subject_id $ → Character
sex $        → Character
age          → Numeric
weight_kg    → Numeric
```

The dollar sign is used after `subject_id` and `sex` because both variables contain text.

---

## 8.4 Derived Numeric Variable

```sas
age_next_year = age + 1;
```

This statement creates a new variable called `age_next_year`.

For the first observation:

```text
age = 34
age_next_year = 34 + 1
age_next_year = 35
```

For the second observation:

```text
age = 29
age_next_year = 29 + 1
age_next_year = 30
```

For the third observation:

```text
age = 41
age_next_year = 41 + 1
age_next_year = 42
```

---

## 8.5 DATALINES Statement

```sas
datalines;
SUBJ001 M 34 68.5
SUBJ002 F 29 59.2
SUBJ003 M 41 82.0
;
```

The `DATALINES` statement provides raw data directly inside the SAS program.

Each row represents one observation.

There are three observations:

```text
SUBJ001
SUBJ002
SUBJ003
```

---

## 8.6 Guided Example Variable Types

| Variable | Type | Explanation |
|---|---|---|
| `subject_id` | Character | It contains a subject identifier |
| `sex` | Character | It contains text |
| `age` | Numeric | It represents a number |
| `weight_kg` | Numeric | It represents a measurement |
| `age_next_year` | Numeric | It is calculated from a numeric variable |

---

## 8.7 Guided Example Expected Output

```text
Obs    subject_id    sex    age    weight_kg    age_next_year

1      SUBJ001       M       34       68.5             35
2      SUBJ002       F       29       59.2             30
3      SUBJ003       M       41       82.0             42
```

---

# 9. Independent Exercise

## 9.1 Exercise Question

Create a SAS dataset for clinical visit information using the following raw data:

```text
PAT001 SCREENING 1 128
PAT002 BASELINE 2 135
PAT003 WEEK4 3 122
```

Complete the following tasks:

1. Create a dataset named `independent_visits`.
2. Read `patient_id` as a character variable.
3. Read `visit_label` as a character variable.
4. Read `visit_num` as a numeric variable.
5. Read `systolic_bp` as a numeric variable.
6. Create a new variable named `next_visit_num`.
7. Calculate `next_visit_num` using:

```text
next_visit_num = visit_num + 1
```

8. Display the dataset using `PROC PRINT`.
9. Check the SAS Log for errors and warnings.
10. Compare the predicted output with the actual output.

---

## 9.2 Independent Exercise Code

```sas
/*======================================================================
  INDEPENDENT EXERCISE
======================================================================*/

data independent_visits;

    /* Read character and numeric variables */
    input patient_id $ visit_label $ visit_num systolic_bp;

    /* Create a derived numeric variable */
    next_visit_num = visit_num + 1;

    datalines;
PAT001 SCREENING 1 128
PAT002 BASELINE 2 135
PAT003 WEEK4 3 122
;
run;

/* Display the independent dataset */
proc print data=independent_visits;
run;
```

---

## 9.3 Independent Exercise Variable Types

```text
patient_id      → Character
visit_label     → Character
visit_num       → Numeric
systolic_bp     → Numeric
next_visit_num  → Numeric
```

Reason:

```sas
input patient_id $ visit_label $ visit_num systolic_bp;
```

The dollar sign appears after `patient_id` and `visit_label`, so SAS reads them as character variables.

The dollar sign does not appear after `visit_num` and `systolic_bp`, so SAS reads them as numeric variables.

The following statement creates a derived numeric variable:

```sas
next_visit_num = visit_num + 1;
```

---

# 10. Output Prediction Practice

Before running the program, predict the values of `next_visit_num`.

| Patient | `visit_num` | Calculation | Predicted `next_visit_num` |
|---|---:|---|---:|
| `PAT001` | 1 | `1 + 1` | 2 |
| `PAT002` | 2 | `2 + 1` | 3 |
| `PAT003` | 3 | `3 + 1` | 4 |

---

## 10.1 Expected Independent Exercise Output

```text
Obs    patient_id    visit_label    visit_num    systolic_bp    next_visit_num

1      PAT001        SCREENING          1             128              2
2      PAT002        BASELINE           2             135              3
3      PAT003        WEEK4              3             122              4
```

---

# 11. Output Validation

The output should contain five variables:

```text
patient_id
visit_label
visit_num
systolic_bp
next_visit_num
```

The output should contain three observations:

```text
PAT001
PAT002
PAT003
```

The calculation should produce:

```text
1 + 1 = 2
2 + 1 = 3
3 + 1 = 4
```

Expected values:

```text
PAT001 → next_visit_num = 2
PAT002 → next_visit_num = 3
PAT003 → next_visit_num = 4
```

---

# 12. Debugging Practice

## 12.1 Incorrect Code

```sas
data debug_visits;

    input patient_id visit_label visit_num systolic_bp;

    datalines;
PAT001 SCREENING 1 128
;
run;
```

---

## 12.2 Problem

The dollar signs are missing from the `INPUT` statement:

```sas
input patient_id visit_label visit_num systolic_bp;
```

Without the dollar signs, SAS attempts to read all four variables as numeric variables.

However, these values contain text:

```text
PAT001
SCREENING
```

Therefore, SAS may report invalid numeric data or may not read the values correctly.

---

## 12.3 Correct Code

```sas
data debug_visits;

    input patient_id $ visit_label $ visit_num systolic_bp;

    datalines;
PAT001 SCREENING 1 128
;
run;
```

---

## 12.4 Professional Debugging Explanation

> The dollar signs are required after `patient_id` and `visit_label` because these variables contain text. Without the dollar signs, SAS may treat them as numeric variables and report invalid numeric data for values such as `PAT001` and `SCREENING`.

---

# 13. SAS Log Checks

After running the complete program, check the SAS Log.

## Expected Checks

The Log should not contain:

```text
ERROR
WARNING
Invalid numeric data
```

The independent dataset should contain:

```text
3 observations
5 variables
```

The five variables are:

```text
patient_id
visit_label
visit_num
systolic_bp
next_visit_num
```

Normal `NOTE` messages about the DATA step and the number of observations are not errors.

For example, a message showing that the dataset has three observations and five variables is a normal informational message.

---

# 14. Validation Checks

## 14.1 Variable Type Validation

Confirm that:

```text
patient_id      is character
visit_label     is character
visit_num       is numeric
systolic_bp     is numeric
next_visit_num  is numeric
```

## 14.2 Observation Validation

Confirm that there are three observations:

```text
PAT001
PAT002
PAT003
```

## 14.3 Calculation Validation

Confirm that:

```text
1 + 1 = 2
2 + 1 = 3
3 + 1 = 4
```

## 14.4 Output Validation

Confirm that the output contains:

```text
patient_id
visit_label
visit_num
systolic_bp
next_visit_num
```

---

# 15. Clinical SAS Relevance

Clinical datasets contain both character and numeric variables.

Examples:

| Clinical Variable | Typical Type | Example |
|---|---|---|
| `USUBJID` | Character | `SUBJ001` |
| `SUBJID` | Character | `001` |
| `SEX` | Character | `M` |
| `VISIT` | Character | `BASELINE` |
| `AGE` | Numeric | `34` |
| `VISITNUM` | Numeric | `1` |
| `AVAL` | Numeric | `68.5` |
| `AVALC` | Character | `NORMAL` |

Correct variable types are important because:

- Subject identifiers and category values contain text.
- Numeric variables must support calculations and comparisons.
- Incorrect variable types can cause invalid data messages.
- Incorrect types can lead to missing values.
- Incorrect types can affect analysis results.
- Clinical data validation depends on reading variables correctly.

---

# 16. Clinical Programming Example

Suppose a raw clinical dataset contains:

```text
SUBJ001 BASELINE 1 68.5
```

The values may be interpreted as:

```text
USUBJID
VISIT
VISITNUM
AVAL
```

A programmer could read the values using:

```sas
input usubjid $ visit $ visitnum aval;
```

This tells SAS:

```text
usubjid  → Character
visit    → Character
visitnum → Numeric
aval     → Numeric
```

Correct variable types are important when preparing clinical datasets for validation, reporting, and analysis.

---

# 17. Interview Practice

## Question 1: What is the difference between numeric and character variables in SAS?

### Professional Answer

A numeric variable stores numbers and can be used in arithmetic calculations. A character variable stores text, identifiers, labels, or category values. In a SAS `INPUT` statement, the dollar sign identifies a character variable.

---

## Question 2: Why is the dollar sign used in the INPUT statement?

### Professional Answer

The dollar sign tells SAS to read a variable as character. For example, `subject_id $` tells SAS that `subject_id` contains text or an identifier rather than a numeric value.

---

## Question 3: Which variables are character variables in the following statement?

```sas
input patient_id $ visit_label $ visit_num systolic_bp;
```

### Answer

The character variables are:

```text
patient_id
visit_label
```

They are character variables because they have the dollar sign.

---

## Question 4: Which variables are numeric variables in the same statement?

### Answer

The numeric variables are:

```text
visit_num
systolic_bp
```

They are numeric variables because they do not have the dollar sign.

---

## Question 5: What is a derived variable?

### Professional Answer

A derived variable is a new variable created from one or more existing variables using a calculation or logical expression. For example, `next_visit_num = visit_num + 1` creates a derived numeric variable.

---

## Question 6: What is the value of `next_visit_num` when `visit_num` is 3?

### Answer

```text
next_visit_num = visit_num + 1
next_visit_num = 3 + 1
next_visit_num = 4
```

---

## Question 7: What problem can occur if the dollar sign is missing?

### Professional Answer

If the dollar sign is missing, SAS may interpret a character variable as numeric. This can cause invalid numeric data messages in the SAS Log and may lead to incorrect or missing values.

---

# 18. Certification-Style Practice

## Question 1

In the following statement, which variable is character?

```sas
input subject_id $ age weight_kg;
```

A. `subject_id`  
B. `age`  
C. `weight_kg`  
D. All three variables

### Correct Answer

```text
A. subject_id
```

Reason:

```text
subject_id has the dollar sign.
```

---

## Question 2

Which statement correctly reads one character variable and two numeric variables?

A.

```sas
input subject_id age weight;
```

B.

```sas
input subject_id $ age weight;
```

C.

```sas
input subject_id age $ weight $;
```

D.

```sas
input subject_id $ age $ weight;
```

### Correct Answer

```text
B. input subject_id $ age weight;
```

Reason:

```text
subject_id → Character
age        → Numeric
weight     → Numeric
```

---

## Question 3

What is the output of this code?

```sas
age = 29;
age_next_year = age + 1;
```

### Correct Answer

```text
age = 29
age_next_year = 30
```

---

## Question 4

How many variables are created by this code?

```sas
data example;
    input subject_id $ age weight;
    age_next_year = age + 1;
    datalines;
SUBJ001 34 68.5
;
run;
```

### Correct Answer

There are four variables:

```text
subject_id
age
weight
age_next_year
```

---

## Question 5

Which variable is derived in the following statement?

```sas
next_visit_num = visit_num + 1;
```

### Correct Answer

```text
next_visit_num
```

Reason:

```text
It is newly created using the existing variable visit_num.
```

---

# 19. English Practice

## 19.1 Simple Program Explanation

> In this program, `patient_id` and `visit_label` are character variables because they contain text. `visit_num` and `systolic_bp` are numeric variables because they contain numbers. I created `next_visit_num` by adding 1 to `visit_num`.

---

## 19.2 Guided Example Explanation

> In the guided example, `subject_id` and `sex` are character variables. `age` and `weight_kg` are numeric variables. The dollar sign is used after the character variables in the `INPUT` statement. I created `age_next_year` by adding 1 to the numeric variable `age`.

---

## 19.3 Output-Prediction Explanation

> First, I identify the variable type. `visit_num` is numeric, so SAS can perform an addition. For `PAT002`, the value of `visit_num` is 2. Therefore, `next_visit_num` is 2 plus 1, which gives 3. In the output, I expect `next_visit_num` to be 3 for `PAT002`.

---

## 19.4 Debugging Explanation

> The dollar signs are required after `patient_id` and `visit_label` because these variables contain text. Without the dollar signs, SAS may treat them as numeric variables and report invalid numeric data.

---

## 19.5 Clinical SAS Explanation

> In clinical data, subject identifiers and visit labels are usually character variables, while variables such as age, visit number, and laboratory results are usually numeric variables. Correctly identifying the variable type helps prevent data-reading and analysis errors.

---

## 19.6 Speaking Practice Format

Use this structure when explaining a SAS program:

```text
First, I identify the variable type.

The reason is that the variable contains either text or a number.

In the output, I check whether SAS read the value correctly.

This helps because correct variable types are important for validation and analysis.
```

---

## 19.7 Thirty-Second Interview Answer

> Numeric variables store numbers and can be used in calculations. Character variables store text, identifiers, and labels. In the SAS `INPUT` statement, I use the dollar sign to identify character variables. For example, `patient_id` and `visit_label` are character variables, while `visit_num` and `systolic_bp` are numeric variables.

---

# 20. Lesson Summary

In this lesson, I learned that:

- Character variables store text, identifiers, labels, and category values.
- Numeric variables store numbers and support calculations.
- The dollar sign (`$`) identifies a character variable in the `INPUT` statement.
- Numeric variables do not require the dollar sign.
- The order of variables in the `INPUT` statement must match the order of values in the raw data.
- A variable created through a calculation is called a derived variable.
- `age_next_year = age + 1` creates a derived numeric variable.
- `next_visit_num = visit_num + 1` creates a derived numeric variable.
- The SAS Log should be checked for errors, warnings, and invalid numeric data.
- The independent dataset contains three observations and five variables.
- Correct variable types are important in Clinical SAS programming.
- Clear English explanations are important for technical interviews.

---

# 21. Files Used

```text
04_numeric_and_character_variables.md
04_numeric_and_character_variables.sas
```

The SAS file contains:

- Guided example
- Numeric and character variable practice
- Derived variable practice
- Independent exercise
- Output prediction practice
- `PROC PRINT` output checking

---

# 22. Suggested GitHub Commit Messages

For the Markdown documentation file:

```text
Add numeric and character variables documentation
```

For the SAS practice code file:

```text
Add numeric and character variables practice code
```
