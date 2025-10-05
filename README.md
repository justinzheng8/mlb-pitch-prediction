# MLB Pitch Prediction Project Proposal

## Description of the Project
Pitch selection is a critical strategic decision in baseball. Our project aims to build a machine learning system that predicts the type of pitch a pitcher will throw (e.g., fastball, slider, curveball) given contextual features such as the count, game situation, and pitcher identity. Accurate pitch prediction could provide valuable insights into pitcher behavior and strategy.

## Goals
- **Primary Goal:** Successfully predict the pitch type on a given pitch event.  
- **Secondary Goal:** Compare the performance of a **universal model** (one model across all pitchers) versus **pitcher-specific models** (customized for individual pitchers).  
- **Research Goal:** Identify which contextual variables (count, inning, score differential, base runners, etc.) most strongly influence pitch selection.

This is framed as a **multi-class classification problem**, where the target variable is **pitch type**.

## Data Collection
We will use the [pybaseball](https://github.com/jldbc/pybaseball) Python package to collect Statcast data. This dataset provides pitch-level information such as pitch type, velocity, spin rate, pitcher, batter, game context, and outcomes.  

- **Timeframe:** We plan to use a **single MLB season (2023)** for feasibility. If time and resources permit, we may expand to multiple seasons.  
- **Data Volume Consideration:** A single season contains hundreds of thousands of pitch events, which should be sufficient for training but still computationally manageable.  
- **Key Variables to Collect:**  
  - **Predictors:** Count, inning, score differential, base runners, outs, pitcher ID, batter ID, handedness, velocity, spin rate, etc.  
  - **Target:** Pitch type (multi-class label).  

## Modeling Plan
This is a multi-class classification problem. Planned models include:  
- **Baseline:** Always predict the most common pitch type for each pitcher.  
- **Universal Model:** Train a single model across all pitchers to capture generalizable patterns.  
- **Pitcher-Specific Models:** Compare performance by training models for individual pitchers with large enough sample sizes.  
- **Machine Learning Models:** Decision Tree, Random Forest, and XGBoost to capture complex, non-linear relationships between features and pitch type.  
- **Validation:** Use a separate validation set to tune hyperparameters and select models before final testing.  
- If time permits, we may explore a simple neural network to model pitch sequences.

## Visualization Plan
We plan to use several visualizations to understand the data and results:  
- Heatmaps of pitch type distributions by count and pitcher.  
- Scatter plots of pitch velocity vs. spin rate, colored by pitch type.  
- Interactive plots (e.g., Plotly) showing pitch distributions across game situations.  
- Confusion matrices to visualize which pitch types are most frequently misclassified.  
- Feature importance plots for tree-based models.  

## Test Plan
We will split the dataset chronologically to mimic real-world prediction:  
- **Training Set:** Games from April–July.  
- **Validation Set:** Games from August (used for hyperparameter tuning and model selection).  
- **Test Set:** Games from September (held out for final evaluation only).  

This ensures that the model:  
1. Learns from early-season data.  
2. Is tuned using mid-season data.  
3. Is evaluated on unseen late-season data, simulating real-world deployment.  

We will evaluate performance using:  
- **Accuracy:** Overall correctness.  
- **Macro F1 Score:** To avoid bias toward common pitch types.  
- **Per-Class Recall:** To evaluate rare pitch prediction.  

If computation on the full season proves infeasible, we will sample subsets of pitchers or games while maintaining the same train/validation/test design.  

---
