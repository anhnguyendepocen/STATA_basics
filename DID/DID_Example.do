* A.1 Import data 
use DID.dta, clear

* A.2  Reshape data: wide to long
reshape long math_ reading_ science_ white black hispanic female ell frpl total_numberofstudents, i(school_num) j(year)

* A.3 Replaces year with relation to treatment year
replace year = year-2011

* A.4 Generates year dummies
tab year, gen(y)
** A.4.1 Generates year treatment dummy
gen trt_y7 = trt*y7
sort school_num year


*1. Fixed effect regression
xtset school_num year

local regs trt_y7 trt y7 ell frpl urban hispanic black white female
local dv "science_ math_ reading_"
foreach x in `dv' {
xtreg `x' `regs', re cluster(school_num)
}


*2. Graphing  
** 2.1 Create Avg. treatment for comparison groups
sort trt year
local dv "science_ math_ reading_"
foreach x in `dv' {
egen avg_`x' = mean(`x'), by (trt year) 
}
egen tag = tag(trt year)

** 2.2 Create graph folder and set directory
local directory : pwd 
display "`directory'"
*mkdir graphs
local graphs_fol "`directory'/graphs"
display "`graphs_fol'"

* 2.3 Exports three graphs that show average test scores after treatment
local dv "avg_science_ avg_math_ avg_reading_"
foreach x in `dv' {
twoway connected `x' year if trt==0 & tag==1 ||connected `x' year if trt==1 & tag==1,legend(label(1 "Control") label(2 "Treatment")) title(`x')
graph export "`graphs_fol'/`x'_graph.png", replace
}

*3. Accounting for differences in pre-treatment trends
gen trt_year = trt* year
local regs trt_y7 trt y7 year trt_year ell frpl urban hispanic black white female
local dv "science_ math_ reading_"
foreach x in `dv' {
xtreg `x' `regs', re cluster(school_num)
}

**3.1 T-test
local regs "ell frpl urban hispanic black white female"
foreach x in `regs' {
display"`x'"
ttest `x', by(trt)
}



