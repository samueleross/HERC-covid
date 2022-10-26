/************************************************
************************************************
Before running the following file:

	-Follow instructions in IntermediateProcessing_Date{1,2,3}.do and run files
	
************************************************
************************************************/
clear
set more off

*Selects Intermediate Data*
use "Data/IntermediateData/intermediate2_date1.dta"

*Appends Data to Create One Set*
append using "Data/IntermediateData/intermediate2_date2.dta"
append using "Data/IntermediateData/intermediate2_date3.dta"

*Save Modified Dataset*
save Data/AnalysisData/analysis.dta, replace

*Make & Save Graphing Modifications*
drop if (isConsumerSpending==0 | timeToTreat>21 | timeToTreat<-90)
collapse spend_all , by(doesOpen timeToTreat)
replace spend_all = spend_all*100
save Data/AnalysisData/graph_spending.dta, replace

use Data/AnalysisData/analysis.dta, clear
drop if (isEmployment==0 | timeToTreat>21 | timeToTreat<-90)
collapse emp , by(doesOpen timeToTreat)
replace emp = emp*100
save Data/AnalysisData/graph_employment.dta, replace

use Data/AnalysisData/analysis.dta, clear
drop if (isSmallBusiness==0 | timeToTreat>21 | timeToTreat<-90)
collapse merchants_all , by(doesOpen timeToTreat)
replace merchants_all = merchants_all*100
save Data/AnalysisData/graph_smallbusiness.dta, replace

use Data/AnalysisData/analysis.dta, clear
drop if (isMobility==0 | timeToTreat>21 | timeToTreat<-90)
collapse gps , by(doesOpen timeToTreat)
replace gps = gps*100
save Data/AnalysisData/graph_mobility.dta, replace
