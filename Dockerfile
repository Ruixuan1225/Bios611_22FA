FROM rocker/verse

RUN Rscript --no-restore --no-save -e "install.packages('tidyverse')"

RUN Rscript --no-restore --no-save -e "install.packages('mltools')"

RUN Rscript --no-restore --no-save -e "install.packages('data.table')"

RUN Rscript --no-restore --no-save -e "install.packages('corrplot')"

RUN Rscript --no-restore --no-save -e "install.packages('caTools')"

RUN Rscript --no-restore --no-save -e "install.packages('car')"

RUN Rscript --no-restore --no-save -e "install.packages('rpart')"

RUN Rscript --no-restore --no-save -e "install.packages('rpart.plot')"

RUN Rscript --no-restore --no-save -e "install.packages('naivebayes')"

RUN Rscript --no-restore --no-save -e "install.packages('dplyr')"

RUN Rscript --no-restore --no-save -e "install.packages('ggplot2')"

RUN Rscript --no-restore --no-save -e "install.packages('psych')"
