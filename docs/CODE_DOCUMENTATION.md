# Code Documentation

This document describes the organization and main responsibilities of the source code associated with the paper **"Network Flow Integration to Improve Generalization of Machine Learning-Based IDS"**.

## Notebook Organization

The artifact contains nine independent Jupyter notebooks. Each notebook corresponds to one experiment in the paper and follows a common processing sequence:

1. experiment configuration and dataset paths;
2. dataset loading and preprocessing;
3. target-domain flow selection and leakage-safe integration;
4. feature scaling and, when applicable, PCA or Chi-Square feature intervention;
5. XGBoost model training;
6. intraset and/or interset evaluation; and
7. result reporting and diagnostic visualization.

The helper functions used in each notebook contain docstrings describing their purpose. Configuration parameters are kept near the beginning of each notebook so that dataset paths and experiment-specific parameters can be located without modifying the implementation cells.

## Files and Responsibilities

| File | Paper experiment | Intervention | Main responsibility |
|---|---:|---|---|
| `notebook_1.ipynb` | 1 | IN1 - Benign | Integrates benign target-domain flows and evaluates binary IDS generalization. |
| `notebook_2.ipynb` | 2 | IN1 - Malicious | Integrates labeled (D)DoS target-domain flows and evaluates multiclass IDS behavior. |
| `notebook_3.ipynb` | 3 | IN1 - Mixed | Jointly integrates benign and (D)DoS target-domain flows. |
| `notebook_4.ipynb` | 4 | IN2 - PCA + Benign | Combines benign-flow integration with PCA using 25 principal components. |
| `notebook_5.ipynb` | 5 | IN2 - PCA + Malicious | Combines (D)DoS-flow integration with PCA. |
| `notebook_6.ipynb` | 6 | IN2 - PCA + Mixed | Combines mixed-flow integration with PCA. |
| `notebook_7.ipynb` | 7 | IN3 - Chi-Square + Benign | Combines benign-flow integration with selection of 25 features using Chi-Square. |
| `notebook_8.ipynb` | 8 | IN3 - Chi-Square + Malicious | Combines (D)DoS-flow integration with Chi-Square feature selection. |
| `notebook_9.ipynb` | 9 | IN3 - Chi-Square + Mixed | Combines mixed-flow integration with Chi-Square feature selection. |

## Main Function Groups

Although each notebook is self-contained, the helper functions follow the same conceptual groups.

### Data loading and preparation

Functions such as `load_dataset`, `remove_non_model_columns`, `drop_non_feature_columns`, `encode_categorical_columns`, `encode_categorical_features`, `standardize_numeric_types`, and `standardize_numeric_dtypes` load the processed CSV files and prepare compatible feature representations.

### Flow selection and integration

Functions such as `select_first_benign_flows`, `select_class_subset`, `build_mixed_flow_subset`, `integrate_benign_flows`, `integrate_class_flows`, `integrate_mixed_flows`, and `integrate_flows_by_timestamp` implement the controlled instance-level interventions. Selected target-domain flows are removed from the target test data before integration to prevent leakage, while corresponding source-domain flows are removed to control training-set size.

### Feature-level interventions

Experiments 4-6 use `PCA` after feature scaling. Experiments 7-9 use `SelectKBest(score_func=chi2, k=25)` after Min-Max scaling so that the Chi-Square statistic receives non-negative inputs.

### Model construction and evaluation

Functions such as `build_xgboost_model`, `evaluate_binary_classifier`, `evaluate_model`, `compute_metrics`, and `compute_false_alarm_rate` train or evaluate XGBoost models and calculate the IDS metrics used in the paper. Plotting helpers produce confusion matrices, ROC curves, precision-recall curves, feature-importance plots, and PCA diagnostics where applicable.

## Traceability to the Paper

The nine notebooks are grouped around the three principal experimental findings discussed in the paper.

| Paper finding | Experiments | Artifact | Main paper evidence |
|---|---|---|---|
| Integrating only benign target-domain flows can reduce class separability and compromise attack detection. | 1, 4, 7 | `notebook_1.ipynb`, `notebook_4.ipynb`, `notebook_7.ipynb` | Tables 3, 6, 9; Figures 3 and 7(a) |
| Integrating malicious (D)DoS flows increases sensitivity to the integrated attack class but can reduce balance across other classes. | 2, 5, 8 | `notebook_2.ipynb`, `notebook_5.ipynb`, `notebook_8.ipynb` | Tables 4, 7, 10; Figures 4 and 7(b) |
| Mixed integration provides the most balanced behavior among the evaluated strategies, with the strongest overall result when combined with feature selection. | 3, 6, 9 | `notebook_3.ipynb`, `notebook_6.ipynb`, `notebook_9.ipynb` | Tables 5, 8, 11, 12; Figures 5 and 7(c) |

This mapping allows a reviewer to move directly from a conclusion in the paper to the notebook responsible for the corresponding experimental intervention.

## Maintainability Notes

- Each notebook is intentionally self-contained so that an individual experiment can be inspected or executed without importing code from another notebook.
- Reusable operations are implemented as named helper functions rather than repeated inline blocks within the same notebook.
- Experiment-specific parameters, including dataset paths, integration rates, random seed, and number of PCA components or selected features, are defined in configuration cells near the beginning of each notebook.
- `RANDOM_STATE = 42` is used where stochastic model/split behavior must be controlled.
- Generated results should be kept separate from source notebooks so that code and outputs remain easy to identify.

