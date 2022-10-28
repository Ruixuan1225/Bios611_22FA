# Bios611_22FA

Dataset link:
https://www.kaggle.com/datasets/sulianova/cardiovascular-disease-dataset

My project intend to build some machine model to predict if a person will 
have cardiovascular or not. The target is to see the presence or absence 
of cardiovascular disease. The reason why I choose this dataset is because 
I think it inlude enough features to analysis and all of this features are 
easy to get for the future patient.This dataset includes 70,000 
patients' information include objective features like weight, height, age 
and gender, examination features include systolic blood pressure, diastolic 
blood pressure, cholesterol, glucose) and also some subjective features 
like whether the patient smoking or not, take alcohol or not, does the 
patient do exercise.

Library Install: 
Use docker build . -t 611, preinstall all the libraries

RUN Docker:
docker run -v "$(pwd)":/home/rstudio/work -e PASSWORD=hello -p 8787:8787 -it 611
