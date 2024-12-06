data usdata;
    infile 'C:\Users\anany\Desktop\01 MS CIT\STAT\PROJECT\USDataF23_modified_Group14.txt' dlm='09'x firstobs=2;
	input State	$ PercentCollegeGraduates UrbanIndicator $ MedianIncome
run;
PROC PRINT DATA=usdata;
RUN;
/* Generate QQ plot and Histogram for PercentCollegeGraduates */
proc univariate data=usdata;
    var PercentCollegeGraduates;
    histogram PercentCollegeGraduates / normal;
    qqplot PercentCollegeGraduates / normal(mu=est sigma=est);
    title "Distribution Analysis for Percent College Graduates";
run;

/* Generate QQ plot and Histogram for MedianIncome */
proc univariate data=usdata;
    var MedianIncome;
    histogram MedianIncome / normal;
    qqplot MedianIncome / normal(mu=est sigma=est);
    title "Distribution Analysis for Median Income";
run;
/* Generate Box Plot for Percent College Graduates */
proc sgplot data=usdata;
    vbox PercentCollegeGraduates / datalabel=State;
    title "Box Plot for Percent College Graduates";
run;

/* Generate Box Plot for Median Income */
proc sgplot data=usdata;
    vbox MedianIncome / datalabel=State;
    title "Box Plot for Median Income";
run;
proc means data=usdata q1 q3 qrange;
  var PercentCollegeGraduates;
  output out=stats q1=Q1 q3=Q3 qrange=IQR;
run;
data cleaned_dataset;
  set usdata;
  if _n_ = 1 then set stats;
  lower_bound = Q1 - 1.5*IQR;
  upper_bound = Q3 + 1.5*IQR;
  if PercentCollegeGraduates >= lower_bound and PercentCollegeGraduates <= upper_bound;
  drop Q1 Q3 IQR lower_bound upper_bound;
run;
PROC PRINT DATA=cleaned_dataset;
RUN;
/* Dump cleaned data into textfile */
FILENAME outfile 'C:\Users\anany\Desktop\01 MS CIT\STAT\PROJECT\USDataF23_cleaned_Group14.txt';
DATA _NULL_;
    FILE outfile dlm='09'x;
    IF _N_ = 1 THEN PUT 'State' '09'x 'PercentCollegeGraduates' '09'x 'UrbanIndicator' '09'x 'MedianIncome';
    SET cleaned_dataset;
    PUT State '09'x PercentCollegeGraduates '09'x UrbanIndicator '09'x MedianIncome;
RUN;




