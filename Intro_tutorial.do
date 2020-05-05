

* A. Import dataset
*- The following is a brief tutorial using example data sets already installed in STATA
 * - auto.dta is used for commands 1.1.1-1.2.2 & 4.1.1-4.3.1.3
  *- uslifeexp.dta is used for commands 1.2.3-3.4.1

* 1. Basic commands

*Import data set
sysuse auto.dta, clear

** 1.1.1 List variables

*List 1 variable
list price

*List 2 variables
list price mpg

*** 1.1.2 List variables: by condition

*List only first 10 observations of variables
list price mpg in 1/10

*List variable by row by condition
list price mpg if make == "Subaru"

** 1.1.3 Rename variables

rename foreign location

** 1.1.4 Label variables

label variable location "Location of car production"

** 1.2 Basic statistics

*** 1.2.1 Summary statistics

summarize  price mpg

**** 1.2.1.1 Summary: by condition

summarize price mpg if length>200

*** 1.2.2 Correlation matrix

correlate mpg price weight length

*** 1.2.3 Cross tabulation
*Note: 1.2.3-3.4.1 uses uslifeexp.dta
sysuse uslifeexp.dta, clear
*Set as time series
tsset year

tabstat le_male le_female le_w, by(year)

* 2. Manipulating data

** 2.1 Basics

*** 2.1.1 Generating logs

gen ln_le_male = ln(le_male)

*** 2.1.2 First difference

gen fd_le_male = D.le_male

**** 2.1.2.1 First difference (Alternative method)

gen fd2_le_male= le_male[_n]-le_male[_n-1]

**** 2.1.2.2 First difference by country (row condition)

*By country (row variable)
*by country: gen fd_x1= x1[_n]-x1[_n-1]

**** 2.1.2.3 First difference logs

*by country: gen x1_ln_diff = ln(x1[_n])-ln(x1[_n-1])

**** 2.1.2.4 First difference absolute value

gen x1_le_male =  abs(le_male[_n]-le_male[_n-1])

** 2.2 Scale variables

*** 2.2.1 Scale variable by billions

gen  divideby10_le_male =  le_male/10

*** 2.2.2 Scale variables by other variables

gen male_female_ratio = le_male/le_female

** 2.3 Moving average

*** 2.3.1 Moving average 3-period

*Not an example shown with uploaded data set
*Use with panel data
*rangestat (mean) yr_avg3 = x1, interval(time -1 1)

*** 2.3.2 Moving average 3-period by country

*Not an example shown with uploaded data set
*Use with panel data
*rangestat (mean) yr_avg3 = x1, interval(time -1 1) by(country)

*** 2.3.3 Moving average by time

*Not an example shown with uploaded data set
*Use with panel data
*bysort time: egen x1_yearly_avg =mean(x1)

** 2.4 Generate dummies

*** 2.4.1 Dummy by country (row conditon)

gen long_life = 0
replace long_life = 1 if le_male>70

*** 2.4.2 Dummy by time (By time period)

gen stock_crash = 0
replace stock_crash = 1 if year==1987
replace stock_crash = 1 if year==1997

*** 2.4.2 Dummy by time (After time period)

gen after_eighty = 0
replace after_eighty =1 if year>1979

** 2.5 Creating lags

*One lag
gen lag_le = L.le
*Two lags
gen lag_le_2 = L2.le

* 3. Graphing

** 3.1 Scatter plot

twoway scatter le_male le_female

*** 3.1.1 Scatter plot with country labels

twoway scatter le_male le_female, mlabel(year)

*** 3.1.2 Scatter plot with regression line

twoway lfit  le_male le_female ||  scatter le_male le_female

** 3.2 Bar chart stacked

*twoway
twoway (tsline le_b, recast(bar)) (tsline le , recast(bar)), ytitle(y title) title(Cool title)

*** 3.3 Line chart

twoway (line le year)

*** 3.3.1 Line chart with two y-axis

twoway (line le year, lwidth(thick)) (line le_male year, yaxis(2))

** 3.4 Labeling & Saving

*** 3.4.1 Saving graph

twoway scatter le le_male
graph save Graph "`direct_graphs'_scatter", replace

* 4. Regression

** 4.1.1 Basic regression

sysuse auto.dta, clear
reg price mpg

** 4.1.2 Regression while controlling for heteroskedasticity

reg price mpg, robust

** 4.1.3 Regression by country

reg price mpg if length>200, robust 

** 4.1.4 Regression with many variables

local variable_list "price mpg weight length"
reg foreign `variable_list', robust
