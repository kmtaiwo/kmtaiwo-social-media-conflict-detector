# Social Media Conflict Detection (Binary Classification)

**Author:** [Kola Taiwo](https://github.com/kmtaiwo)  
**Repository:** [kmtaiwo/kmtaiwo-social-media-conflict-detector](https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector)

Standalone project focused on **binary classification** of self-reported interpersonal conflict related to social media, for **content moderation** and **platform safety** use cases.

---

## Problem definition

| Item | Definition |
|------|------------|
| **Original target** | `Conflicts_Over_Social_Media` on an ordinal scale **0–5** (0 = none, 5 = severe). |
| **Reframed task** | **Binary classification** for clearer operational decisions. |
| **Positive class (high conflict)** | Score **≥ 4** |
| **Negative class (low conflict)** | Score **≤ 3** |
| **Primary metric** | **F1-score** — balances missing true high-conflict cases vs. over-flagging low-conflict users. |
| **Secondary metrics** | Accuracy, precision & recall for **class 1**, ROC-AUC, confusion matrices. |

### Why threshold ≥ 4 is not arbitrary

The cut at **4** is justified by:

1. **Scale semantics** — On 0–5, scores **4–5** represent the **elevated** end of conflict severity.  
2. **Class balance** — Keeps the positive class frequent enough to **train and evaluate** the model stably (not dominated by a tiny minority class).  
3. **Operational trade-offs** — A **lower** threshold (e.g. 3) increases alert volume and **moderation load**; a **higher** threshold (e.g. only 5) **misses** many meaningful high-conflict cases.  
4. **4** targets **clearly elevated** conflict while keeping workload and **label separation** manageable — aligned with explicit threshold reasoning in the analysis notebook.

---

## Repository layout

```
kmtaiwo-social-media-conflict-detector/
├── README.md                 # This file
├── requirements.txt          # Python dependencies for the notebook
├── PUSH_TO_GITHUB.md         # How to push to GitHub without touching the monorepo
├── .gitignore
├── data/
│   └── README.md             # How to obtain the dataset (see below)
├── notebooks/
│   └── mlf_predictive_task_conflict_classifier.ipynb
└── scripts/
    └── sync-to-github-clone.ps1   # Optional: copy this package into your local repo clone
```

This package contains **only** the conflict-classification notebook and docs from the author’s submission path (`kola-taiwo`). It does **not** include other team members’ submissions.

---

## Data

The notebook expects the Social Sphere dataset (e.g. `ssma.csv`) with columns used in preprocessing.  

- Place your CSV in **`data/`** and adjust the notebook’s **load path** if needed (e.g. `data/ssma.csv`).  
- Do **not** commit restricted data unless your license allows it. See **`data/README.md`**.

---

## Quick start

```bash
cd kmtaiwo-social-media-conflict-detector
python -m venv .venv
# Windows:
.venv\Scripts\activate
# macOS/Linux:
# source .venv/bin/activate

pip install -r requirements.txt
jupyter notebook notebooks/mlf_predictive_task_conflict_classifier.ipynb
```

---

## Optional: full Social Sphere monorepo

The **original course / team project** (including Streamlit app, other notebooks, and team submissions) remains in the separate **Social-Sphere-Project** repository — **nothing is removed** by this standalone package.

---

## License

Use the dataset and code in line with your course, team, and organization’s rules.
