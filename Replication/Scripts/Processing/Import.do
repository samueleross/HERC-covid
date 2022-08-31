/************************************************
Before running the following file:

	-Download in .csv format the Affinity - Country - Data dataset following the instructions in
	ReadMe.pdf
	
	-Designate HERC-covid/Replication/ as the working directory
	
************************************************
************************************************/
clear
set more off

***CONSUMER SPENDING***

*Import Original Dataset*
import delimited "Data/InputData/Affinity - State - Daily.csv"

*Drops Irrelevant Columns*
keep year month day statefips spend_all

*Keeps only Relevant Data Ranges*
keep if year == 2020
keep if (month==1 & day>25) | month == 2 | month == 3 | month == 4 | month == 5

*Save Modified Dataset*
save Data/IntermediateData/intermediate1_consumer.dta, replace

***EMPLOYMENT***

clear

*Import Original Dataset (commented-out dataset is from OppInsights; other is from Chetty's team via email)*
*import delimited "Data/Employment/InputData/Employment - State - Daily.csv"
import delimited "Data/InputData/Employment Combined - State - Daily.csv"

*Rename Columns*
ren emp_combined emp
ren emp_combined_inclow emp_incq1
ren emp_combined_inchigh emp_incq4

*Drops Irrelevant Columns (commented-out for legacy dataset)*
keep year month day statefips emp emp_incq1 emp_incq4

*Keeps only Relevant Data Ranges*
keep if year == 2020
keep if (month==1 & day>25) | month == 2 | month == 3 | month == 4 | month == 5

*Save Modified Dataset*
save Data/IntermediateData/intermediate1_employment.dta, replace

***SMALL BUSINESS***

clear

*Import Original Dataset*
import delimited "Data/InputData/Womply - State - Daily.csv"

*Drops Irrelevant Columns*
keep year month day statefips merchants_all

*Keeps only Relevant Data Ranges*
keep if year == 2020
keep if (month==1 & day>25) | month == 2 | month == 3 | month == 4 | month == 5

*Save Modified Dataset*
save Data/IntermediateData/intermediate1_smallbusiness.dta, replace

***MOBILITY***

clear

*Import Original Dataset*
import delimited "Data/InputData/Google Mobility - State - Daily.csv"

*Drops Irrelevant Columns*
ren gps_away_from_home gps
keep year month day statefips gps

*Keeps only Relevant Data Ranges*
keep if year == 2020
keep if (month==1 & day>25) | month == 2 | month == 3 | month == 4 | month == 5

*Save Modified Dataset*
save Data/IntermediateData/intermediate1_mobility.dta, replace

***MERGE***

clear 

*Merge above datasets*
use Data/IntermediateData/intermediate1_consumer.dta
merge 1:1 year month day statefips using Data/IntermediateData/intermediate1_employment.dta, nogen
merge 1:1 year month day statefips using Data/IntermediateData/intermediate1_smallbusiness.dta, nogen
merge 1:1 year month day statefips using Data/IntermediateData/intermediate1_mobility.dta, nogen

*Save Modified Dataset*
save Data/IntermediateData/intermediate1.dta, replace
