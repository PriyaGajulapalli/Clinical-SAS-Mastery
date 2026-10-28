# Lesson 08: WHERE, KEEP, DROP, and RENAME

## Lesson Overview

This lesson explains how to use the `WHERE`, `KEEP`, `DROP`, and `RENAME` statements in a SAS DATA step.

In this lesson, I learned how to:

- Filter observations using the `WHERE` statement.
- Keep selected variables using the `KEEP` statement.
- Remove unwanted variables using the `DROP` statement.
- Change a variable name using the `RENAME` statement.
- Understand the difference between observations and variables.
- Combine these statements in one DATA step.
- Predict the structure of an output dataset.
- Review the SAS log.
- Validate the output dataset.

## Learning Objectives

After completing this lesson, I should be able to:

1. Explain the purpose of the `WHERE` statement.
2. Explain how the `KEEP` statement controls output variables.
3. Explain how the `DROP` statement removes variables.
4. Explain how the `RENAME` statement changes a variable name.
5. Identify whether a statement affects observations or variables.
6. Predict the observations and variables in an output dataset.
7. Review the SAS log for errors and warnings.
8. Validate the output dataset structure.
9. Explain these statements using professional SAS terminology.

## Important SAS Terminology

| Term | Meaning |
|---|---|
| Observation | A row in a SAS dataset |
| Variable | A column in a SAS dataset |
| Input dataset | The dataset being read |
| Output dataset | The dataset being created |
| Filter | A condition used to select observations |
| DATA step | A SAS programming step used to create or modify datasets |

## Key Concepts

- `WHERE` filters observations, or rows.
- `KEEP` retains selected variables, or columns.
- `DROP` removes unwanted variables, or columns.
- `RENAME` changes a variable name without changing its values.

## WHERE Statement

### Definition

The `WHERE` statement selects observations that satisfy a specified condition.

### Syntax

    where condition;

### Example

    data work.adult_subjects;
        set work.patient_data;
        where age >= 18;
    run;

### Explanation

- The `SET` statement reads the input dataset.
- The `WHERE` statement checks the value of `AGE`.
- Only observations where `AGE` is greater than or equal to 18 are selected.
- The `WHERE` statement filters observations, not variables.

## KEEP Statement

### Definition

The `KEEP` statement specifies the variables that should remain in the output dataset.

### Syntax

    keep variable-1 variable-2 variable-3;

### Example

    data work.patient_basic;
        set work.patient_data;
        keep subject_id age sex;
    run;

### Explanation

- The output dataset contains `SUBJECT_ID`, `AGE`, and `SEX`.
- Other variables are not included in the output dataset.
- The `KEEP` statement controls variables, or columns.
- The `KEEP` statement does not remove observations.

## DROP Statement

### Definition

The `DROP` statement removes specified variables from the output dataset.

### Syntax

    drop variable-1 variable-2;

### Example

    data work.patient_reduced;
        set work.patient_data;
        drop country treatment;
    run;

### Explanation

- `COUNTRY` and `TREATMENT` are removed from the output dataset.
- The observations remain unless another statement filters them.
- The `DROP` statement removes variables, or columns.
- The `DROP` statement does not filter observations.

## RENAME Statement

### Definition

The `RENAME` statement changes the name of a variable.

### Syntax

    rename old_name = new_name;

### Example

    data work.patient_renamed;
        set work.patient_data;
        rename subject_id = usubjid;
    run;

### Explanation

- `SUBJECT_ID` is renamed to `USUBJID`.
- The values stored in the variable do not change.
- Only the variable name changes.
- The `RENAME` statement does not filter observations.
- The `RENAME` statement does not remove variables.

## Comparison of the Four Statements

| Statement | Main Purpose | Affects Observations | Affects Variables |
|---|---|---|---|
| `WHERE` | Filters observations | Yes | No |
| `KEEP` | Selects variables for output | No | Yes |
| `DROP` | Removes variables from output | No | Yes |
| `RENAME` | Changes a variable name | No | Yes |

## Combined Example

    data work.patient_subset;
        set work.patient_data;
        where age >= 18;
        keep subject_id age sex;
        rename subject_id = usubjid;
    run;

## Line-by-Line Explanation

    data work.patient_subset;

Creates the output dataset `work.patient_subset`.

    set work.patient_data;

Reads observations from the input dataset `work.patient_data`.

    where age >= 18;

Keeps only observations where `AGE` is greater than or equal to 18.

    keep subject_id age sex;

Keeps only the variables `SUBJECT_ID`, `AGE`, and `SEX` in the output dataset.

    rename subject_id = usubjid;

Changes the output variable name from `SUBJECT_ID` to `USUBJID`.

    run;

Submits and executes the DATA step.

## Expected Output

The output dataset will contain:

- Only observations where `AGE >= 18`.
- The variables `USUBJID`, `AGE`, and `SEX`.
- `SUBJECT_ID` will appear as `USUBJID`.
- The values of the subject identifier will remain unchanged.

| Item | Expected Result |
|---|---|
| Observations | Observations where `AGE >= 18` |
| Variables | `USUBJID`, `AGE`, and `SEX` |
| Renamed variable | `SUBJECT_ID` becomes `USUBJID` |
| Variable values | Values remain unchanged |

The exact number of observations depends on the input dataset.

## Independent Practice

    data work.employee_subset;
        set work.employee_data;
        where salary > 50000;
        keep employee_id department salary;
        rename employee_id = emp_id;
    run;

### Expected Result

- Only employees with a salary greater than 50,000 are included.
- The output variables are `EMP_ID`, `DEPARTMENT`, and `SALARY`.
- `EMPLOYEE_ID` is renamed to `EMP_ID`.
- Other variables are not included in the output dataset.
- The values of the employee identifier do not change.

## Output Prediction

Before running the code, I should predict the output using this format:

    Observations:
    Variables:
    Removed variables:
    Renamed variable:
    Reason:

### Example Prediction

    Observations:
    Employees with SALARY greater than 50,000.

    Variables:
    EMP_ID, DEPARTMENT, and SALARY.

    Removed variables:
    All variables other than EMPLOYEE_ID, DEPARTMENT, and SALARY.

    Renamed variable:
    EMPLOYEE_ID becomes EMP_ID.

    Reason:
    WHERE filters observations, KEEP selects output variables, and RENAME changes the variable name.

## Common Mistakes

### Mistake 1: Thinking KEEP filters rows

Incorrect:

    KEEP removes observations.

Correct:

    KEEP controls variables, or columns.

### Mistake 2: Thinking DROP filters observations

Incorrect:

    DROP removes rows.

Correct:

    DROP removes variables, or columns.

### Mistake 3: Thinking RENAME changes values

Incorrect:

    RENAME changes the values of a variable.

Correct:

    RENAME changes only the variable name.

### Mistake 4: Guessing the Observation Count

The exact number of output observations cannot be determined unless the input data and the `WHERE` condition are known.

## SAS Log Checks

After running the SAS code, I should check the following:

- Did the DATA step run without errors?
- Are there any warnings in the SAS log?
- Was the output dataset created?
- Did the `WHERE` condition select the expected observations?
- Are only the expected variables present?
- Did the `RENAME` statement create the expected variable name?
- Did the variable values remain unchanged after renaming?
- Is the output observation count reasonable?
- Is the output variable count reasonable?

## Validation Checklist

| Validation Check | Expected Result |
|---|---|
| `WHERE` condition | Correct observations are selected |
| `KEEP` statement | Only required variables are present |
| `DROP` statement | Unwanted variables are removed |
| `RENAME` statement | The variable has the expected new name |
| Variable values | Values remain unchanged after renaming |
| SAS log | No errors or unexpected warnings |
| Output dataset | Dataset is created successfully |

## Professional English Explanation

The `WHERE` statement filters observations based on a condition. The `KEEP` statement retains selected variables in the output dataset, while the `DROP` statement removes unwanted variables. The `RENAME` statement changes the name of a variable without changing its values. Therefore, `WHERE` affects rows, whereas `KEEP`, `DROP`, and `RENAME` affect the structure or names of columns.

## Interview-Style Answer

In SAS, the `WHERE` statement is used to filter observations based on a condition. The `KEEP` statement retains selected variables in the output dataset, and the `DROP` statement removes unwanted variables. The `RENAME` statement changes the name of a variable without changing its values. The main distinction is that `WHERE` works with observations, while `KEEP`, `DROP`, and `RENAME` work with variables.

## Lesson Summary

In this lesson, I learned that:

- `WHERE` filters observations.
- `KEEP` retains selected variables.
- `DROP` removes unwanted variables.
- `RENAME` changes a variable name.
- Observations are rows.
- Variables are columns.
- The number of observations depends on the filtering condition.
- The number of variables depends on the output variable selection.
- SAS log review confirms that the program ran correctly.
- Output validation confirms that the dataset structure is correct.

## Related SAS Practice File

The related SAS practice file contains examples of:

- `WHERE`
- `KEEP`
- `DROP`
- `RENAME`
- Combined use of these statements
- Output prediction
- SAS log review
- Output validation
