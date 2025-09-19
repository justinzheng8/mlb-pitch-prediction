# Project Proposal: Predicting MLB Pitch Types

## Description of the Project
This project will use pitch-by-pitch Major League Baseball (MLB) data to predict which type of pitch (fastball, slider, curveball, changeup, etc.) a pitcher is most likely to throw next. Anticipating pitch types is an important part of baseball strategy, and this project will explore whether machine learning models can accurately model a pitcher’s decision-making based on game context.

## Goal(s)
- **Primary Goal:** Build a machine learning model that predicts the next pitch type with accuracy significantly higher than a baseline predictor (e.g., always guessing the pitcher’s most frequently used pitch).
- **Secondary Goals:**
  - Determine which features (count, inning, pitcher tendencies, batter handedness) are most predictive of pitch choice.
  - Visualize how pitch selection changes depending on game state and previous pitch sequences.

## Data Collection
We will use **Statcast data**, which is publicly available from MLB’s Baseball Savant database. Data can be accessed programmatically using the `pybaseball` Python library. We will collect:
- Pitch type (fastball, slider, etc.)
- Count (balls and strikes)
- Pitcher and batter IDs
- Inning, outs, runners on base, and score differential
- Previous pitch types in the at-bat

## Modeling Plan
This is a multiclass classification problem. Planned models include:
- **Baseline Model:** Always predict the most common pitch type for a given pitcher.
- **Machine Learning Models:** Decision Tree, Random Forest, and XGBoost to learn non-linear relationships between game context and pitch choice.
- We may experiment with a simple neural network if time permits.

## Visualization Plan
- Distribution of pitch types by count (heatmap).
- Sankey diagram or bar chart showing most common pitch sequences.
- Confusion matrix comparing predicted vs. actual pitch types.
- Feature importance plots to show which factors most influence the prediction.

## Test Plan
We will split the dataset chronologically:
- **Training Set:** Games from April–August.
- **Test Set:** Games from September.
This ensures that the model is evaluated on data from later in the season, simulating real-world prediction. We will evaluate model performance using:
- Accuracy (overall correct predictions)
- Macro F1 score (to avoid bias toward common pitch types)
- Per-class recall (to measure performance on rare pitch types)