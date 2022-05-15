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
     package     * version date       lib source        
     cli           3.2.0   2022-02-14 [1] CRAN (R 4.1.2)
     digest        0.6.29  2021-12-01 [1] CRAN (R 4.1.0)
     evaluate      0.15    2022-02-18 [1] CRAN (R 4.1.2)
     fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.1.0)
     htmltools     0.5.2   2021-08-25 [1] CRAN (R 4.1.0)
     knitr         1.38    2022-03-25 [1] CRAN (R 4.1.2)
     magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.1.2)
     rlang         1.0.2   2022-03-04 [1] CRAN (R 4.1.0)
     rmarkdown     2.14    2022-04-25 [1] CRAN (R 4.1.0)
     rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.1.0)
     sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.1.0)
     stringi       1.7.6   2021-11-29 [1] CRAN (R 4.1.0)
     stringr       1.4.0   2019-02-10 [1] CRAN (R 4.1.0)
     withr         2.5.0   2022-03-03 [1] CRAN (R 4.1.0)
     xfun          0.30    2022-03-02 [1] CRAN (R 4.1.2)
     yaml          2.3.5   2022-02-21 [1] CRAN (R 4.1.2)

    [1] /Library/Frameworks/R.framework/Versions/4.1/Resources/library
