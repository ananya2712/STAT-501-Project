data usdata;
    infile 'C:\Users\anany\Desktop\01 MS CIT\STAT\PROJECT\USDataF23.txt' dlm='09'x firstobs=2;
    INPUT 
        State $ 
        Region $ 
        CountyIndex 
        UrbanIndicator 
        Population 
        LandArea 
        PopulationDensity 
        PercentMaleDivorce 
        PercentFemaleDivorce 
        MedianIncome 
        IncomeCategory $ 
        PercentCollegeGraduates 
        MedianHouseAge 
        RobberiesPerPopulation 
        AssaultsPerPopulation 
        BurglariesPerPopulation 
        LarceniesPerPopulation 
        EducationSpending 
        EducationSpendingP2 
        TestScore 
        RegionNew $;
RUN;
DATA selected_states;
    SET usdata;
    WHERE State IN ('Illinois', 'Kentucky', 'Indiana');
RUN;
DATA selected_columns;
    SET selected_states;
    KEEP State PercentCollegeGraduates UrbanIndicator MedianIncome;
RUN;
PROC PRINT DATA=selected_columns;
RUN;
FILENAME outfile 'C:\Users\anany\Desktop\01 MS CIT\STAT\PROJECT\USDataF23_modified_Group14.txt';
DATA _NULL_;
    FILE outfile dlm='09'x;
    IF _N_ = 1 THEN PUT 'State' '09'x 'PercentCollegeGraduates' '09'x 'UrbanIndicator' '09'x 'MedianIncome';
    SET selected_columns;
    PUT State '09'x PercentCollegeGraduates '09'x UrbanIndicator '09'x MedianIncome;
RUN;


data mydata;
    infile 'C:\Users\anany\Desktop\01 MS CIT\STAT\PROJECT\USDataF23_modified_Group14.txt' dlm='09'x firstobs=2;
	input State	$ PercentCollegeGraduate $ UrbanIndicator % MedianIncome
run;
PROC PRINT DATA=mydata;
RUN;


