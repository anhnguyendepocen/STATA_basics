
* A.1 Import data
use "Panel.dta", clear

*A.2 Sort
sort country year

*A.3 xtset
xtset country year

*1. Baseline regression
reg y x1 x2 x3

*2. Fixed effects
xtreg y x1 x2 x3, fe cluster(country)

*3. Random effects
xtreg y x1 x2 x3, re cluster(country)

*4. Including year effects
xtreg y x1 x2 x3 i.year, re cluster(country)
