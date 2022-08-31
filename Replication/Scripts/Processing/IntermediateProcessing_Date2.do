/************************************************
************************************************
Before running the following file:

	-Follow instructions in Import.do and run file
	
************************************************
************************************************/
clear
set more off

*Select Intermediate Data*
use "Data/IntermediateData/intermediate1.dta"

*Converts date into a Stata readable format*
generate date = mdy(month, day, year)
format date %td

*Converts data to weekly w/ mean (Legacy)*
/*gen sundays = (date - dow(date-1))+6+4
collapse spend_all, by(sundays statefips)
format sundays %td*/

*Converts data to weekly w/out mean*
gen weekday = dow(date)
drop if weekday!=4
gen sundays = date
format sundays %td
drop date weekday year month day

*Specifies Control Date*
gen stateofinterest = 2

*Generates standarized event study variable giving time relative to reopening policy*
gen timeToTreat = sundays-td(24apr2020)

*Drops non-treatment and non-control states
gen isConsumerSpending = 0
replace isConsumerSpending = 1 if (statefips==6 | statefips==9 | statefips==10 | statefips==12 | statefips==17 | statefips==18 | statefips==22 | statefips==24 | statefips==25 | statefips==29 | statefips==31 | statefips==34 | statefips==35 | statefips==36 | statefips==42 | statefips==46 | statefips==51 | statefips==53 | statefips==55 | statefips==2 | statefips==13)
gen isEmployment = 0
replace isEmployment = 1 if (statefips==6 | statefips==9 | statefips==10 | statefips==11 | statefips==12 | statefips==17 | statefips==18 | statefips==22 | statefips==24 | statefips==29 | statefips==31 | statefips==35 | statefips==42 | statefips==46 | statefips==51 | statefips==53 | statefips==55 | statefips==2 | statefips==13)
gen isSmallBusiness = 0
replace isSmallBusiness = 1 if (statefips==6 | statefips==9 | statefips==10 | statefips==11 | statefips==12 | statefips==17 | statefips==18 | statefips==22 | statefips==24 | statefips==25 | statefips==29 | statefips==31 | statefips==34 | statefips==35 | statefips==36 | statefips==42 | statefips==46 | statefips==51 | statefips==53 | statefips==55 | statefips==2 | statefips==13)
gen isMobility = 0
replace isMobility = 1 if (statefips==2 | statefips==13 | statefips==10 | statefips==18| statefips==22| statefips==29| statefips==31| statefips==35| statefips==46| statefips==51| statefips==55)

*Codes in treatment and interaction variables
gen doesOpen = 0
replace doesOpen = 1 if (statefips==2 | statefips==13)
gen afterEvent = 0
replace afterEvent = 1 if timeToTreat>-1
gen isOpen = 0
replace isOpen = 1 if ((statefips==2 | statefips==13) & timeToTreat>-1)

*Save Modified Dataset*
save Data/IntermediateData/intermediate2_date2.dta, replace
