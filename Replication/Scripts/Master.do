/************************************************
Before running the following file:

	-Download in .csv format the Affinity - Country - Data dataset following the instructions in
	ReadMe.pdf
	
	-Designate HERC-covid/Replication/ as the working directory
	
************************************************
************************************************/
clear
set more off

*Execute Processing Scripts*
run "Scripts/Processing/Import.do"
run "Scripts/Processing/IntermediateProcessing_Date1.do"
run "Scripts/Processing/IntermediateProcessing_Date2.do"
run "Scripts/Processing/IntermediateProcessing_Date3.do"
run "Scripts/Processing/AppendProcessing.do"

*Perform Analysis*
do "Scripts/Analysis/Analysis.do"

