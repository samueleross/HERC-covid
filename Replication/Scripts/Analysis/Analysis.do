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

*TABLE 1, PANEL B*

*Table Formatting Options*
local RegOptions nogaps label stats(N r2, label("N" "R$^2$") fmt(0 2)) b(%9.2f) se(%9.2f) replace star(* 0.10 ** 0.05 *** 0.01) fragment transform( 100*@ 100 ) drop(doesOpen afterEvent _cons) varlabels(isOpen "DiD Estimate of Effect")

*Execute Regressions*
eststo clear
*Column 1*
eststo: qui reg spend_all doesOpen afterEvent isOpen if (isConsumerSpending==1 & timeToTreat<14 & timeToTreat>=-14), cluster(statefips)
*Column 2*
eststo: qui reg spend_all doesOpen afterEvent isOpen if (isConsumerSpending==1 & timeToTreat<21 & timeToTreat>=-21), cluster(statefips)
*Column 3*
eststo: qui reg emp doesOpen afterEvent isOpen if (isEmployment==1 & timeToTreat<14 & timeToTreat>=-14), cluster(statefips)
*Column 4*
eststo: qui reg emp doesOpen afterEvent isOpen if (isEmployment==1 & timeToTreat<21 & timeToTreat>=-21), cluster(statefips)
*Column 5*
eststo: qui reg merchants_all doesOpen afterEvent isOpen if (isSmallBusiness==1 & timeToTreat<14 & timeToTreat>=-14), cluster(statefips)
*Column 6*
eststo: qui reg merchants_all doesOpen afterEvent isOpen if (isSmallBusiness==1 & timeToTreat<21 & timeToTreat>=-21), cluster(statefips)
*Column 7*
eststo: qui reg gps doesOpen afterEvent isOpen if (isMobility==1 & timeToTreat<14 & timeToTreat>=-14), cluster(statefips)
*Column 8*
eststo: qui reg gps doesOpen afterEvent isOpen if (isMobility==1 & timeToTreat<21 & timeToTreat>=-21), cluster(statefips)

*Output Table to TeX*
esttab using Output/RegTab.tex, `RegOptions'
esttab

*Graph Formatting Options*
local graphOptions1 sort lcolor("35 77 161") mcolor("35 77 161") msize(4pt) lwidth(2pt)
local graphOptions2 sort xlab(-80(20)20) xtitle("Days Relative to Re-opening") ytitle("Relative to January 2020") l1title("Change in Consumer Spending (%)", size(medsmall)) legend(position(0) bplacement(swest)) legend(rows(2)) legend(label(1 "Control States")) legend(label(2 "Opening States")) legend(region(lwidth(none))) xline(0, lpattern(dash) lcolor("214 19 19")) lcolor("214 19 19") mcolor("214 19 19") msize(4pt) xtick(-80(20)20) xsize(7) ysize(4.65) ylab(-30(10)0,angle(0) nogrid) graphregion(color(white)) lwidth(1.5pt)

*FIGURE 1b*
use Data/AnalysisData/graph_spending.dta, clear
twoway connected spend_all timeToTreat if doesOpen==0, `graphOptions1' || connected spend_all timeToTreat if doesOpen==1, `graphOptions2' title("{bf:B. Re-Opened States vs. Control States: Consumer Spending}", size(large) color(black) margin(large) span) text(1 6 "Opening", color("214 19 19") size(medsmall))
graph save Output/SpendingGraph, replace
graph export Output/SpendingGraph.pdf, replace

*FIGURE 2b*
use Data/AnalysisData/graph_employment.dta, clear
twoway connected emp timeToTreat if doesOpen==0, `graphOptions1' || connected emp timeToTreat if doesOpen==1, `graphOptions2' title("{bf:C. Re-Opened States vs. Control States: Employment}", size(large) color(black) margin(large) span) text(1.5 6 "Opening", color("214 19 19") size(medsmall))
graph save Output/EmploymentGraph, replace
graph export Output/EmploymentGraph.pdf, replace

*FIGURE 3b*
use Data/AnalysisData/graph_smallbusiness.dta, clear
twoway connected merchants_all timeToTreat if doesOpen==0, `graphOptions1' || connected merchants_all timeToTreat if doesOpen==1, `graphOptions2' title("{bf:D. Re-Opened States vs. Control States: Small Businesses Open}", size(large) color(black) margin(large) span) text(2.2 6 "Opening", color("214 19 19") size(medsmall))
graph save Output/SmallBusinessGraph, replace
graph export Output/SmallBusinessGraph.pdf, replace

*FIGURE 4*
use Data/AnalysisData/graph_mobility.dta, clear
twoway connected gps timeToTreat if doesOpen==0, `graphOptions1' || connected gps timeToTreat if doesOpen==1, `graphOptions2' title("{bf:E. Re-Opened States vs. Control States: Mobility}", size(large) color(black) margin(large) span) text(1 6 "Opening", color("214 19 19") size(medsmall))
graph save Output/MobilityGraph, replace
graph export Output/MobilityGraph.pdf, replace
