# Lesson 6: SAS Libraries and the WORK Library

## Lesson Objective

In this lesson, I learned how to:

- Explain what a SAS library is.
- Explain the purpose of the temporary `WORK` library.
- Create datasets in the `WORK` library.
- Use one-level and two-level dataset names.
- Use `PROC CONTENTS` to check dataset metadata.
- Use `PROC PRINT` to display observations.
- Define character-variable lengths using the `LENGTH` statement.
- Identify and prevent character-variable truncation.
- Review the SAS Log for errors, warnings, and notes.
- Explain the relevance of SAS libraries in Clinical SAS programming.

## 1. SAS Libraries

A SAS library is a location where SAS datasets and other SAS files are stored.

A dataset can be referenced using a two-level name:

```text
library.dataset
```

Example:

```sas
work.visits
```

In this example:

- `WORK` is the library name.
- `VISITS` is the dataset name.

The two-level name `WORK.VISITS` clearly identifies the `VISITS` dataset in the `WORK` library.

## 2. The WORK Library

`WORK` is a temporary SAS library that is automatically available during a SAS session.

Datasets stored in the `WORK` library:

- Are available during the current SAS session.
- Are useful for practice, testing, and intermediate processing.
- Are normally deleted when the SAS session ends.
- Should not be used for important permanent final outputs.

Example:

```sas
data work.visits;
    /* DATA step code */
run;
```

The complete dataset name is:

```text
WORK.VISITS
```

## 3. One-Level and Two-Level Dataset Names

A one-level dataset name contains only the dataset name:

```sas
visits
```

A two-level dataset name contains the library name and dataset name:

```sas
work.visits
```

The two-level name is clearer because it shows exactly where the dataset is stored.

Example:

```sas
proc print data=work.visits;
run;
```

For temporary datasets, SAS can often interpret the one-level name `visits` as `work.visits`. However, using the two-level name is a good programming practice.

## 4. Character Variable Length

Character variables should have an appropriate length before the data is read.

Example:

```sas
length subjid $4 visit_date $10;
```

This means:

- `SUBJID` is a character variable with a length of 4.
- `VISIT_DATE` is a character variable with a length of 10.

The value below contains 10 characters:

```text
2026-10-01
```

Character count:

```text
2 0 2 6 - 1 0 - 0 1
1 2 3 4 5 6 7 8 9 10
```

Therefore, `VISIT_DATE` needs a length of at least 10 to store the complete value.

## 5. Character Truncation

If a character variable does not have an appropriate length, the value can be truncated.

Problem code:

```sas
data work.visits;
    input subjid $ visit_num visit_date $;

    datalines;
S001 1 2026-10-01
S001 2 2026-10-15
S002 1 2026-10-03
;
run;
```

If SAS assigns `VISIT_DATE` a length of 8, the value:

```text
2026-10-01
```

may be stored as:

```text
2026-10-
```

The final two characters are lost.

This is a data-quality problem.

The issue can be prevented by defining the character length before the `INPUT` statement:

```sas
length visit_date $10;
```

## 6. LENGTH Statement and INPUT Informat

The following statements have different purposes.

### LENGTH Statement

```sas
length visit_date $10;
```

This defines the storage length of the variable.

In simple terms:

> It tells SAS how much character space to keep for storing the value.

### INPUT Informat

```sas
input visit_date :$10.;
```

This tells SAS how to read the value from the input line.

In simple terms:

> It tells SAS to read the value as character data using a width of 10.

The parts of `:$10.` are:

```text
:       $       10       .
colon   character width  end of informat
```

- `:` tells SAS to use the informat.
- `$` indicates character data.
- `10` is the reading width.
- `.` marks the end of the informat.

For this lesson, the following `LENGTH` statement is used:

```sas
length subjid $4 visit_date $10;
```

The period is not used after `4` or `10` in a `LENGTH` statement.

## 7. Guided Exercise

The following program creates a `VISITS` dataset in the temporary `WORK` library.

```sas
data work.visits;
    length subjid $4 visit_date $10;
    input subjid $ visit_num visit_date $;

    datalines;
S001 1 2026-10-01
S001 2 2026-10-15
S002 1 2026-10-03
;
run;

proc contents data=work.visits;
run;

proc print data=work.visits;
run;
```

### Guided Exercise Explanation

```sas
data work.visits;
```

Creates the `VISITS` dataset in the `WORK` library.

```sas
length subjid $4 visit_date $10;
```

Defines the character lengths of `SUBJID` and `VISIT_DATE`.

```sas
input subjid $ visit_num visit_date $;
```

Reads the variables from the raw data.

- `SUBJID` is character.
- `VISIT_NUM` is numeric.
- `VISIT_DATE` is character.

```sas
datalines;
```

Indicates that the raw data will follow.

```sas
S001 1 2026-10-01
S001 2 2026-10-15
S002 1 2026-10-03
```

These three rows become three observations.

```sas
;
run;
```

Ends the `DATALINES` section and completes the DATA step.

```sas
proc contents data=work.visits;
run;
```

Displays metadata about `WORK.VISITS`.

```sas
proc print data=work.visits;
run;
```

Displays the observations in the dataset.

### Expected Guided Exercise Structure

| Variable | Type | Length |
|---|---|---:|
| `SUBJID` | Character | 4 |
| `VISIT_NUM` | Numeric | 8 bytes |
| `VISIT_DATE` | Character | 10 |

### Expected Guided Exercise Output

| Obs | SUBJID | VISIT_NUM | VISIT_DATE |
|---:|---|---:|---|
| 1 | S001 | 1 | 2026-10-01 |
| 2 | S001 | 2 | 2026-10-15 |
| 3 | S002 | 1 | 2026-10-03 |

## 8. Independent Exercise

The independent exercise creates a `LAB_RESULTS` dataset in the temporary `WORK` library.

### Requirements

The dataset should contain the following variables:

| Variable | Type |
|---|---|
| `SUBJID` | Character |
| `TESTCD` | Character |
| `RESULT` | Numeric |
| `VISIT_NUM` | Numeric |

### Independent Exercise Code

```sas
data work.lab_results;
    length subjid $4 testcd $3;
    input subjid $ testcd $ result visit_num;

    datalines;
S001 HGB 13.5 1
S001 ALT 22.0 1
S002 HGB 11.8 1
S002 ALT 30.5 1
;
run;

proc contents data=work.lab_results;
run;

proc print data=work.lab_results;
run;
```

### Independent Exercise Explanation

```sas
data work.lab_results;
```

Creates the dataset `LAB_RESULTS` in the `WORK` library.

```sas
length subjid $4 testcd $3;
```

Defines:

- `SUBJID` as a character variable with length 4.
- `TESTCD` as a character variable with length 3.

```sas
input subjid $ testcd $ result visit_num;
```

Defines:

- `SUBJID` as character.
- `TESTCD` as character.
- `RESULT` as numeric.
- `VISIT_NUM` as numeric.

There are four rows of raw data, so the dataset should contain four observations.

### Expected Independent Exercise Output

| Obs | SUBJID | TESTCD | RESULT | VISIT_NUM |
|---:|---|---|---:|---:|
| 1 | S001 | HGB | 13.5 | 1 |
| 2 | S001 | ALT | 22.0 | 1 |
| 3 | S002 | HGB | 11.8 | 1 |
| 4 | S002 | ALT | 30.5 | 1 |

### Expected Independent Exercise Structure

| Variable | Type | Length |
|---|---|---:|
| `SUBJID` | Character | 4 |
| `TESTCD` | Character | 3 |
| `RESULT` | Numeric | 8 bytes |
| `VISIT_NUM` | Numeric | 8 bytes |

## 9. SAS Log Check

After running the complete SAS program, I checked the SAS Log.

The following checks are important:

- There are no errors.
- There are no warnings.
- The `WORK.VISITS` dataset is created successfully.
- The `WORK.LAB_RESULTS` dataset is created successfully.
- `PROC CONTENTS` runs successfully.
- `PROC PRINT` runs successfully.
- There are no invalid numeric data messages.
- There are no truncated character values.

The expected note for the independent exercise is similar to:

```text
NOTE: The data set WORK.LAB_RESULTS has 4 observations and 4 variables.
```

This confirms that:

- The dataset was created.
- The dataset contains 4 observations.
- The dataset contains 4 variables.

## 10. Output Prediction Practice

Before running the program, I predicted the following results:

1. `WORK.VISITS` contains 3 observations.
2. `WORK.VISITS` contains 3 variables.
3. `SUBJID` is a character variable.
4. `VISIT_NUM` is a numeric variable.
5. `VISIT_DATE` is a character variable in this lesson.
6. `VISIT_DATE` has a length of 10 after using the `LENGTH` statement.
7. `WORK.VISITS` means the `VISITS` dataset in the `WORK` library.
8. Datasets in the `WORK` library are normally deleted when the SAS session ends.

## 11. Debugging Practice

### Problem

The following code does not explicitly define the length of `VISIT_DATE`:

```sas
data work.visits;
    input subjid $ visit_num visit_date $;

    datalines;
S001 1 2026-10-01
S001 2 2026-10-15
S002 1 2026-10-03
;
run;
```

The value `2026-10-01` contains 10 characters. If the variable receives a length of only 8, the value can be truncated.

### Correction

```sas
data work.visits;
    length subjid $4 visit_date $10;
    input subjid $ visit_num visit_date $;

    datalines;
S001 1 2026-10-01
S001 2 2026-10-15
S002 1 2026-10-03
;
run;
```

The `LENGTH` statement is placed before the `INPUT` statement so that SAS knows the intended character length before reading the data.

## 12. Clinical SAS Relevance

SAS libraries are important in Clinical SAS programming because clinical data is usually organized into different stages.

Examples include:

- Raw data.
- SDTM datasets.
- ADaM datasets.
- TLF datasets.
- QC datasets.
- Analysis outputs.

Possible library names include:

```text
RAW
SDTM
ADAM
TLF
QC
OUTPUT
```

A typical clinical programming workflow is:

```text
RAW data
    |
    v
SDTM datasets
    |
    v
ADaM datasets
    |
    v
TLF outputs
```

The `WORK` library is useful for:

- Temporary intermediate datasets.
- Testing transformation logic.
- Debugging programs.
- Checking variables.
- Validating results before creating final datasets.

Important final clinical datasets should normally be stored in permanent libraries rather than only in `WORK`.

## 13. Data Quality and Validation Points

Before using a dataset, I should check:

- The library name.
- The dataset name.
- The number of observations.
- The number of variables.
- Variable names.
- Variable types.
- Variable lengths.
- Missing values.
- Character truncation.
- Unexpected numeric values.
- SAS Log messages.
- Whether the dataset is temporary or permanent.

Incorrect character lengths can affect:

- Subject identifiers.
- Test codes.
- Visit descriptions.
- Treatment names.
- Parameter descriptions.
- Clinical domain variables.
- Tables and listings.

A truncated value can cause a data-quality problem even when the SAS program does not produce an error.

## 14. Interview Practice

### Question 1: What is a SAS library?

A SAS library is a location where SAS datasets and related SAS files are stored. A dataset can be referenced by using a two-level name containing the library name and dataset name.

### Question 2: What is the WORK library?

The `WORK` library is a temporary SAS library that is automatically available during a SAS session. Datasets stored in `WORK` are normally deleted when the session ends.

### Question 3: What is the difference between a one-level and a two-level dataset name?

A one-level dataset name contains only the dataset name, such as `VISITS`. A two-level dataset name contains the library name and dataset name, such as `WORK.VISITS`. The two-level name is more explicit.

### Question 4: Why was `VISIT_DATE` truncated?

`VISIT_DATE` was truncated because SAS assigned an insufficient character length when no explicit length was defined. The date value contains 10 characters, so I defined `VISIT_DATE` with a length of 10 before the `INPUT` statement.

### Question 5: What is the purpose of the `LENGTH` statement?

The `LENGTH` statement defines the storage length of variables. For character variables, it specifies the maximum number of characters that can be stored.

### Question 6: What does the dollar sign mean in an `INPUT` statement?

The dollar sign identifies a character variable in the `INPUT` statement.

### Question 7: What does `PROC CONTENTS` do?

`PROC CONTENTS` displays metadata about a SAS dataset, including the number of observations, number of variables, variable names, variable types, and variable lengths.

## 15. Certification-Style Questions

### Question 1

Which library is temporary by default?

- A. `WORK`
- B. `RAW`
- C. `SDTM`
- D. `ADAM`

**Correct answer:** A. `WORK`

### Question 2

Which statement creates a dataset in the `WORK` library?

- A. `data visits;`
- B. `data work.visits;`
- C. `proc work.visits;`
- D. `create work.visits;`

**Correct answer:** B. `data work.visits;`

### Question 3

What does `$` indicate in an `INPUT` statement?

- A. Date variable
- B. Numeric variable
- C. Character variable
- D. Temporary variable

**Correct answer:** C. Character variable

### Question 4

What is the purpose of the following code?

```sas
proc contents data=work.visits;
run;
```

**Correct answer:** It displays metadata about the `WORK.VISITS` dataset.

### Question 5

Which statement correctly defines the character lengths?

- A. `length subjid $4. visit_date $10.;`
- B. `length subjid $4 visit_date $10;`
- C. `length subjid 4 visit_date 10;`
- D. `length $subjid 4 $visit_date 10;`

**Correct answer:** B. `length subjid $4 visit_date $10;`

### Question 6

Which statement uses a character informat with a width of 10?

- A. `input visit_date $10;`
- B. `input visit_date :$10.;`
- C. `input visit_date 10;`
- D. `input visit_date $10;`

**Correct answer:** B. `input visit_date :$10.;`

## 16. English Practice

### Short Explanation

> I created a temporary dataset called `WORK.VISITS`. I used the `LENGTH` statement to define the character lengths of `SUBJID` and `VISIT_DATE`. I used `PROC CONTENTS` to check the dataset metadata and `PROC PRINT` to display the observations.

### Truncation Explanation

> The `VISIT_DATE` value was truncated because its character length defaulted to 8. Since the date contains 10 characters, I defined the variable length as 10 before the `INPUT` statement.

### Debugging Explanation

> First, I would check the SAS Log for errors and warnings. Then, I would use `PROC CONTENTS` to check the variable type and length. If a character variable was truncated, I would define the correct length before the `INPUT` statement and rerun the program.

## 17. Lesson Summary

In this lesson, I learned that:

- A SAS library is a location where SAS datasets are stored.
- `WORK` is a temporary SAS library.
- Datasets in `WORK` are normally deleted when the SAS session ends.
- A two-level dataset name includes the library and dataset name.
- `WORK.VISITS` means the `VISITS` dataset in the `WORK` library.
- `PROC CONTENTS` displays dataset metadata.
- `PROC PRINT` displays observations.
- `$` identifies character variables.
- The `LENGTH` statement defines character storage length.
- An insufficient character length can cause truncation.
- `VISIT_DATE` requires a length of 10 to store `2026-10-01`.
- `:$10.` is a character informat with a reading width of 10.
- SAS Log review is an important part of debugging and validation.
- Library organization is important in Clinical SAS programming.

## 18. Files and GitHub Information

### SAS Code File

```text
06_libraries_and_work_library.sas
```

### Markdown Documentation File

```text
06_libraries_and_work_library.md
```

### Folder Path

```text
base_sas/01_language_basics/
```

### SAS Code Commit Message

```text
Add SAS libraries and WORK library lesson
```

### Markdown Documentation Commit Message

```text
Add SAS libraries and WORK library documentation
```
