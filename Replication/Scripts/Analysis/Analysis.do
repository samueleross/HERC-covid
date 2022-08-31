/************************************************
************************************************
Before running the following file:

	-Follow instructions in AppendProcessing.do and run file
	
************************************************
************************************************/
clear
set more off 

*Selects Data*
use "Data/AnalysisData/analysis.dta"

*Runs Relevant Regressions*
local RegOptions nogaps label stats(N r2, label("N" "R$^2$") fmt(0 2)) b(%9.2f) se(%9.2f) replace star(* 0.10 ** 0.05 *** 0.01) fragment
eststo clear
eststo: qui reg spend_all doesOpen afterEvent isOpen if (isConsumerSpending==1 & timeToTreat<15 & timeToTreat>=-15), cluster(statefips)
eststo: qui reg spend_all doesOpen afterEvent isOpen if (isConsumerSpending==1 & timeToTreat<22 & timeToTreat>=-22), cluster(statefips)
eststo: qui reg emp doesOpen afterEvent isOpen if (isEmployment==1 & timeToTreat<15 & timeToTreat>=-15), cluster(statefips)
eststo: qui reg emp doesOpen afterEvent isOpen if (isEmployment==1 & timeToTreat<22 & timeToTreat>=-22), cluster(statefips)
eststo: qui reg merchants_all doesOpen afterEvent isOpen if (isSmallBusiness==1 & timeToTreat<15 & timeToTreat>=-15), cluster(statefips)
eststo: qui reg merchants_all doesOpen afterEvent isOpen if (isSmallBusiness==1 & timeToTreat<22 & timeToTreat>=-22), cluster(statefips)
eststo: qui reg gps doesOpen afterEvent isOpen if (isMobility==1 & timeToTreat<15 & timeToTreat>=-15), cluster(statefips)
eststo: qui reg gps doesOpen afterEvent isOpen if (isMobility==1 & timeToTreat<22 & timeToTreat>=-22), cluster(statefips)
esttab using Output/RegTab.tex, `RegOptions'
esttab

*Graphs Data*
use Data/AnalysisData/graph_spending.dta, clear
twoway connected spend_all timeToTreat if doesOpen==0, sort xlab(-80(10)20) || connected spend_all timeToTreat if doesOpen==1, sort xlab(-80(10)20)
graph save Output/SpendingGraph, replace
graph export Output/SpendingGraph.pdf, replace

use Data/AnalysisData/graph_employment.dta, clear
twoway connected emp timeToTreat if doesOpen==0, sort xlab(-80(10)20) || connected emp timeToTreat if doesOpen==1, sort xlab(-80(10)20)
graph save Output/EmploymentGraph, replace
graph export Output/EmploymentGraph.pdf, replace

use Data/AnalysisData/graph_smallbusiness.dta, clear
twoway connected merchants_all timeToTreat if doesOpen==0, sort xlab(-80(10)20) || connected merchants_all timeToTreat if doesOpen==1, sort xlab(-80(10)20)
graph save Output/SmallBusinessGraph, replace
graph export Output/SmallBusinessGraph.pdf, replace

use Data/AnalysisData/graph_mobility.dta, clear
twoway connected gps timeToTreat if doesOpen==0, sort xlab(-80(10)20) || connected gps timeToTreat if doesOpen==1, sort xlab(-80(10)20)
graph save Output/MobilityGraph, replace
graph export Output/MobilityGraph.pdf, replace

