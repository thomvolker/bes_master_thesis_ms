# Volker & Klugkist “Combining support for hypotheses over heterogeneous studies with Bayesian Evidence Synthesis: A simulation study”

This repository contains all code (and results) of the simulations. This
repository consists of five folders.

| Folder            | Content                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|:------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| manuscript        | Contains all files belonging to the manuscript <br> - References in `thesis.bib` <br> - Stylesheet for Journal of Mathematical Psychology <br> - Text and code to create figures in `manuscript_volker.Rmd` <br> - Output document `manuscript_volker.pdf` <br> - Required `Latex` packages in `preamble.tex` <br> - Required frontpage in `frontmatter.tex`                                                                                                                                                                                                                    |
| scripts           | All scripts of the simulations. <br> `00_run_simulations.R` - This script loads all required packages (install first, if required) and runs all individual simulation scripts. <br> `[simulation-number]_[simulation-title].R` - All individual simulation scripts are numbered such that they correspond to the simulations in the paper. <br> `functions.R` - Is a separate file that contains functions to simulate data and obtain results. <br> Note that the code to create the figures and tables in the paper are specified in the `.Rmd` file `manuscript_volker.Rmd`. |
| output            | `[simulation-number]_[simulation-title].RData` - Output of each simulation (data.frame with all simulation outcomes).                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| DataCpp           | Contains the self-written package `DataCpp` which is required to simulate multivariate normal data in `C++` when distributing the simulations over different cores (using `R`-packages `future` and `furrr`)                                                                                                                                                                                                                                                                                                                                                                    |
| notes-other-files | Rather self explanatory, this folder contains random files and thoughts that developed somewhere during the project (this ranges from presentations about the topic, the initial project proposal, an intermediate report and some meeting notes).                                                                                                                                                                                                                                                                                                                              |

All data used in this paper is simulated, and is thus not affected by
any privacy or confidentiality concerns. Ethical approval has been
granted by the FETC at Utrecht University (application number 20-0116).

The archive is stored on
[GitHub](https://github.com/thomvolker/bes_master_thesis_ms) to ensure
that all materials are and remain openly accessible.

# Machine and package info

    ─ Session info ───────────────────────────────────────────────────────────────
     setting  value                       
     version  R version 4.1.0 (2021-05-18)
     os       macOS Big Sur 10.16         
     system   x86_64, darwin17.0          
     ui       X11                         
     language (EN)                        
     collate  en_US.UTF-8                 
     ctype    en_US.UTF-8                 
     tz       Europe/Amsterdam            
     date     2022-05-15                  

    ─ Packages ───────────────────────────────────────────────────────────────────
     package       * version    date       lib source                             
     assertthat      0.2.1      2019-03-21 [1] CRAN (R 4.1.0)                     
     backports       1.4.1      2021-12-13 [1] CRAN (R 4.1.0)                     
     bain          * 0.2.4      2020-03-09 [1] CRAN (R 4.1.0)                     
     BFpack        * 0.3.2      2021-02-02 [1] CRAN (R 4.1.0)                     
     boot            1.3-28     2021-05-03 [1] CRAN (R 4.1.0)                     
     broom           0.7.12     2022-01-28 [1] CRAN (R 4.1.2)                     
     cellranger      1.1.0      2016-07-27 [1] CRAN (R 4.1.0)                     
     cli             3.2.0      2022-02-14 [1] CRAN (R 4.1.2)                     
     codetools       0.2-18     2020-11-04 [1] CRAN (R 4.1.0)                     
     colorspace      2.0-3      2022-02-21 [1] CRAN (R 4.1.2)                     
     crayon          1.5.0      2022-02-14 [1] CRAN (R 4.1.2)                     
     DataCpp       * 1.0        2022-05-04 [1] local                              
     DBI             1.1.1      2021-01-15 [1] CRAN (R 4.1.0)                     
     dbplyr          2.1.1      2021-04-06 [1] CRAN (R 4.1.0)                     
     digest          0.6.29     2021-12-01 [1] CRAN (R 4.1.0)                     
     dplyr         * 1.0.8      2022-02-08 [1] CRAN (R 4.1.2)                     
     ellipsis        0.3.2      2021-04-29 [1] CRAN (R 4.1.0)                     
     evaluate        0.15       2022-02-18 [1] CRAN (R 4.1.2)                     
     extraDistr      1.9.1      2020-09-07 [1] CRAN (R 4.1.0)                     
     fansi           1.0.3      2022-03-24 [1] CRAN (R 4.1.0)                     
     fastmap         1.1.0      2021-01-25 [1] CRAN (R 4.1.0)                     
     forcats       * 0.5.1      2021-01-27 [1] CRAN (R 4.1.0)                     
     fs              1.5.2      2021-12-08 [1] CRAN (R 4.1.0)                     
     furrr         * 0.2.3.9000 2021-10-11 [1] Github (DavisVaughan/furrr@4068c95)
     future        * 1.22.1     2021-08-25 [1] CRAN (R 4.1.0)                     
     generics        0.1.2      2022-01-31 [1] CRAN (R 4.1.2)                     
     ggplot2       * 3.3.5      2021-06-25 [1] CRAN (R 4.1.0)                     
     globals         0.14.0     2020-11-22 [1] CRAN (R 4.1.0)                     
     glue            1.6.2      2022-02-24 [1] CRAN (R 4.1.2)                     
     gtable          0.3.0      2019-03-25 [1] CRAN (R 4.1.0)                     
     haven           2.4.1      2021-04-23 [1] CRAN (R 4.1.0)                     
     hms             1.1.1      2021-09-26 [1] CRAN (R 4.1.0)                     
     htmltools       0.5.2      2021-08-25 [1] CRAN (R 4.1.0)                     
     httr            1.4.2      2020-07-20 [1] CRAN (R 4.1.0)                     
     jsonlite        1.8.0      2022-02-22 [1] CRAN (R 4.1.2)                     
     knitr           1.38       2022-03-25 [1] CRAN (R 4.1.2)                     
     lattice         0.20-44    2021-05-02 [1] CRAN (R 4.1.0)                     
     lavaan          0.6-8      2021-03-10 [1] CRAN (R 4.1.0)                     
     lifecycle       1.0.1      2021-09-24 [1] CRAN (R 4.1.0)                     
     listenv         0.8.0      2019-12-05 [1] CRAN (R 4.1.0)                     
     lme4            1.1-27.1   2021-06-22 [1] CRAN (R 4.1.0)                     
     lubridate       1.7.10     2021-02-26 [1] CRAN (R 4.1.0)                     
     magrittr      * 2.0.3      2022-03-30 [1] CRAN (R 4.1.2)                     
     MASS            7.3-54     2021-05-03 [1] CRAN (R 4.1.0)                     
     Matrix          1.3-3      2021-05-04 [1] CRAN (R 4.1.0)                     
     minqa           1.2.4      2014-10-09 [1] CRAN (R 4.1.0)                     
     mnormt          2.0.2      2020-09-01 [1] CRAN (R 4.1.0)                     
     modelr          0.1.8      2020-05-19 [1] CRAN (R 4.1.0)                     
     munsell         0.5.0      2018-06-12 [1] CRAN (R 4.1.0)                     
     mvtnorm         1.1-2      2021-06-07 [1] CRAN (R 4.1.0)                     
     nlme            3.1-152    2021-02-04 [1] CRAN (R 4.1.0)                     
     nloptr          1.2.2.2    2020-07-02 [1] CRAN (R 4.1.0)                     
     parallelly      1.28.1     2021-09-09 [1] CRAN (R 4.1.0)                     
     pbivnorm        0.6.0      2015-01-23 [1] CRAN (R 4.1.0)                     
     pillar          1.7.0      2022-02-01 [1] CRAN (R 4.1.2)                     
     pkgconfig       2.0.3      2019-09-22 [1] CRAN (R 4.1.0)                     
     pracma          2.3.3      2021-01-23 [1] CRAN (R 4.1.0)                     
     purrr         * 0.3.4      2020-04-17 [1] CRAN (R 4.1.0)                     
     R6              2.5.1      2021-08-19 [1] CRAN (R 4.1.0)                     
     Rcpp          * 1.0.8.3    2022-03-17 [1] CRAN (R 4.1.2)                     
     RcppArmadillo * 0.11.0.0.0 2022-04-04 [1] CRAN (R 4.1.2)                     
     readr         * 2.1.0      2021-11-11 [1] CRAN (R 4.1.0)                     
     readxl          1.3.1      2019-03-13 [1] CRAN (R 4.1.0)                     
     reprex          2.0.0      2021-04-02 [1] CRAN (R 4.1.0)                     
     rlang           1.0.2      2022-03-04 [1] CRAN (R 4.1.0)                     
     rmarkdown       2.14       2022-04-25 [1] CRAN (R 4.1.0)                     
     rstudioapi      0.13       2020-11-12 [1] CRAN (R 4.1.0)                     
     rvest           1.0.1      2021-07-26 [1] CRAN (R 4.1.0)                     
     scales          1.1.1      2020-05-11 [1] CRAN (R 4.1.0)                     
     sessioninfo     1.1.1      2018-11-05 [1] CRAN (R 4.1.0)                     
     stringi         1.7.6      2021-11-29 [1] CRAN (R 4.1.0)                     
     stringr       * 1.4.0      2019-02-10 [1] CRAN (R 4.1.0)                     
     tibble        * 3.1.6      2021-11-07 [1] CRAN (R 4.1.0)                     
     tidyr         * 1.2.0      2022-02-01 [1] CRAN (R 4.1.2)                     
     tidyselect      1.1.2      2022-02-21 [1] CRAN (R 4.1.2)                     
     tidyverse     * 1.3.1      2021-04-15 [1] CRAN (R 4.1.0)                     
     tmvnsim         1.0-2      2016-12-15 [1] CRAN (R 4.1.0)                     
     tzdb            0.2.0      2021-10-27 [1] CRAN (R 4.1.0)                     
     utf8            1.2.2      2021-07-24 [1] CRAN (R 4.1.0)                     
     vctrs           0.3.8      2021-04-29 [1] CRAN (R 4.1.0)                     
     withr           2.5.0      2022-03-03 [1] CRAN (R 4.1.0)                     
     xfun            0.30       2022-03-02 [1] CRAN (R 4.1.2)                     
     xml2            1.3.3      2021-11-30 [1] CRAN (R 4.1.0)                     
     yaml            2.3.5      2022-02-21 [1] CRAN (R 4.1.2)                     

    [1] /Library/Frameworks/R.framework/Versions/4.1/Resources/library
