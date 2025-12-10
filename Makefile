# Makefile for MLB Pitch Prediction Project

ENV_NAME = mlb-pitch-prediction

.PHONY: all setup build test run clean

all: setup build test

setup:
	conda env create -f environment.yml || conda env update -f environment.yml
	@echo Environment $(ENV_NAME) created/updated.

build:
	@echo Building project...
	@if not exist notebooks\plots mkdir notebooks\plots
	@echo Project build complete.

test:
	pytest -v

run:
	jupyter nbconvert --execute --to html notebooks/data_collection+baseline_model.ipynb --output data_collection+baseline_model.html
	jupyter nbconvert --execute --to html notebooks/data_exploration.ipynb --output data_exploration.html
	jupyter nbconvert --execute --to html notebooks/feature_eng+modeling.ipynb --output feature_eng+modeling.html
	@echo All notebooks executed and converted to HTML.

clean:
	-del notebooks\*.html
	-del notebooks\plots\*.png
	-del notebooks\plots\*.pdf
	@echo Cleaned generated files.
