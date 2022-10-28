.PHONY: clean
.PHONY: d3-vis
.PHONY: visualization

clean:
	rm -rf models
	rm -rf figures
	rm -rf derived_data
	rm -rf sentinels
	rm -rf .created-dirs
	rm -f writeup.pdf

.created-dirs:
	mkdir -p output
	mkdir -p figures

output/scaled_data.csv figures/height_weight.png:cardio_training.R source_data/cardio_train.csv .created-dirs\
	Rscript cardio_training.R




# Build the final report for the project
writeup.pdf: figures/height_weight.png
	pdflatex writeup.tex

report.pdf: figures/height_weight.png
	R -e "rmarkdown::render(\"writeup.Rmd\", output_format=\"pdf_document\")"
