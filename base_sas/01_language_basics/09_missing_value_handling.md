# Lesson 09: MISSING VALUE HANDLING

## Lesson Overview

This lesson explains how to identify and handle missing values in a SAS DATA step.

In this lesson, I learned how to:

- Identify missing numeric values using a period (`.`).
- Understand the meaning of missing values in SAS.
- Use the `MISSING()` function.
- Create status variables for missing and non-missing values.
- Use `IF-THEN-ELSE` logic.
- Define character variables using the `LENGTH` statement.
- Apply a character format using `$8.`.
- Apply labels using the `LABEL` statement.
- Display the final dataset using `PROC PRINT`.
- Review the SAS Log.
- Validate the output dataset.

## Learning Objectives

After completing this lesson, I should be able to:

- Explain what a missing value means in SAS.
- Identify missing numeric values.
- Use the `MISSING()` function correctly.
- Create `"Missing"` and `"Present"` status values.
- Read character and numeric variables correctly.
- Use the `LENGTH` statement for character variables.
- Use the `FORMAT` statement correctly.
- Use the `LABEL` statement.
- Interpret the final output.
- Check the SAS Log for errors and warnings.
- Explain the importance of missing value handling in clinical programming.

## Concept Explanation

A missing numeric value in SAS is represented by a period:

```sas
.
```

For example:

```sas
age = .;
```

A missing value means that the data is unavailable, not collected, or not applicable.

A missing value should not automatically be treated as zero.

For example:

- Missing age does not mean age is zero.
- Missing height does not mean height is zero.
- Missing weight does not mean weight is zero.

## Types of Missing Values

### Numeric Missing Value

A missing numeric value is represented by a period:

```sas
.
```

Example:

```text
P002 . 170 72
```

In this example, the age value is missing.

### Character Missing Value

A missing character value is usually represented by a blank value.

Example:

```sas
patient_name = " ";
```

This lesson focuses mainly on standard numeric missing values.

## The MISSING Function

The `MISSING()` function checks whether a variable contains a missing value.

### Syntax

```sas
missing(variable_name)
```

The function returns:

- `1` when the value is missing.
- `0` when the value is not missing.

### Example

```sas
if missing(age) then age_status = "Missing";
else age_status = "Present";
```

This logic means:

- If `age` is missing, assign `"Missing"`.
- If `age` is available, assign `"Present"`.

## Patient Data Used in This Lesson

| Patient ID | Age | Height | Weight |
|---|---:|---:|---:|
| P001 | 25 | 165 | 60 |
| P002 | Missing | 170 | 72 |
| P003 | 34 | Missing | 68 |
| P004 | 29 | 158 | Missing |
| P005 | Missing | Missing | 80 |

## SAS Program

```sas
data patient_data;

    input patient_id $ age height weight;

    length age_status height_status weight_status $8.;

    if missing(age) then age_status = "Missing";
    else age_status = "Present";

    if missing(height) then height_status = "Missing";
    else height_status = "Present";

    if missing(weight) then weight_status = "Missing";
    else weight_status = "Present";

    format age_status height_status weight_status $8.;

    label
        age_status    = "Age Status"
        height_status = "Height Status"
        weight_status = "Weight Status"
    ;

    datalines;
P001 25 165 60
P002 .  170 72
P003 34 .  68
P004 29 158 .
P005 .  .  80
;

run;

proc print data=patient_data label;

    var patient_id age height weight
        age_status height_status weight_status;

run;
```

## Program Explanation

### DATA Statement

```sas
data patient_data;
```

This creates a SAS dataset named `patient_data`.

The dataset is stored temporarily in the `WORK` library unless another library is specified.

### INPUT Statement

```sas
input patient_id $ age height weight;
```

This statement reads the raw data.

- `patient_id` is a character variable.
- `$` identifies `patient_id` as a character variable.
- `age`, `height`, and `weight` are numeric variables.

### LENGTH Statement

```sas
length age_status height_status weight_status $8.;
```

This defines the storage length of the three character variables.

The variables can store up to eight characters.

The longest value used in this exercise is `"Missing"`, which contains seven characters.

### Age Missing Value Check

```sas
if missing(age) then age_status = "Missing";
else age_status = "Present";
```

This checks whether the `age` variable contains a missing value.

If the value is missing:

```sas
age_status = "Missing";
```

If the value is available:

```sas
age_status = "Present";
```

### Height Missing Value Check

```sas
if missing(height) then height_status = "Missing";
else height_status = "Present";
```

This checks whether the `height` variable is missing.

### Weight Missing Value Check

```sas
if missing(weight) then weight_status = "Missing";
else weight_status = "Present";
```

This checks whether the `weight` variable is missing.

## FORMAT Statement

```sas
format age_status height_status weight_status $8.;
```

The `FORMAT` statement controls how the character values are displayed.

### Meaning of `$8.`

| Part | Meaning |
|---|---|
| `$` | Character format |
| `8` | Display width of eight characters |
| `.` | End of the format specification |

The format changes the display only. It does not change the original data values.

## LABEL Statement

```sas
label
    age_status    = "Age Status"
    height_status = "Height Status"
    weight_status = "Weight Status"
;
```

The `LABEL` statement gives readable descriptions to the variables.

The labels are displayed because the `LABEL` option is used in `PROC PRINT`.

## PROC PRINT Statement

```sas
proc print data=patient_data label;
```

This displays the contents of the `patient_data` dataset.

The `LABEL` option displays variable labels in the output.

### VAR Statement

```sas
var patient_id age height weight
    age_status height_status weight_status;
```

The `VAR` statement controls which variables are displayed and their order.

## Expected Output

| Patient ID | Age | Height | Weight | Age Status | Height Status | Weight Status |
|---|---:|---:|---:|---|---|---|
| P001 | 25 | 165 | 60 | Present | Present | Present |
| P002 | . | 170 | 72 | Missing | Present | Present |
| P003 | 34 | . | 68 | Present | Missing | Present |
| P004 | 29 | 158 | . | Present | Present | Missing |
| P005 | . | . | 80 | Missing | Missing | Present |

## Output Interpretation

### Patient P001

- Age is present.
- Height is present.
- Weight is present.
- All status values are `"Present"`.

### Patient P002

- Age is missing.
- Height is present.
- Weight is present.
- `age_status` is `"Missing"`.
- `height_status` is `"Present"`.
- `weight_status` is `"Present"`.

### Patient P003

- Age is present.
- Height is missing.
- Weight is present.
- `age_status` is `"Present"`.
- `height_status` is `"Missing"`.
- `weight_status` is `"Present"`.

### Patient P004

- Age is present.
- Height is present.
- Weight is missing.
- `age_status` is `"Present"`.
- `height_status` is `"Present"`.
- `weight_status` is `"Missing"`.

### Patient P005

- Age is missing.
- Height is missing.
- Weight is present.
- `age_status` is `"Missing"`.
- `height_status` is `"Missing"`.
- `weight_status` is `"Present"`.

## Difference Between Missing Values and Status Values

The original variables contain the actual data values:

```text
age = .
height = .
weight = .
```

The status variables describe whether the original values are available:

```text
age_status = "Missing"
height_status = "Missing"
weight_status = "Missing"
```

The status variables do not replace the original variables.

They provide an additional way to identify missing data.

## Difference Between FORMAT and LENGTH

The `FORMAT` statement controls the display of a variable:

```sas
format age_status $8.;
```

The `LENGTH` statement controls the storage length of a character variable:

```sas
length age_status $8.;
```

### FORMAT

- Controls how values appear in the output.
- Does not change the stored value.

### LENGTH

- Defines the storage length of a character variable.
- Should be defined before assigning values to the variable.

## Clinical Relevance

Missing value handling is important in clinical SAS programming because missing data can affect:

- Patient eligibility.
- Safety analysis.
- Efficacy analysis.
- Laboratory summaries.
- Tables, Listings, and Figures.
- Analysis datasets.
- Data quality checks.
- Visit-level summaries.
- Subject-level analysis.

Missing data may occur when:

- A patient did not attend a visit.
- A measurement was not collected.
- A test was not performed.
- A value was not applicable.
- Data entry was incomplete.
- The value was unavailable in the source system.

Clinical SAS programmers must identify missing values accurately and handle them according to the study requirements.

## Common Mistakes

### Mistake 1: Treating Missing as Zero

A missing value is not automatically zero.

Incorrect assumption:

```text
Missing weight = 0
```

Correct understanding:

```text
Missing weight = Weight value is unavailable
```

### Mistake 2: Forgetting the Dollar Sign

Correct:

```sas
input patient_id $;
```

The dollar sign identifies `patient_id` as a character variable.

### Mistake 3: Using a Numeric Format for a Character Variable

Incorrect:

```sas
format age_status 8.;
```

Correct:

```sas
format age_status $8.;
```

The `$` is required because `age_status` is a character variable.

### Mistake 4: Confusing FORMAT and LENGTH

```sas
format age_status $8.;
```

controls display.

```sas
length age_status $8.;
```

controls storage length.

### Mistake 5: Placing SAS Statements After DATALINES

Statements such as `IF`, `FORMAT`, and `LABEL` should be placed before the `DATALINES` statement.

Correct order:

```sas
if ...;
format ...;
label ...;

datalines;
raw data
;
```

## Independent Exercise Requirements

The independent exercise must include:

- A `patient_data` dataset.
- Patient ID, age, height, and weight variables.
- Data entered using `DATALINES`.
- An `age_status` variable.
- A `height_status` variable.
- A `weight_status` variable.
- Missing value checks using `MISSING()`.
- `"Missing"` and `"Present"` status values.
- Character variable definitions using `LENGTH`.
- A `$8.` character format.
- Variable labels.
- A `PROC PRINT` output.
- Expected output recorded before running the program.
- Actual output compared with the expected output.
- SAS Log reviewed for errors and warnings.

## SAS Log Review

The SAS Log confirmed that five observations were read from the dataset:

```text
NOTE: There were 5 observations read from the data set WORK.PATIENT_DATA.
```

This confirms that:

- The dataset was created successfully.
- Five observations were available.
- `PROC PRINT` successfully read the dataset.
- The output was generated successfully.
- No errors were reported.

## Verification Result

The program successfully created the following dataset:

```text
WORK.PATIENT_DATA
```

The program created five observations.

The output matched the expected result:

- P001: All values present.
- P002: Age missing.
- P003: Height missing.
- P004: Weight missing.
- P005: Age and height missing.

## Interview Questions

### What is a missing numeric value in SAS?

A missing numeric value is represented by a period:

```sas
.
```

### Which function checks whether a value is missing?

```sas
missing()
```

### What does the MISSING function return?

The `MISSING()` function returns:

- `1` when the value is missing.
- `0` when the value is not missing.

### What is the purpose of the dollar sign in the INPUT statement?

The dollar sign identifies a variable as a character variable.

Example:

```sas
input patient_id $;
```

### What is the purpose of `$8.`?

`$8.` specifies a character format with a display width of eight characters.

### Does the FORMAT statement change the stored value?

No. The `FORMAT` statement changes only how the value appears in the output.

### What is the difference between FORMAT and LENGTH?

`FORMAT` controls the display of a variable.

`LENGTH` controls the storage length of a character variable.

### Why is missing value handling important in clinical programming?

Missing values can affect calculations, analysis populations, safety analysis, efficacy analysis, and clinical reports.

### What is the difference between a missing value and zero?

A missing value means that the data is unavailable or not collected.

Zero is an actual numeric value.

### Why are status variables useful?

Status variables make it easier to identify whether important source variables contain available or missing data.

## Certification Practice

1. Identify the symbol used for a standard missing numeric value in SAS.
2. Explain the purpose of the `MISSING()` function.
3. Explain the meaning of `$8.`.
4. Explain why the `$` symbol is used with `patient_id`.
5. Explain the difference between a missing value and zero.
6. Explain the difference between `FORMAT` and `LENGTH`.
7. Explain why `DATALINES` should appear after SAS statements.
8. Explain the purpose of the `LABEL` statement.
9. Explain the purpose of the `VAR` statement.
10. Explain why missing values should be handled before performing calculations.

## English Practice

### Useful Sentences

- I used the `MISSING()` function to identify missing values.
- I created status variables for age, height, and weight.
- The status variables contain either `"Missing"` or `"Present"`.
- The `$8.` format displays character values with a width of eight characters.
- The `FORMAT` statement changes the display, not the stored value.
- The `LENGTH` statement defines the storage length of a character variable.
- I reviewed the SAS Log for errors and warnings.
- The output matched the expected result.
- The dataset contains five observations.
- Missing values should not automatically be treated as zero.

### Short Interview Answer

> Missing value handling is important in SAS because unavailable data can affect calculations and clinical analysis. I used the `MISSING()` function to identify missing values and created status variables containing `"Missing"` or `"Present"`. I also reviewed the output and SAS Log to verify that the logic worked correctly.

## Completion Checklist

- [x] Dataset created.
- [x] Patient ID read as a character variable.
- [x] Age read as a numeric variable.
- [x] Height read as a numeric variable.
- [x] Weight read as a numeric variable.
- [x] Missing age values checked.
- [x] Missing height values checked.
- [x] Missing weight values checked.
- [x] Status variables created.
- [x] `"Missing"` and `"Present"` values assigned.
- [x] `MISSING()` function used.
- [x] `LENGTH` statement used.
- [x] `$8.` format applied.
- [x] `LABEL` statement used.
- [x] Final dataset printed.
- [x] Expected output compared with actual output.
- [x] SAS Log reviewed.
- [x] No errors reported.
- [x] Output verified.

## GitHub Commit Message

```text
Add missing value handling lesson and SAS practice
```

## Summary

Missing value handling helps identify unavailable data in a SAS dataset.

Important points:

- A missing numeric value is represented by a period.
- The `MISSING()` function checks whether a value is missing.
- Status variables can describe missing and non-missing values.
- The `LENGTH` statement controls character variable storage length.
- The `FORMAT` statement controls display.
- `$8.` is a character format with a display width of eight.
- The `LABEL` statement provides readable variable descriptions.
- Missing values should not automatically be treated as zero.
- Missing value handling is important in clinical data analysis.
- The completed program successfully generated five observations without errors.
