*open log file
cap log close
log using regressions.log, replace

set more off

/****************************************************************************
Spencer Koo
JIW Analysis

2003 Princeton NIS 
Regressions
****************************************************************************/
/*
set working directory to "3 Junior"/"2014 Fall"/JIW/"1 Data"/ "NIS 2003 1..."
/"1 Data (manipulated)"
*/

*generate dependent var, log of income (capped at 1 mil)
gen logw = log(g7a) if g7a >= 0 & g7a < 1000000 & age > 25 & age < 60

*create age squared var
gen age2 = age*age

*rename A6 to gender
rename A6 gender

*make gender a binary var
replace gender = 0 if gender == 2

*rename yearsWorked to shorter name
rename yearsWorked yWorked

*******************************************************************************

*generate understand/speaking English vars
gen understand = J13 if J13 > 0 & age > 25 & age < 60
gen speak  = J14 if J14 > 0 & age > 25 & age < 60
*recode these variables so 1 is worse, 4 is best
recode understand (1 = 5)
recode understand (4 = 1)
recode understand (5 = 4)
recode understand (2 = 5)
recode understand (3 = 2)
recode understand (5 = 3)
recode speak (1 = 5)
recode speak (4 = 1)
recode speak (5 = 4)
recode speak (2 = 5)
recode speak (3 = 2)
recode speak (5 = 3)

*generate years of education var
gen yearsEd = A20 if age > 25 & age < 60 & A20 >= 0 & A20 < 86

*create some necessary productive vars
*Years resided in US
gen yLivedUS = age - ageI

*******************************************************************************

*create Asian & Education interaction variable
gen asianXedu = asian*yearsEd

*******************************************************************************

*run first regression for DEMOGRAPHIC DATA
reg logw asian age age2 gender, robust

*run with fixed effects (location)
areg logw asian age age2 gender, absorb(STATEmo)

*******************************************************************************

*run second regression for DEMOGRAPHIC DATA & PRODUCTIVE CHARACTERISTICS
*omitted write read b/c not enough answers
reg logw asian age age2 gender yLivedUS yWorked understand speak yearsEd, robust
*Keep in mind the reason the coefficients on speak/understand are negative is
*because lower is better

*run with fixed effects (location)
areg logw asian age age2 gender yLivedUS yWorked understand speak yearsEd, absorb(STATEmo)

*******************************************************************************

*run third regression for DEMO DATA, PROD DATA, & Asian-Educ Interaction Var
reg logw asian yearsEd asianXedu age age2 gender yLivedUS yWorked understand speak, robust

*run with fixed effects (location)
areg logw asian yearsEd asianXedu age age2 gender yLivedUS yWorked understand speak, absorb(STATEmo)

*Interpretting: when years of education is 0, it doesn't matter what race you
*are, your income will go way down. Education is massively important.

*******************************************************************************

*NOT USING Oaxaca decomposition using decompose ado by Ben Jahn
*decompose logw yearsEd age age2 gender yLivedUS yWorked understand speak, by(asian) detail estimates

*for the Oaxaca decomp, create a variable asian2, which is 1 if Asian and 0 if Hispanic, undefined for others
gen asian2 = 1 if K1mo == 44 | K1mo == 98 | K1mo == 111 | K1mo == 164 | K1mo == 224 | K1mo == 302
recode asian2 (mis = 0) if K1mo == 47 | K1mo == 55 | K1mo == 62 | K1mo == 65 | K1mo == 88 | K1mo == 92 | K1mo == 135 | K1mo == 163 | K1mo == 305


*run Oaxaca decomp using Stata's Oaxaca ado
oaxaca logw yearsEd age age2 gender yLivedUS yWorked understand speak, by(asian2) noisily

oaxaca logw yearsEd age age2 gender yLivedUS yWorked understand speak, by(asian2) noisily pooled

log close

