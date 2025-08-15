# Author: Mahad Ismail
# Project setup
required <- c("tidyverse","ggrepel","broom","randomForest","car","knitr")
to_install <- setdiff(required, rownames(installed.packages()))
if (length(to_install)) install.packages(to_install)
invisible(lapply(required, library, character.only = TRUE))

DATA_DIR <- "data"
FIG_DIR  <- "figs"
if (!dir.exists(FIG_DIR)) dir.create(FIG_DIR, recursive = TRUE)
