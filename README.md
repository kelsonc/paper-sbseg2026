# Network Flow Integration to Improve Generalization of Machine Learning-Based IDS

## Supplementary Materials

This repository contains the source code and supplementary materials associated with the paper **"Network Flow Integration to Improve Generalization of Machine Learning-Based IDS"**, submitted to SBSeg 2026. The processed datasets used in the experiments are publicly available in a permanent Zenodo record.

## Abstract

The growth of cyber threats and the evolution of attacks highlight the need for more robust machine learning-based IDS capable of operating in heterogeneous, dynamic network environments. Although some approaches presented in the literature improve the performance of these systems, their generalization capability remains limited in multi-domain data scenarios. This paper investigates supervised domain adaptation through controlled integration of labeled target-domain flows to diversify training and reduce generalization performance degradation in IDS. Results show improvements in specific scenarios, depending on the integrated flow type, with trade-offs among attack detection, class balance, and false alarms.

## Artifact Overview

The artifacts support the experimental evaluation of a controlled network-flow integration method for improving the generalization of machine learning-based Intrusion Detection Systems (IDS) across distinct data domains.

The experiments use standardized versions of the [UNSW-NB15](https://research.unsw.edu.au/projects/unsw-nb15-dataset), [CIC-IDS2017](https://www.unb.ca/cic/datasets/ids-2017.html), and [CIC-IDS2018](https://www.unb.ca/cic/datasets/ids-2018.html) datasets. Network flows were extracted from the original PCAP files using [NFStream](https://www.nfstream.org/) and organized in a common feature space. During the experiments, labeled flows selected from the target domain are incorporated into the source-domain training data. The corresponding selected flows are removed from the target-domain test data, and an equivalent number of flows is removed from the source-domain training data to preserve the dataset size.

The repository provides nine Jupyter notebooks corresponding to the nine experiments reported in the paper. They evaluate three flow-integration strategies, both independently and in combination with feature-level interventions:

- benign flow integration;
- malicious (D)DoS flow integration;
- mixed integration of benign and malicious (D)DoS flows;
- flow integration mixed with Principal Component Analysis (PCA); and
- flow integration combined with Chi-Square feature selection.

## Available Artifacts

The materials associated with the paper are distributed as follows:

- **Source code:** the nine Jupyter notebooks in the [`notebooks/`](notebooks/) directory implement the experiments reported in the paper.
- **Processed datasets:** the GenIDS datasets used by the notebooks are publicly available on Zenodo: [GenIDS datasets - Zenodo record 21435638](https://zenodo.org/records/21435638).
- **Feature documentation:** [`features.pdf`](features.pdf) describes the features extracted with NFStream from the original PCAP files.

## Repository Structure

```text
.
├── notebooks/
│   ├── notebook_1.ipynb
│   ├── notebook_2.ipynb
│   ├── notebook_3.ipynb
│   ├── notebook_4.ipynb
│   ├── notebook_5.ipynb
│   ├── notebook_6.ipynb
│   ├── notebook_7.ipynb
│   ├── notebook_8.ipynb
│   └── notebook_9.ipynb
├── tables/
│   └── features.pdf
└── README.md
```

The processed datasets are stored separately on Zenodo and therefore are not included directly in the GitHub repository.

## Datasets

The experiments use the following standardized datasets:

- **GenIDS-UNSW15**, derived from UNSW-NB15;
- **GenIDS-CIC17**, derived from CIC-IDS2017; and
- **GenIDS-CIC18**, derived from CIC-IDS2018.

The processed datasets used by the experimental notebooks are available from the permanent Zenodo record:

**Dataset repository:** [https://zenodo.org/records/21435638](https://zenodo.org/records/21435638)

The original public datasets are not redistributed in this GitHub repository. The GenIDS versions were generated from the original network traffic captures using NFStream, producing a common set of flow features for cross-dataset experiments. The datasets were subsequently preprocessed and labeled according to the methodology described in the paper.

The NFStream features are documented in [Features Extracted with NFStream from the PCAP Files of the Datasets](tables/features.pdf). They include flow identification and traffic-volume information, packet-derived statistical measurements, and application-related features.

> **Note:** The dataset paths in the notebooks must point to the local directory where the files downloaded from Zenodo are stored. Detailed configuration and execution instructions will be documented as part of the functional artifact documentation.

## Notebooks and Experiments

Each notebook corresponds directly to one experiment described in the paper.

### Intervention IN1 - Network Flow Integration

- [Notebook 1](notebooks/notebook_1.ipynb) - **Experiment 1:** benign flow integration.
- [Notebook 2](notebooks/notebook_2.ipynb) - **Experiment 2:** malicious (D)DoS flow integration.
- [Notebook 3](notebooks/notebook_3.ipynb) - **Experiment 3:** mixed integration of benign and malicious (D)DoS flows.

Experiments 1-3 evaluate integration percentages of 20%, 40%, 60%, and 80% across Interset combinations of GenIDS-UNSW15, GenIDS-CIC17, and GenIDS-CIC18.

### Intervention IN2 - PCA + Network Flow Integration

Principal Component Analysis (PCA) is combined with the corresponding flow-integration strategy. In the experiments reported in the paper, PCA transforms the common feature space from 70 original features to 25 principal components.

- [Notebook 4](notebooks/notebook_4.ipynb) - **Experiment 4:** PCA + benign flow integration.
- [Notebook 5](notebooks/notebook_5.ipynb) - **Experiment 5:** PCA + malicious (D)DoS flow integration.
- [Notebook 6](notebooks/notebook_6.ipynb) - **Experiment 6:** PCA + mixed flow integration.

### Intervention IN3 - Chi-Square Feature Selection + Network Flow Integration

Chi-Square feature selection is combined with the corresponding flow-integration strategy. The feature-selection step reduces the common feature space from 70 to 25 selected features.

- [Notebook 7](notebooks/notebook_7.ipynb) - **Experiment 7:** Chi-Square + benign flow integration.
- [Notebook 8](notebooks/notebook_8.ipynb) - **Experiment 8:** Chi-Square + malicious (D)DoS flow integration.
- [Notebook 9](notebooks/notebook_9.ipynb) - **Experiment 9:** Chi-Square + mixed flow integration.

Together, these artifacts provide the code, standardized data references, and supplementary feature documentation associated with the experimental evaluation presented in the paper.
