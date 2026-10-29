# Archived Model Evaluation

This folder contains archived Week 8 evaluation outputs for an experimental neural-network answer-quality classifier.

Current files:

- `classification_report.txt`
- `confusion_matrix.png`

These artefacts are retained as historical project evidence only. The Week 9 application does not include the old classifier training/prediction scripts and does not use this classifier at runtime.

The Week 9 runtime scoring models are:

- Siamese Bi-LSTM: `src/model/SiameseBiLSTM.py`
- Sentence-BERT: `src/model/Pretrained_NEURALN.py`
- TF-IDF + Grammar: `src/model/TraditionalMLScorer.py`
- Shared registry: `src/model/model_registry.py`

The archived classifier report should not be presented as final model-performance evidence for the Week 9 application.
