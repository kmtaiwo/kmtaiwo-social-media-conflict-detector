# kmtaiwo-social-media-conflict-detector
ML classifier detecting high-conflict social media interactions using scikit-learn

# Social Media Conflict Detection (Binary Classification)

**Author:** Kola Taiwo  

This README documents the **machine learning implementation** for predicting **high vs. low interpersonal conflict** from anonymized social-media usage and engagement data (ages 16–25, multiple countries). It is written to stand alone in a **dedicated GitHub repository** (fork or new repo) while remaining compatible with the broader **Social Sphere** student analytics context.

---

## Problem definition

- **Original target:** `Conflicts_Over_Social_Media` on an ordinal scale **0–5** (0 = none, 5 = severe).
- **Reframed task:** **Binary classification** for clearer decisions in content moderation and platform safety:
  - **High conflict (positive class):** score **≥ 4**
  - **Low conflict (negative class):** score **≤ 3**
- **Primary metric:** **F1-score** (balances missing high-conflict cases vs. over-flagging).
- **Secondary metrics:** Accuracy, precision, recall (class 1), ROC-AUC, confusion matrices.

### Why threshold ≥ 4 is not arbitrary

The cut at **4** is justified by **scale semantics** (4–5 are the elevated end of 0–5), **class balance** (keeps the positive class frequent enough to train and evaluate stably), and **operational trade-offs**: a lower threshold (e.g. 3) inflates alert volume and moderation load; a higher threshold (e.g. 5 only) misses many meaningful cases. **4** targets clearly elevated conflict while keeping workload and label separation manageable—aligned with the notebook’s explicit threshold reasoning.

---

## Data and preprocessing

- Preprocessing: numeric scaling, one-hot encoding of categoricals (e.g. academic level, platform, relationship status), **`Country` encoded** for modeling (not dropped for this supervised task).
- **Train / test split:** 80% / 20%, `stratify=y_conflict`, `random_state=42`.
- **Feature selection:** **SelectKBest** with **F-test (`f_classif`)**, **k = 15** features, fit on training data only; same transform applied to test.

---

## Models compared

| Model | Role |
|--------|------|
| **Logistic Regression (default)** | Baseline. |
| **Logistic Regression (`class_weight='balanced'`)** | Handles class imbalance; **recommended for deployment** in this analysis. |
| **Random Forest** | Nonlinear benchmark (e.g. `n_estimators=100`, `max_depth=10`). |

**MLflow** can be used to track experiments (`conflict_classification_v2` pattern in the notebook).

---

## Evaluation philosophy

1. **Train vs. test:** Same metrics on **train** and **test** to detect **overfitting** (large gap → model memorizing training data).
2. **Bias–variance:** **Balanced LR** tends toward **higher bias, lower variance** (stable, interpretable). **RF** can show **lower bias, higher variance**; if train performance is much better than test with only a small test gain over LR, RF is likely **overfitting**—address with **regularization** (e.g. lower `max_depth`, higher `min_samples_leaf`, `max_features`, optional `max_samples`) or prefer LR for a first deployment.
3. **Generalization across countries:** A good overall F1 does **not** guarantee performance on **future cohorts or new countries**. Mitigations: report metrics **by country** (or region), use **country holdout** validation when possible, and monitor **distribution shift** when deploying to new geographies.

---

## Deployment recommendation (junior–mid level, “ship today”)

For a **first production cut**, **Balanced Logistic Regression** is a strong choice: **interpretable** (coefficients), **stable** train–test behavior, **simpler** to monitor and explain than a tuned forest—while RF remains useful as a **benchmark** and for **feature importance** comparison.

---

## Repository layout (typical)



├── README.md

├── requirements.txt

├── notebooks

│ ├── eda_kmtaiwo.ipynb

│ ├── mlf_predictive_task_conflict_classifier.ipynb # Main conflict-classification pipeline

│ ├── mlf_predictive_task_addiction_level-regressor.ipynb

│ └── mlf_clustering_model.ipynb

├── data/ # e.g. ssma.csv (if included)

├── models/ # Serialized models (if committed)

└── app.py # Optional Streamlit app (separate deliverable)


---

## Quick start (notebooks)

python -m venv .venv

.venv\Scripts\activate          # Windows

pip install -r requirements.txt

jupyter notebook notebooks/mlf_predictive_task_conflict_classifier.ipynb

