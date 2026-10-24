# Lesson 5: LENGTH, LABEL, and FORMAT

## Lesson Information
- **Lesson number:** 5
- **Topic:** `LENGTH`, `LABEL`, and `FORMAT`
- **Folder:** `base_sas/01_language_basics/`
- **Data policy:** This lesson uses SAS-provided sample data and synthetic examples only. No personal or confidential data is used.

---

## Learning Objectives

By the end of this lesson, I should be able to:

- Explain the purpose of the `LENGTH` statement.
- Identify character-variable truncation.
- Explain why `LENGTH` should appear before the first reference to a variable.
- Distinguish between stored values and displayed values.
- Use the `LABEL` statement to assign readable descriptions.
- Use the `FORMAT` statement to control output display.
- Use `PROC CONTENTS` to review variable attributes.
- Explain the Clinical SAS relevance of variable attributes.
- Review the SAS log for truncation and attribute-related issues.

---

## 1. The LENGTH Statement

The `LENGTH` statement defines the storage length of a variable.

For a character variable, use the dollar sign `$` followed by the number of characters.

```sas
length variable_name $number_of_characters;

Example
data patient_example;
    length patient_id $5;
    patient_id = 'P10001';
run;

The variable patient_id has a storage length of 5 characters.

The assigned value contains 6 characters:

P10001

Therefore, SAS stores only the first 5 characters:

P1000

The final character, 1, is truncated.

Interview Answer
The LENGTH statement defines the storage length of a variable. If a character value is longer than the defined length, SAS stores only the characters that fit and truncates the remaining characters.

## 2. Position of the LENGTH Statement
The LENGTH statement should appear before the variable's first definition or reference.

Correct Order
data correct_order;
    length patient_id $5;
    patient_id = 'P10001';
run;

Expected stored value:

P1000

Incorrect Order
data incorrect_order;
    patient_id = 'P10001';
    length patient_id $5;
run;

In this example, patient_id is first defined by the assignment statement. The later LENGTH statement cannot reduce the already established variable length to 5.

The correct rule is:

The LENGTH statement should appear before the variable's first definition or reference.

This example does not contain an INPUT statement. The assignment statement is the first statement that defines the variable.

## 3. Character Truncation
data truncation_example;
    length book_title $5;
    book_title = 'ClinicalSAS';
run;

proc print data=truncation_example;
run;

The assigned value is:

ClinicalSAS

The storage length is:

5 characters

The stored value is:

Clini

Only the first five characters fit in the variable.

Character truncation is especially important for:

Patient identifiers
Subject identifiers
Treatment codes
Visit names
Domain values
Clinical classification variables
## 4. The LABEL Statement
The LABEL statement assigns a readable description to a variable.

label variable_name = 'Descriptive Label';

Example
data label_example;
    amount = 1250.75;
    label amount = 'Unit Price';
run;

Attribute

Value

Variable name

amount

Variable label

Unit Price

Stored value

1250.75

The label is assigned to the variable, not to the individual value.

PROC PRINT Without the LABEL Option
proc print data=label_example;
run;

The heading will normally be:

amount

PROC PRINT With the LABEL Option
proc print data=label_example label;
run;

The heading will be:

Unit Price

The LABEL statement:

- Assigns a readable description to a variable.
- Improves report headings.
- Does not rename the variable.
- Does not change the stored value.
- Does not change the variable type.
- Does not change the variable length.
Interview Answer
A LABEL statement assigns a descriptive label to a variable for reporting. It does not change the variable name or the stored value.

## 5. The FORMAT Statement
The FORMAT statement controls how a stored value appears in the output.

format variable_name format_name.;

Numeric Example
data format_example;
    amount = 1250.75;
    format amount comma8.2;
run;

proc print data=format_example;
run;

Stored Value
1250.75

Displayed Value
1,250.75

The FORMAT statement changes the display appearance only. It does not change the stored value.

Understanding COMMA8.2
comma8.2

means:

COMMA: Use comma separators where appropriate.
8: Use a display width of 8 positions.
.2: Display two digits after the decimal point.
Interview Answer
The FORMAT statement does not change the stored value. It only controls how the value is displayed in the output.

## 6. Stored Value Versus Displayed Value
data stored_and_displayed;
    amount = 1250.75;
    format amount comma8.2;
run;

Item

Result

Stored value

1250.75

Displayed value

1,250.75

Effect of FORMAT

Changes display appearance

Effect on stored value

No change

The stored numeric value can still be used in calculations.

data calculation_example;
    amount = 1250.75;
    format amount comma8.2;
    total = amount * 2;
run;

proc print data=calculation_example;
run;

The calculation uses the stored value:

1250.75 * 2 = 2501.50

## 7. Character Formats
data character_format_example;
    length product $5;
    product = 'SAS';
    format product $upcase10.;
run;

proc print data=character_format_example;
run;

Attribute

Result

Variable name

product

Variable type

Character

Storage length

5

Stored value

SAS

Display width

10

Displayed text

SAS

The format does not increase the storage length from 5 to 10.

LENGTH controls storage allocation.
$UPCASE10. controls display format and display width.
## 8. Combining LENGTH, LABEL, and FORMAT
data combined_example;
    length product $5;
    product = 'SAS';

    label product = 'Product Name';

    format product $upcase10.;
run;

proc print data=combined_example label;
run;

Item

Result

Heading

Product Name

Variable name

product

Variable type

Character

Storage length

5

Stored value

SAS

Displayed value

SAS

Display width

10

Interview Answer
The LENGTH statement controls the variable's storage length, the LABEL statement controls the descriptive report heading, and the FORMAT statement controls the displayed appearance of the value.

## 9. Guided Practice Using SASHELP.CLASS
data class_report;
    set sashelp.class;

    length record_type $8;
    record_type = 'SOURCE';

    label
        name = 'Student Name'
        sex = 'Sex'
        age = 'Age in Years'
        height = 'Height in Inches'
        weight = 'Weight in Pounds'
        record_type = 'Record Type';

    format
        height 6.1
        weight 6.1;
run;

proc contents data=class_report;
run;

proc print data=class_report label;
run;

Program Explanation
set sashelp.class;

Reads observations from the SAS-provided sample dataset.

length record_type $8;

Creates a character variable with a storage length of 8 characters.

record_type = 'SOURCE';

Stores the value SOURCE.

label record_type = 'Record Type';

Assigns a readable label for reporting.

format height 6.1 weight 6.1;

Controls how height and weight appear in the output. The underlying numeric values are not changed.

## 10. PROC CONTENTS
PROC CONTENTS displays information about a dataset and its variables.

proc contents data=class_report;
run;

Important details include:

Variable name
Variable type
Variable length
Variable label
Variable order
Number of observations
Number of variables
Example Attribute
For record_type:

Attribute

Expected Result

Name

record_type

Type

Character

Length

8

Label

Record Type

Clinical SAS Relevance
PROC CONTENTS is useful for:

- Reviewing source datasets.
- Checking character and numeric variable types.
- Confirming variable lengths.
- Reviewing labels before creating reports.
- Comparing expected and actual dataset attributes.
- Supporting SDTM and ADaM programming.
- Reviewing datasets before TLF development.
- Supporting quality control and validation.
## 11. Independent Exercise
Use the SAS-provided dataset SASHELP.CLASS.

Create a dataset named class_attributes that:

- Reads data from SASHELP.CLASS.
- Creates a character variable named record_type with a length of 8.
- Assigns the value SOURCE to record_type.
- Assigns the label Record Type to record_type.
- Assigns readable labels to name, age, and sex.
- Applies a numeric format to height with one decimal place.
- Applies a numeric format to weight with one decimal place.
- Uses PROC CONTENTS to review the attributes.
- Uses PROC PRINT DATA=class_attributes LABEL; to display the report.
## Exercise Code
data class_attributes;
    set sashelp.class;

    length record_type $8;
    record_type = 'SOURCE';

    label
        name = 'Student Name'
        age = 'Age in Years'
        sex = 'Sex'
        record_type = 'Record Type';

    format
        height 6.1
        weight 6.1;
run;

proc contents data=class_attributes;
run;

proc print data=class_attributes label;
run;

## Exercise Questions
- What is the storage length of record_type?
- What is the stored value of record_type?
- What heading appears for record_type in PROC PRINT?
- Does the FORMAT statement change the stored values of height and weight?
- Why should variable attributes be defined before assigning values?
## 12. Output-Prediction Task
Predict the result before running the program.

data output_prediction;
    length subject_code $4;
    subject_code = 'AB123';
    label subject_code = 'Subject Code';
run;

proc print data=output_prediction label;
run;

Questions
- What is the variable name?
- What is the variable type?
- What is the storage length?
- What value will be stored?
- What heading will appear in PROC PRINT?
- Which character will be truncated?
Expected Answer
The assigned value is:

AB123

The storage length is:

4 characters

The stored value will be:

AB12

The last character, 3, will be truncated.

With the LABEL option, the heading will be:

Subject Code

## 13. Debugging Task
The following program contains a variable-attribute order problem:

data debug_example;
    product = 'ClinicalSAS';
    length product $5;
    label product = 'Product Name';
run;

The variable is first defined by:

product = 'ClinicalSAS';

The LENGTH statement appears after the variable has already been defined.

Corrected Program
data debug_example;
    length product $5;
    product = 'ClinicalSAS';
    label product = 'Product Name';
run;

Expected Stored Value
Clini

Debugging Explanation
The LENGTH statement should appear before the first reference to product. This allows SAS to establish the intended character length before the value is assigned.

SAS Log Review
After running a program, review the SAS log for:

Errors
Warnings
Notes about character truncation
Messages about multiple lengths
Unexpected variable attributes
Unexpected observation counts
Unexpected variable counts
## 14. Common Mistakes
## Mistake 1: Treating FORMAT as a Storage Definition
Incorrect:

The FORMAT statement changes the stored value.

Correct:

The FORMAT statement changes only the displayed appearance of the stored value.

## Mistake 2: Treating LABEL as a Variable Rename
Incorrect:

The LABEL statement renames the variable.

Correct:

The LABEL statement assigns a descriptive heading to the variable for reporting. The variable name remains unchanged.

## Mistake 3: Defining LENGTH Too Late
Incorrect:

data example;
    subject_id = 'P10001';
    length subject_id $5;
run;

Correct:

data example;
    length subject_id $5;
    subject_id = 'P10001';
run;

## Mistake 4: Confusing a Variable Label with a Variable Value
Incorrect:

The label changes the value of the variable.

Correct:

The label provides a readable description of the variable. It does not change the stored value.

## Mistake 5: Not Giving the Exact Output
Weak answer:

The value will be displayed in a readable format.

Better answer:

The stored value remains 1250.75, but the displayed value will be 1,250.75.

## 15. Clinical SAS Relevance
Correct variable attributes are important in Clinical SAS programming because they affect:

- Dataset structure
- Data integrity
- Data validation
- Subject identifier handling
- Dataset merging
- Report readability
- Tables, listings, and figures
- SDTM datasets
- ADaM datasets
- TLF output
- Quality control
- Traceability
Example
data subject_data;
    length usubjid $20;
    usubjid = 'STUDY01-SITE001-0001';
run;

If usubjid is defined with an insufficient length, the identifier may be truncated.

This can cause:

- Incorrect subject matching
- Incorrect merges
- Duplicate-looking records
- Validation findings
- Inconsistent downstream outputs
- Loss of traceability
- Clinical Programming Interview Answer
- Correct variable attributes are important in Clinical SAS programming because incorrect lengths, labels, or formats can affect data integrity, merging, validation, traceability, and the readability of clinical outputs.

## 16. Interview Questions and Model Answers
## Question 1: What is the purpose of the LENGTH statement?
The LENGTH statement defines the storage length of a variable. For character variables, it determines how many characters SAS can store. If the assigned value exceeds that length, the extra characters may be truncated.

## Question 2: Does the FORMAT statement change the stored value?
No. The FORMAT statement changes only how the stored value appears in the output. The underlying stored value remains unchanged.

## Question 3: What is the difference between a variable name and a variable label?
A variable name is used in SAS programming, while a variable label is a descriptive heading used mainly for reporting. A label does not rename the variable.

## Question 4: Why should the LENGTH statement appear before the assignment statement?
The LENGTH statement should appear before the assignment statement so that SAS establishes the intended variable length before the variable is first defined. This helps prevent unintended truncation and attribute-related issues.

## Question 5: What will be stored in this example?
data test;
    length patient_id $5;
    patient_id = 'P10001';
run;

The stored value will be P1000. The variable has a storage length of five characters, while the assigned value contains six characters. The final character is truncated.

## Question 6: What will be displayed in this example?
data test;
    amount = 1250.75;
    format amount comma8.2;
run;

The stored value remains 1250.75, but the displayed value will be 1,250.75.

## Question 7: What does PROC CONTENTS show?
PROC CONTENTS shows dataset and variable attributes such as variable names, types, lengths, labels, formats, and the number of observations and variables.

## 17. Certification-Style Questions
## Question 1
Which statement controls the storage length of a character variable?

A. LABEL
B. FORMAT
C. LENGTH
D. PRINT
Answer: C. LENGTH

## Question 2
What does the following statement do?

format amount comma8.2;

A. Changes the stored value
B. Changes the variable type
C. Controls the displayed appearance
D. Changes the variable name
Answer: C. Controls the displayed appearance

## Question 3
What is the stored value?

data test;
    length id $4;
    id = 'AB123';
run;

A. AB123
B. AB12
C. 123
D. Missing value
Answer: B. AB12

## Question 4
What does the LABEL statement provide?

A. A new stored value
B. A new variable type
C. A descriptive label for reporting
D. A new dataset name
Answer: C. A descriptive label for reporting

## Question 5
Which procedure can be used to review variable names, types, lengths, and labels?

A. PROC PRINT
B. PROC CONTENTS
C. PROC SORT
D. PROC FORMAT
Answer: B. PROC CONTENTS

## Final Takeaways
- Define character-variable lengths before the first reference to the variable.
- A character value longer than its defined length may be truncated.
- LENGTH controls storage allocation.
- LABEL controls the descriptive report heading.
- FORMAT controls displayed appearance.
- FORMAT does not change the stored value.
- LABEL does not rename the variable.
- PROC CONTENTS helps review variable attributes.
- Correct attributes are important for Clinical SAS data quality.
- Always review the SAS log after running a program.
## Self-Assessment Checklist
[ ] I can explain what the LENGTH statement controls.
[ ] I can explain what happens when a character value is longer than its defined length.
[ ] I can explain why LENGTH should appear before the first variable reference.
[ ] I can distinguish between a variable name and a variable label.
[ ] I can explain whether FORMAT changes a stored value.
[ ] I can distinguish between a stored value and a displayed value.
[ ] I can explain what PROC CONTENTS provides.
[ ] I can explain why variable attributes matter in Clinical SAS programming.
[ ] I can identify truncation or attribute issues from the SAS log.
[ ] I can explain these concepts clearly in an interview.





