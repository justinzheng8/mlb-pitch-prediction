# MLB Pitch Prediction – Midterm Report

**YouTube Presentation:** https://youtu.be/huFFxoI5bcw

---

## 1. Project Overview

Pitch selection is a core component of baseball strategy, reflecting a pitcher’s ability to deceive batters and exploit weaknesses. This project aims to build a machine learning model capable of predicting the type of pitch (e.g., fastball, slider, curveball, etc.) based on contextual information available at the time of each pitch.

By modeling pitch tendencies, we can gain insight into pitcher decision-making, batter-pitcher dynamics, and game context. The ultimate goal is to identify meaningful patterns that explain *why* certain pitches are thrown in specific situations.

### Goals
- **Primary Goal:** Predict pitch type using contextual, physical, and categorical features.
- **Secondary Goals:**
  - Compare pitcher-independent (global) models vs. pitcher-specific models.
  - Identify which variables (count, inning, release metrics, handedness, etc.) are most influential in pitch selection.

## 2. Data Collection

The dataset was collected using the [Statcast](https://baseballsavant.mlb.com) system through the `pybaseball` Python package, which provides public access to MLB’s tracking data.

- **Source:** Statcast via `pybaseball`
- **Timeframe:** Full 2023 MLB regular season (March 30 – October 1)
- **Number of records:** 717,945 pitches  
- **Number of columns:** 118  
- **File name:** `statcast_2023.csv`

Each record represents a single pitch, including detailed measurements such as velocity, spin, release point, and contextual information (e.g., inning, count, pitcher/batter identifiers).

## 3. Data Processing

The original dataset contained 118 columns, many of which are irrelevant to pitch type prediction (e.g., stadium data, team names, fielding events).  
For modeling purposes, the following columns were selected:

| Feature | Description |
|----------|--------------|
| `pitch_type` | The categorical label we are predicting (e.g., FF = Four-seam Fastball, SL = Slider, CH = Changeup). |
| `release_speed` | The velocity of the pitch in mph at release. |
| `release_pos_x` | The horizontal position of the ball at release (in feet). |
| `release_pos_z` | The vertical position of the ball at release (in feet). |
| `pitcher` | Pitcher ID (numeric). |
| `batter` | Batter ID (numeric). |
| `balls` | Current number of balls in the count. |
| `strikes` | Current number of strikes in the count. |
| `outs_when_up` | Number of outs when the pitch was thrown. |
| `inning` | The inning in which the pitch occurred. |
| `stand` | Batter handedness (`L` or `R`). |
| `p_throws` | Pitcher handedness (`L` or `R`). |

### Cleaning Steps
1. **Subset selection:** Reduced the dataset to only the columns relevant for pitch prediction.
2. **Handling missing values:**  
   - Checked for missing data in all relevant columns.
   - Dropped rows where `pitch_type` or `release_speed` was missing, since they are essential for supervised learning.
   - Resulting dataset size: **717,671 rows**.
3. **Data consistency checks:**  
   - Verified that all categorical values (`stand`, `p_throws`) were valid (`L` or `R`).  
   - Confirmed that numeric columns contained valid ranges (no negative inning counts, etc.).
4. **Exploratory statistics:**  
   - Found **17 unique pitch types**.
   - Most common pitch: **Four-seam fastball (FF)** with 230,309 occurrences.

4. Preliminary Visualizations
(1) Pitch Type Distribution

This plot shows how frequently each pitch type appears. The dataset is dominated by fastballs (FF), followed by sliders (SL) and sinkers (SI).

<img width="876" height="476" alt="image" src="https://github.com/user-attachments/assets/87e7adef-b538-45bb-a656-f23b63890894" />

Interpretation:
Pitch frequency varies significantly, with a long tail of rare pitch types (e.g., knuckleballs, screwballs). This indicates potential class imbalance, which must be handled carefully during model training.

(2) Pitch Speed by Pitch Type

This boxplot illustrates velocity differences between pitch types.

<img width="1005" height="557" alt="image" src="https://github.com/user-attachments/assets/adea3b1a-33cd-40eb-be6a-e8a5f457dc30" />

Interpretation:
Fastballs (FF) have the highest velocity, typically around 95–100 mph. Off-speed pitches like changeups (CH) and sliders (SL) are slower.
The clear separation by velocity suggests that release speed will be a strong predictor in our models.

(3) Release Position Scatter (X vs Z)

A sample of 5,000 pitches was plotted to visualize the relationship between horizontal and vertical release points.

<img width="678" height="547" alt="image" src="https://github.com/user-attachments/assets/ad5a75bc-5705-41b3-be4a-8bc05b4ee40e" />

Interpretation:
Distinct clusters emerge for different pitch types, suggesting that release mechanics play a key role in pitch classification.

5. Modeling Methods
(a) Modeling Objective:
The goal is to build a supervised classification model that predicts pitch_type based on contextual and physical features.

(b) Modeling Approach:
For the midterm stage, a baseline model was implemented to establish a lower bound of performance.

Baseline Model:
Predict the most common pitch type (FF) for every observation.

Purpose: Benchmark to measure future improvements against.

Output:
Most common pitch type: FF
Baseline accuracy: 0.3209

(c) Interpretation
A model that always predicts “fastball” achieves 32.09% accuracy.
This baseline provides a useful reference point — any model trained later (Decision Tree, Random Forest, XGBoost, etc.) should aim to outperform this benchmark significantly.

6. Preliminary Results Summary
-The data is imbalanced, favoring fastballs, sliders, and sinkers.
-Strong preliminary visual patterns suggest that release speed and release position are among the most discriminative features.
-The baseline model provides a meaningful benchmark for evaluating future models.

7. Next Steps
Feature Engineering"
One-hot encode categorical variables (stand, p_throws).
Possibly engineer interaction features (e.g., count-based pressure, previous pitch type).

Model Development:
Implement Decision Tree and Random Forest models for multi-class classification.
Evaluate accuracy, precision, recall, and F1-score.

Validation Framework:
Split data into train/validation/test sets using time-based segmentation (e.g., April–July train, August validation, September test).

Visualization:
Create confusion matrices and feature importance plots.

Model Interpretation:
Identify which features most influence pitch selection.

8. Environment and Dependencies
-Language: Python 3.x
-Environment: Google Colab

Key Libraries:
pandas – data manipulation
matplotlib & seaborn – visualization
scikit-learn – modeling and evaluation
pybaseball – data collection from Statcast
