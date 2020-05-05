
*A. Import 
**A.1 Import data
use RD.dta, clear
**A.2 Center data
replace pretest = pretest-60

*1. Program effect on test scores
**1.1 Rd yields: Bandwidth in base model
rd posttest pretest  
local base_bandwith = e(w) //scalar list: Shows list of scalars
display "Base bandwith: `base_bandwith'"



** 2.2 Create graph folder and set directory
local directory : pwd 
display "`directory'"
*mkdir Reggresion_ouput
local regout_folder "`directory'/Reggresion_ouput/"
display "`regout_folder'"

** 1.2 Estimate program effect with base bandwidth
asdoc rdrobust posttest pretest, h(`base_bandwith'), save(`regout_folder'rd_estimation.doc)
*rdrobust posttest pretest, h(`base_bandwith')

*2. Design’s validity
asdoc rddensity pretest, h(`base_bandwith'), save(`regout_folder'rddensity.doc)
*rddensity pretest, h(`base_bandwith')

*3. Graph relationship between outcome variable (test scores) and the running variable
*rddensity pretest, plot
rdplot posttest pretest, h(`base_bandwith') 
twoway scatter posttest pretest if treat==1 || scatter posttest pretest if treat==0

*4. Results from more than one specification
gen rv_treat = pretest * treat
gen bin= pretest - mod(pretest, 1) 
collapse (mean) posttest pretest treat rv_treat black frlunch gender sped , by(bin)

asdoc reg posttest treat pretest rv_treat black frlunch gender sped if abs(bin)<30, robust, save(`regout_folder'robust.doc)

 foreach i in 10 20 30{
 	reg posttest treat pretest if abs(bin)<`i', robust 
	reg posttest treat pretest rv_trea if abs(bin)<`i', robust
	reg posttest treat pretest rv_treat if abs(bin)<`i', robust
 }
