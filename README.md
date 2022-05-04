# bes_master_thesis_ms

This repository contains all code (and results) of the simulations. This 
repository contains of four folders.

| Folder | Content |
|:---- |:------------------------- |
| Manuscript | Contains all files belonging to the manuscript <br> - References in `thesis.bib` <br> - Stylesheet for Journal of Mathematical Psychology <br> - Text and code to create figures in `manuscript_volker.Rmd` <br> - Output document `manuscript_volker.pdf` <br> - Required `Latex` packages in `preamble.tex` <br> - Required frontpage in `frontmatter.tex` |
| Simulations | All scripts and output of the simulations. <br> `00_run_simulations.R` - Loads all required packages (install first, if required) runs all simulation scripts <br> `**_<simulation_title>.R` - The files to run all simulations. <br> `**_<simulation_title>.RData` <br> `functions.R` - Is a separate file that contains all functions to simulate data and obtain results. |
| DataCpp | Contains the self-written package `DataCpp` which is required to simulate multivariate normal data in `C++` when distributing the simulations over different cores (using `R`-packages `future` and `furrr`) |
| notes-other-files | Rather self explanatory, this folder contains random files and thoughts that arised somewhere during the project (this ranges from presentations about the topic, the initial project proposal, an intermediate report and some meeting notes). |
