*****HERC-covid*****

These are the replication materials for Annais Gangolf, Devansh Goyal, and Samuel Ross's working paper "Reopening After Covid: A Replication and Extension of Chetty et al. (2020) 'The Economic Impacts of COVID-19.'" The most recent version of the paper may be found at https://www.samueleross.com/pages/working-papers/data/GangolfGoyalRoss_CovidReopenings.pdf.


**Software and Platform**

This project was created with Stata/BE 17.0 for Mac (Intel 64-bit) on a 2020 M1 MacBook Pro running macOS Monterey 12.4. Mac, Windows, and Linux machines running any edition of Stata 17.0 should be able to run this project.

The project uses the Stata add-on package estout.


**Restricted Data**

While most data files were publicly available at the Opportunity Insights website (https://opportunityinsights.org/data/), the dataset HERC-covid/Replication/Data/InputData/Employment Combined - State - Daily.csv was provided directly by the Opportunity Insights team after we raised concerns about missing values in the public series. Our analysis uses this more complete dataset but we do not make it available in this repository due to intellectual property and privacy concerns. We have, however, provided the public version of this dataset HERC-covid/Replication/Data/InputData/Employment- State - Daily.csv for a proof-of-concept. To obtain the private dataset, we recommmend contacting the Opportunity Insights team directly at info@opportunityinsights.org. Otherwise, please follow the instructions below to use the public data.


**File Structure**

HERC-covid/
|- README.txt
+- Replication/
  |- Data/
  | |- AnalysisData/
  | | |- analysis.dta
  | | |- graph_employment.dta
  | | |- graph_mobility.dta
  | | |- graph_smallbusiness.dta
  | | +- graph_spending.dta
  | |
  | |- InputData/
  | | |- Affinity - State - Daily.csv
  | | |- Employment - State - Daily.csv
  | | |- Employment Combined - State - Daily.csv (Restricted)
  | | |- Google Mobility - State - Daily.csv
  | | +- Womply - State - Daily.csv
  | |
  | +- IntermedateData/
  |   |- intermediate1_consumer.dta
  |   |- intermediate1_employment.dta
  |   |- intermediate1_mobility.dta
  |   |- intermediate1_smallbusiness.dta
  |   |- intermediate1.dta
  |   |- intermediate2_date1.dta
  |   |- intermediate2_date2.dta
  |   |- intermediate2_date3.dta
  |   +- intermediate2.dta
  |
  |-Output/
  | |- EmploymentGraph.gph
  | |- EmploymentGraph.pdf
  | |- MobilityGraph.gph
  | |- MobilityGraph.pdf
  | |- RegTab.tex
  | |- SmallBusinessGraph.gph
  | |- SmallBusinessGraph.pdf
  | |- SpendingGraph.gph
  | +- SpendingGraph.pdf
  |
  +-Scripts/
    |- Master.do
    |- Analysis/
    |  +- Analysis.do
    |
    +- Processing/
       |- Import.do
       |- IntermediateProcessing_Date1.do
       |- IntermediateProcessing_Date2.do
       |- IntermediateProcessing_Date3.do
       +- AppendProcessing.do


**Replication Instructions**

1. Download this repository and navigate to its location on your local machine.

2. Verify that this README.txt file and the directory illustrated within are intact.

3. Verify that you are using Stata 17.0 and have installed the package estout.

4. Open Stata and set your working directory to HERC-covid/Replication/. All directories given hereafter are relative to this path.

5. If you would like to perform the replication with the restricted employment data, consult the access instructions above then add the restricted file to the Data/InputData/ directory. Otherwise, un-comment line 34 and comment-out line 35 of Scripts/Processing/import.do to use the public employment data. 

6. To perform the replication in full, run the file Scripts/Master.do. 

7. To perform the replication file-by-file, do the following:

  a. Run Scripts/Processing/Import.do. This script imports all the Chetty et al. (2020) data files located in Data/InputData/, performs an initial cleaning, saves the files Data/IntermediateData/intermediate1_*.dta, then merges them into the file Data/IntermediateData/intermediate1.dta.

  b. Run the three files Scripts/Processing/IntermediateProcessing_Date*.do. These scripts create the event series for each reopening date (04/20/2020, 04/24/2020, or 04/27/2020). They load Data/IntermediateData/intermediate1.dta, convert to weekly frequency, redefine time relative to the respective reopening date, and code indicator variables for treatment and control states, as given by Chetty et al. (2020). They saves each series to Data/IntermediateData/intermediate2_date*.dta.

  c. Run Scripts/Processing/AppendProcessing.do. This script imports all the Data/IntermediateData/intermediate2_date*.dta files then merges them and saves to Data/AnalysisData/analysis.dta. It also performs cleaning for graphing for each indicator, creating the four files Data/AnalysisData/graph_*.dta.

  d. Run Scripts/Analysis/analysis.do. This script loads Data/AnalysisData/analysis.dta and performs the requiste regressions to create Table 1b in the paper, saving the TeX file Output/RegTab.Tex. It also creates the graphs for Figures 1b, 2b, 3b, and 4, saving the files Output/*Graph.gph and Output/*Graph.pdf.


**Issues**

If you have any issues with this repository, please contact Samuel Ross at seross@haverford.edu.

********************
