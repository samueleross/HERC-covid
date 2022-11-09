***HERC-covid***

These are the replication materials for Annais Gangolf, Devansh Goyal, and Samuel Ross's working paper "Reopening After Covid: A Replication and Extension of Chetty et al. (2020) 'The Economic Impacts of COVID-19.'" The most recent version of the paper may be found at https://www.samueleross.com/pages/working-papers/data/GangolfGoyalRoss_CovidReopenings.pdf.

*Software and Platform*

This project was created with Stata/BE 17.0 for Mac (Intel 64-bit) on a 2020 M1 MacBook Pro running macOS Monterey 12.4.

The project utilizes the Stata add-on package estout.

*Directory*

+- HERC-covid/
| |- README.txt
| |- Replication/
| | |- Data/
| | | |- AnalysisData/
| | | | |- analysis.dta
| | | | |- graph_employment.dta
| | | | |- graph_mobility.dta
| | | | |- graph_smallbusiness.dta
| | | | +- graph_spending.dta
| | | |
| | | |- InputData/
| | | | |- Affinity - State - Daily.csv
| | | | |- Employment - State - Daily.csv (Public)
| | | | |- Employment Combined - State - Daily.csv (Private)
| | | | |- Google Mobility - State - Daily.csv
| | | | +- Womply - State - Daily.csv
| | | |
| | | +- IntermedateData/
| | |   |- intermediate1_consumer.dta
| | |   |- intermediate1_employment.dta
| | |   |- intermediate1_mobility.dta
| | |   |- intermediate1_smallbusiness.dta
| | |   |- intermediate1.dta
| | |   |- intermediate2_date1.dta
| | |   |- intermediate2_date2.dta
| | |   |- intermediate2_date3.dta
| | |   +- intermediate2.dta
| | |
| | |-Output/
| | | |- EmploymentGraph.gph
| | | |- EmploymentGraph.pdf
| | | |- MobilityGraph.gph
| | | |- MobilityGraph.pdf
| | | |- RegTab.tex
| | | |- SmallBusinessGraph.gph
| | | |- SmallBusinessGraph.pdf
| | | |- SpendingGraph.gph
| | | +- SpendingGraph.pdf
| | |
| | +-Scripts/
| |   |- Master.do
| |   |- Analysis/
| |   |  +- Analysis.do
| |   |
| |   +- Processing/
| |      |- Import.do
| |      |- IntermediateProcessing_Date1.do
| |      |- IntermediateProcessing_Date2.do
| |      |- IntermediateProcessing_Date3.do
| |      +- AppendProcessing.do
| |
| +-Extension/
