library(readxl);
library(tidyverse);

data <- read.csv("source_data/cardio_train.csv", header=TRUE, sep=";");

#scale the data
scaled <- as.data.frame(scale(data[,2:12], center=TRUE,scale= TRUE));

write.csv(scaled, "output/scaled_data.csv");