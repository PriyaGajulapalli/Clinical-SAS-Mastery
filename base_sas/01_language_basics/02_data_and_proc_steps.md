# Lesson 2: DATA Step and PROC Step

## Objective

This lesson introduces the basic difference between the SAS DATA step and PROC step.

The DATA step is used to create, read, modify, and prepare SAS datasets. The PROC step is used to display, analyse, summarise, and report data.

## Concepts Covered

- Creating a SAS dataset using the DATA step
- Reading an existing dataset using the SET statement
- Using SAS-provided sample datasets
- Displaying data using PROC PRINT
- Understanding the difference between DATA step processing and PROC step processing
- Reviewing the SAS log for errors and warnings

## Practice 1: Creating a Student Dataset

The following program creates a new dataset named `student_copy` by reading the SAS-provided `SASHELP.CLASS` dataset.

```sas
data student_copy;
    set sashelp.class;
run;

proc print data=student_copy;
run;

## Explanation
- data student_copy; starts the DATA step and creates a new dataset named student_copy.
- set sashelp.class; reads observations from the SAS-provided SASHELP.CLASS dataset.
- run; executes the DATA step.
- proc print data=student_copy; starts the PRINT procedure.
- The PRINT procedure displays the observations in student_copy.
- The second run; executes the PROC PRINT step.
## Independent Exercise: Creating a Vehicle Dataset
The following program creates a new dataset named vehicle_review by reading the SAS-provided SASHELP.CARS dataset.

data vehicle_review;
    set sashelp.cars;
run;

proc print data=vehicle_review;
run;

## Explanation
data vehicle_review; starts the DATA step and creates a new dataset named vehicle_review.
set sashelp.cars; reads observations from the SAS-provided SASHELP.CARS dataset.
run; executes the DATA step.
proc print data=vehicle_review; starts the PRINT procedure.
The PRINT procedure displays the observations in vehicle_review.
The final run; executes the PROC PRINT step.
Key Difference Between DATA and PROC Steps
## DATA Step
The DATA step is mainly used to:

- Read data
- Create datasets
- Modify datasets
- Create or modify variables
- Prepare data for analysis or reporting
## PROC Step
The PROC step is mainly used to:

- Display data
- Analyze data
- Produce reports
- Summarize data
Perform specific SAS procedures
## SAS Log and Validation Checks
After running the program, perform the following checks:

- Confirm that the DATA step completed successfully.
- Check the SAS log for errors and warnings.
- Confirm that the student_copy dataset was created.
- Confirm that the vehicle_review dataset was created.
- Confirm that PROC PRINT displayed the expected output.
- Confirm that the dataset names in the DATA and PROC steps match.
- Confirm that the input datasets were not changed.
## Data Policy
This lesson uses SAS-provided sample datasets:

- SASHELP.CLASS
- SASHELP.CARS
The programs do not use patient-identifiable information, protected health information, real patient records, sponsor-confidential data, or proprietary clinical-trial data.

The code is created for learning, portfolio demonstration, and interview preparation purposes.

## Clinical SAS Relevance
In clinical programming, DATA steps are commonly used to read, prepare, transform, and derive datasets.

PROC steps are used for data review, analysis, reporting, and validation.

Understanding the difference between DATA step processing and PROC step processing is an important foundation for future SDTM, ADaM, TLF, and quality-control programming.

## Interview Explanation
A simple interview explanation is:

The DATA step is used to create or prepare a SAS dataset, while the PROC step is used to analyse, display, or report the data. In this practice, I used the SET statement to read SAS-provided sample datasets and PROC PRINT to review the resulting datasets.

Practice Status
- DATA step practice: Completed
- PROC step practice: Completed
- SET statement practice: Completed
- PROC PRINT practice: Completed
- SAS log review: Practiced
- Output review: Practiced
