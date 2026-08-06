# Reproducibility Guide

This document describes how to reproduce the principal experimental claims of the paper **"Network Flow Integration to Improve Generalization of Machine Learning-Based IDS"**. It complements the concise instructions in the repository `README.md` and is intended to provide the execution details required for the SBSeg reproducibility evaluation.

## 1. Reproduction Scope

The repository contains nine notebooks corresponding to the nine experiments reported in the paper. All notebooks can be executed independently. For a focused reproduction of the principal conclusions, Experiments 7, 8, and 9 are used because they reproduce the three flow-integration strategies combined with Chi-Square feature selection (IN3) and directly support the comparative conclusions in Section 4.4 and the paper conclusion.

| Principal claim | Experiment | Notebook | Paper evidence |
|---|---:|---|---|
| IN3 with benign-flow integration exhibits very low attack-detection capability in the evaluated CIC17 -> CIC18 scenario. | 7 | `notebooks/notebook_7.ipynb` | Table 9; Figure 7(a) |
| IN3 with malicious-flow integration strongly detects (D)DoS but exhibits a high false-alarm rate in the evaluated CIC18 -> CIC17 scenario. | 8 | `notebooks/notebook_8.ipynb` | Table 10; Figure 7(b) |
| IN3 with mixed integration provides the strongest overall result among the evaluated IN3 configurations in the CIC18 -> CIC17 scenario. | 9 | `notebooks/notebook_9.ipynb` | Tables 11 and 12; Figure 7(c) |

The remaining notebooks reproduce the corresponding IN1 and IN2 experiments and are listed in Section 7.

## 2. Reference Environment

The experiments reported in the paper were originally executed with the following environment:

| Component | Configuration |
|---|---|
| Operating system | Ubuntu 20.04.6 LTS (64-bit), Linux kernel 5.4.0-216-generic |
| Processor | Intel(R) Xeon(R) E-2224G CPU @ 3.50 GHz |
| Memory | 32 GB DDR4 RAM |
| Storage | 2 TB (1 TB SATA SSD + 1 TB HDD) |
| Python | 3.8.10 |
| Development environment | Jupyter Notebook / JupyterLab |

This is the authors' reference environment, not a strict minimum requirement. Systems with fewer resources may be able to execute the experiments but can require more memory management and longer execution time.

Execution time was **not measured as an experimental variable in the paper**. Consequently, this artifact does not provide an artificial runtime estimate. Runtime depends on hardware, dataset size, and the selected experiment.

## 3. Software Installation

Clone the repository and create the reference Python environment:

```bash
git clone https://github.com/kelsonc/paper-sbseg2026.git
cd paper-sbseg2026
chmod +x setup_env.sh run_experiments.sh
./setup_env.sh
source .venv/bin/activate
```

The fixed package versions are defined in `requirements.txt`.

## 4. Dataset Preparation

Download the processed datasets from the permanent Zenodo record:

<https://zenodo.org/records/21435638>

Download and extract:

- `GenIDS-CIC17.zip`
- `GenIDS-CIC18.zip`
- `GenIDS-NB15.zip`

The archives contain the CSV files consumed by the experimental notebooks. The datasets are intentionally kept outside the GitHub repository because of their size.

After extraction, open the configuration cell of each notebook that you intend to execute and point `DATA_DIR` and, when needed, the dataset path variables to the extracted CSV files. Example:

```python
from pathlib import Path

DATA_DIR = Path("/absolute/path/to/extracted/datasets")
```

If the extracted CSV filename differs from the filename shown in the notebook, update only the filename/path variable in the configuration cell. No other source-code modification is required for dataset location.

## 5. Principal Reproduction Path

After the dataset paths have been configured, run:

```bash
./run_experiments.sh 7 8 9
```

The script executes the notebooks sequentially with Jupyter `nbconvert`. Executed copies are written to `results/executed_notebooks/`, leaving the source notebooks unchanged.

The experiments can also be executed individually:

```bash
./run_experiments.sh 7
./run_experiments.sh 8
./run_experiments.sh 9
```

### Claim 1 - IN3 benign-flow integration exhibits low attack-detection capability

**Experiment 7 / Notebook 7**

- Training domain: GenIDS-CIC17
- Target/test domain: GenIDS-CIC18
- Integration: benign target-domain flows
- Integration rate: 40%
- Feature intervention: Chi-Square feature selection
- Selected features: 25 of the 70 common features
- Paper reference: Table 9

Expected result reported for IN3 in Table 9 (percentage scale):

| Attack Recall | Macro F1-Score | Macro FAR | Macro AUC-ROC |
|---:|---:|---:|---:|
| 0.00 | 42.95 | 0.00 | 85.75 |

The directly reproducible observation is the **0.00 Attack Recall** obtained by IN3 in this configuration. Table 9 reports a baseline Attack Recall of 50.30 for contextual comparison, but the baseline is not re-executed by Notebook 7. This distinction keeps the reproducibility claim limited to the result generated by the artifact itself.

### Claim 2 - IN3 malicious-flow integration strongly detects (D)DoS but exhibits high FAR

**Experiment 8 / Notebook 8**

- Training domain: GenIDS-CIC18
- Target/test domain: GenIDS-CIC17
- Integration: malicious (D)DoS target-domain flows
- Integration rate: 60%
- Feature intervention: Chi-Square feature selection
- Selected features: 25 of the 70 common features
- Classification: multiclass
- Paper reference: Table 10

The expected **absolute IN3 results** from Table 10 are:

| (D)DoS F1 | (D)DoS Recall | Background F1 | Background Recall | Macro F1 | Macro FAR | Macro AUC-ROC |
|---:|---:|---:|---:|---:|---:|---:|
| 26.72 | 100.00 | 0.03 | 0.02 | 37.09 | 75.58 | 74.10 |

The directly reproducible observation is the combination of **100.00 (D)DoS Recall** with very limited Background detection and a high **75.58 Macro FAR**. For context, Table 10 reports a baseline Macro FAR of 33.39, but the baseline is not re-executed by Notebook 8.

### Claim 3 - IN3 mixed integration provides the strongest overall IN3 result

**Experiment 9 / Notebook 9**

- Training domain: GenIDS-CIC18
- Target/test domain: GenIDS-CIC17
- Integration: mixed benign and malicious (D)DoS target-domain flows
- Integration rate: 20%
- Feature intervention: Chi-Square feature selection
- Selected features: 25 of the 70 common features
- Classification: multiclass
- Paper reference: Tables 11 and 12

The expected **absolute IN3 results** from Table 11 are:

| (D)DoS F1 | (D)DoS Recall | Background F1 | Background Recall | Macro F1 | Macro FAR | Macro AUC-ROC |
|---:|---:|---:|---:|---:|---:|---:|
| 97.28 | 99.58 | 0.00 | 0.00 | 64.71 | 12.56 | 98.77 |

The directly reproducible observation is the combination of high (D)DoS detection, **64.71 Macro F1**, **12.56 Macro FAR**, and **98.77 Macro AUC-ROC**. These values represent the strongest overall IN3 behavior among the three principal configurations documented here. The limitation in Background detection remains, as explicitly discussed in the paper.

## 6. Interpreting Reproduced Results

The notebooks print evaluation metrics, classification reports, confusion matrices, and the intermediate information associated with their feature intervention. Notebooks 8 and 9 explicitly report `far_macro` as the arithmetic mean of the one-vs-rest FAR values computed for the evaluated classes. Notebook outputs use numeric ratios where applicable, while the paper reports most metrics on a percentage scale.

The reproduced results should support the same qualitative conclusions and should be numerically consistent with the corresponding tables in the paper under the fixed software environment and experiment configuration. Small numerical differences can occur because of platform-specific behavior in numerical libraries. Large differences should first be investigated by checking:

1. the exact GenIDS dataset selected from Zenodo;
2. the source and target dataset paths;
3. the integration rate in the configuration cell;
4. the class/label column used by the experiment;
5. the fixed dependency versions in `requirements.txt`; and
6. the notebook being executed from the first cell to the last cell.

## 7. Complete Experiment Mapping

| Experiment | Intervention | Integration type | Main feature operation | Notebook |
|---:|---|---|---|---|
| 1 | IN1 | Benign | None | `notebooks/notebook_1.ipynb` |
| 2 | IN1 | Malicious (D)DoS | None | `notebooks/notebook_2.ipynb` |
| 3 | IN1 | Mixed | None | `notebooks/notebook_3.ipynb` |
| 4 | IN2 | Benign | PCA (25 components) | `notebooks/notebook_4.ipynb` |
| 5 | IN2 | Malicious (D)DoS | PCA (25 components) | `notebooks/notebook_5.ipynb` |
| 6 | IN2 | Mixed | PCA (25 components) | `notebooks/notebook_6.ipynb` |
| 7 | IN3 | Benign | Chi-Square (25 features) | `notebooks/notebook_7.ipynb` |
| 8 | IN3 | Malicious (D)DoS | Chi-Square (25 features) | `notebooks/notebook_8.ipynb` |
| 9 | IN3 | Mixed | Chi-Square (25 features) | `notebooks/notebook_9.ipynb` |

To execute all notebooks sequentially after configuring their dataset paths:

```bash
./run_experiments.sh all
```

## 8. Successful Reproduction Checklist

A principal-claim reproduction is considered complete when:

- Notebooks 7, 8, and 9 execute from first to last cell without Python exceptions;
- the configured source/target datasets and integration percentages match the three claims described in Section 5 above;
- each notebook produces its evaluation metrics and visual outputs;
- the reproduced results are consistent with the qualitative behavior and reported values in Tables 9, 10, and 11; and
- the three IN3 behaviors described in Section 5 can be observed directly from the reproduced results.

If a notebook fails before model training, first verify the extracted dataset path and filename. If execution completes but results differ substantially, verify the experiment configuration before changing any model parameters.
