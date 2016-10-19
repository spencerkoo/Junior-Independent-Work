# Junior-Independent-Work

This showcases my data manipulation skills and analysis in Stata.

The data comes from a publicly available survey data (registration needed) conducted by Princeton University called the New Immigrant Survey (NIS). Some of the data files are much larger than the allotted 25MB allowed on Github. Please refer to http://nis.princeton.edu/data.html in order to download the data. The sets are from the 2003 round 1 study labeled 2003-1. The relevant datasets are a_adult, b_adult, c_adult, d_adult, g_adult, h_adult, j_adult, k_adult, and l_adult.

I used this data to answer the following question: Is there a difference between the monetary success of first-generation Asian and Hispanic immigrants to the United States? If so, why? In short, my analysis concluded a clear difference between the two groups; however, the data remained insufficient to offer any clear-cut policy altering suggestions (but, let's be honest, that probably wouldn't stop some unknowledgeable interest group from skewing the results one way or the other).

I learned Stata for this project. After selecting my topic with my advisor, I found the datasets, combined and chose the relevant data from thousands of data points and observations, manipulated the data for regressions, and analyzed the results.

Requisites:
Stata13

To run the code, the data files (.dta files) and the .do files should be placed in the same directory. First run the combined_adult.do file to combine the relevant datasets. Then run the regressions.do file to get the results.
