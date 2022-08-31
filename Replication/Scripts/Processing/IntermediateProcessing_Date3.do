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
/*gen sundays = (date - dow(date-1))+6
collapse spend_all, by(sundays statefips)
format sundays %td*/

*Converts data to weekly w/out mean*
gen weekday = dow(date)
drop if weekday!=0
gen sundays = date
format sundays %td
drop date weekday year month day

*Specifies Control Date*
gen stateofinterest = 3

*Generates standarized event study variable giving time relative to reopening policy*
gen timeToTreat = sundays-td(27apr2020)

*Drops non-treatment and non-control states
gen isConsumerSpending = 0
replace isConsumerSpending = 1 if (statefips==17 | statefips==31 | statefips==34 | statefips==42 | statefips==51 | statefips==27 | statefips==28)
gen isEmployment = 0
replace isEmployment = 1 if (statefips==6 | statefips==9 | statefips==10 | statefips==11 | statefips==17 |  statefips==24 |  statefips==31 | statefips==35 | statefips==46 | statefips==51 | statefips==53 | statefips==55 | statefips==27 | statefips==28)
gen isSmallBusiness = 0
replace isSmallBusiness = 1 if (statefips==6 | statefips==9 | statefips==10 | statefips==11 | statefips==17 | statefips==24 | statefips==31 | statefips==35 | statefips==36 | statefips==42 | statefips==46 | statefips==51 | statefips==53 | statefips==55 | statefips==27 | statefips==28)
gen isMobility = 0
replace isMobility = 1 if (statefips==10| statefips==17| statefips==31| statefips==35| statefips==42| statefips==46| statefips==51| statefips==55 | statefips==27 | statefips==28)

*Codes in treatment and interaction variables
gen doesOpen = 0
replace doesOpen = 1 if (statefips==27 | statefips==28)
gen afterEvent = 0
replace afterEvent = 1 if timeToTreat>-1
gen isOpen = 0
replace isOpen = 1 if ((statefips==27 | statefips==28) & timeToTreat>-1)

*Save Modified Dataset*
save Data/IntermediateData/intermediate2_date3.dta, replace
