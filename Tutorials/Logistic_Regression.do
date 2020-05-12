

* Example 1:
** Example URL:   https://stats.idre.ucla.edu/other/mult-pkg/faq/general/faq-how-do-i-interpret-odds-ratios-in-logistic-regression/


* 1.1 Download
import delimited "https://stats.idre.ucla.edu/wp-content/uploads/2016/02/sample.csv", clear


* 1.2 Logistic regression: when X=dummy (e.g. gender, poverty)
*Note: including ", or" shows odds ratios
logit hon female, or


** 1.2.1 Interpretation: 
*** Odds for female are about 81% higher than the odds for males.

** 1.3 Logistic regression: when X=continiuous (e.g. age, weight)
logit hon math, or

** 1.3.1 Interpretation:  
** For a one-unit increase in math score, we expect to see about 17% increase in the odds of being in an honors class.  



* Example 2:
** Example URL:  https://stats.idre.ucla.edu/stata/dae/logistic-regression/

* 2.1 Download
use "https://stats.idre.ucla.edu/stat/stata/dae/binary.dta", clear

* 2.2 Logistic regression:
logit admit gre gpa i.rank, or

* 2.2.1 Interpretation:
* A one unit increase in gre score increases chances of being admitted to graduate stchool by .002%. Thus 100 unit in GRE scores increases chances of being admitted by 0.1%

*For a one unit increase in gpa, the odds of being admitted to graduate school (versus not being admitted) increase by a factor of 2.23. (120%)



* Other resources:
*1. https://sociology.fas.harvard.edu/files/sociology/files/logistic_regression_analysis.pdf

*2. https://www3.nd.edu/~rwilliam/stats3/index.html
