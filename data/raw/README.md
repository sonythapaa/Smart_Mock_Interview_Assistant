# Raw Data

## Purpose

This folder stores unchanged source snapshots used to build the Smart Mock Interview Assistant question bank. Raw files are kept for reproducibility, attribution, and evidence of the data sources used during the project.

Cleaning and transformation outputs belong in `data/interim/` and `data/processed/`, not in this folder.

## Current Raw Folder Structure

```text
data/raw/
|-- S1/
|   |-- data_science_ml_dl_nlp_interview_questions/
|       |-- Data_Science_ML_DL_NLP_Interview_Qus/
|       |-- source_note.txt
|
|-- S2/
|   |-- kaggle_python_interview_questions/
|       |-- kaggle_python_interview_questions_2025/
|       |-- source_note.txt
|
|-- S3/
|   |-- sql_interview_preparation_questions/
|       |-- SQL-Interview-Preparation/
|       |-- source_note.txt
|
|-- README.md
```

## Data Sources and Attribution

| Source ID | Source Name | Creator / Owner | Source Type | Licence / Terms Status | Project Use |
|---|---|---|---|---|---|
| S1 | Data Science, ML, DL and NLP Interview Questions | MukundAabha / GitHub | GitHub repository | MIT licence shown on GitHub. Original licence file retained in the raw copy. | Data science, machine learning, deep learning, NLP, statistics, and related interview questions/notes. |
| S2 | Python Interview Questions 2025 | yamankhetan / Kaggle | Kaggle dataset | Team accepted dataset terms. Exact Kaggle licence/terms should be retained in the project source log. | Python-focused technical interview questions and possible reference answers. |
| S3 | SQL Interview Preparation | rohanmistry231 / GitHub | GitHub repository | MIT licence shown on GitHub. Original licence file retained in the raw copy. | SQL interview questions, SQL fundamentals, query practice, and case-study material. |

## Source-to-Topic Mapping

| Topic Area | Source ID | Relevant Raw Material | Project Use |
|---|---|---|---|
| Data analysis | S1 | `Data-Analysis_Question.docx` and related notes | Data Analyst and Data Scientist interview coverage. |
| Machine learning | S1 | `ML.docx`, `Predictive-Modeling.docx` | ML and predictive modelling questions. |
| Deep learning | S1 | `Deep Learning.docx`, `list_of_questions_mathematics_ML_DL.docx` | Deep learning and neural network questions. |
| NLP | S1 | `NLP.docx` | NLP interview question coverage. |
| Statistics | S1 | Statistics PDFs and quiz material | Supporting statistics and probability coverage where suitable. |
| Python | S2 | `python_interview_questions_500.csv` | Python technical question bank content. |
| SQL | S3 | `SQL Interview Questions with Ans/`, `SQL Fundamentals/`, case studies, and projects | SQL question-answer and practice content. |

## Raw Data Handling Rules

1. Keep raw files unchanged.
2. Keep source notes with each source folder.
3. Keep original licence files where they are provided by the source.
4. Use scripts in `src/components/` for extraction, transformation, and cleaning.
5. Save intermediate and cleaned outputs outside `data/raw/`.
6. Do not present external content as original team-authored material.
7. Use only relevant source files during processing if a raw repository contains extra educational material.

## Processed Output

The Week 9 cleaned question bank is stored in:

```text
data/processed/questions_cleaned.json
data/processed/questions_cleaned.csv
```

The cleaned schema is:

```text
id
domain
difficulty
question
reference_answer
```

The current processed dataset contains 467 records.

## Attribution Statement

External datasets and repository content are credited through source notes, retained source files, original licence files where available, and this README. The team does not claim ownership of reused source material.
