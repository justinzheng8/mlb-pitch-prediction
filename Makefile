# Makefile for MLB Pitch Prediction Project

ENV_NAME = mlb-pitch-prediction

.PHONY: all setup build test run clean

all: setup build test

setup:
    conda env create -f environment.yml || conda env update -f environment.yml
    @echo "Environment $(ENV_NAME) created/updated."

build:
    @echo "Building project..."
    @mkdir -p notebooks/plots
    @echo "Project build complete."

test:
    pytest -v

run:
    jupyter nbconvert --execute --to html notebooks/data_collection+baseline_model_final.ipynb --output notebooks/data_collection+baseline_model_final.html
    jupyter nbconvert --execute --to html notebooks/data_exploration_final.ipynb --output notebooks/data_exploration_final.html
    jupyter nbconvert --execute --to html notebooks/feature_eng+modeling_final.ipynb --output notebooks/feature_eng+modeling_final.html
    @echo "All notebooks executed and converted to HTML."

clean:
    rm -rf notebooks/*.html notebooks/plots/*.png notebooks/plots/*.pdf
    @echo "Cleaned generated files."
