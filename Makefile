.PHONY: clean/Users/orianna/Desktop/bios-611-project/Makefile
.PHONY: d3-vis
.PHONY: visualization

clean:
	rm -rf models
	rm -rf figures
	rm -rf output
	rm -rf .created-dirs
	rm -f report.pdf

.created-dirs:
	mkdir -p output
	mkdir -p figures

output/training_data.csv\
 output/testing_data.csv\
 output/final_data.csv\
 figures/boxplot_age_weight.png\
 figures/check_balance.png\
 figures/features_corr.png\
 figures/age_vs_cardio.png\
 figures/cholesterol_vs_cardio.png:.created-dirs cardio_training.R source_data/cardio_train.csv
	Rscript cardio_training.R



# Build the final report for the project

report.pdf: 
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"
