
*A.1 Import data
clear all
use "RCT.dta", clear

*1. Baseline regressions

reg science_2012 trt white2011 ell2011 frpl2011 urban science_2011 science_2010 
reg math_2012 trt white2011 ell2011  frpl2011 urban math_2011 math_2010
reg reading_2012 trt white2011 ell2011 frpl2011 urban reading_2011 reading_2010 


*2. Treatment on the Treated  2-stage least squares

ivregress 2sls science_2012 (rectrt = trt) white2011 ell2011 frpl2011 urban science_2011 science_2010, first
ivregress 2sls math_2012 (rectrt = trt) white2011 ell2011  frpl2011 urban math_2011 math_2010, first
ivregress 2sls reading_2012 (rectrt = trt) white2011 ell2011 frpl2011 urban reading_2011 reading_2010, first 








