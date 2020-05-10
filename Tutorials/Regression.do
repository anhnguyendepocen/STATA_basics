
* Tips for running regressions

* A.1 Import data
sysuse auto.dta, clear


* 1. Before runnning regressions

** 1.1 Show summary statistics of regressors
sum price length mpg trunk weight foreign headroom 


//NOTE: Make sure that dummies are 0 and 1!!! Easier to interpret for regressions


** 1.2 Correlation matrix of regressors
corr price length mpg trunk weight foreign headroom 


* 2. Output regression to csv
ssc install estout

**2.1 Baseline regressions
*Reg 1
reg price length mpg trunk weight foreign headroom , robust
estimates store reg1 //Store results

*Reg 2
reg price length mpg trunk weight foreign, robust
estimates store reg2 //Store results

*Reg 3
reg price length mpg trunk weight foreign headroom , robust
estimates store reg3 //Store results

esttab reg1 reg2 reg3 using regression_results.csv, se star( * 0.10 ** 0.05 *** 0.010) ar2(4)


* 3. Categorical variables

* use the i. command

reg price length mpg trunk weight foreign i.rep78


* 4. T-tests
ttest mpg, by(foreign)
