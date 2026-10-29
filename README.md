# Smart Mock Interview Assistant

## Project Title

**Smart Mock Interview Assistant: An NLP-Based System for Evaluating Technical Interview Responses**

## Repository Purpose

The project is a deployable end-to-end prototype that combines a Flask interview API, a browser-based interview interface, NLP answer scoring, adaptive interview progression, model comparison, PDF/email report delivery, preserved project documentation, and supporting evaluation evidence.

## Project Status

- Flask serves the production frontend and backend together as one web service.
- The frontend automatically uses `http://localhost:5000/api` during local development and `/api` when deployed.
- Render deployment is supported through `render.yaml`.
- The main interview app can be deployed as a single Render web service.
- The separate model comparison tool remains available locally in `compare/`; deploy it as a second Render service if it is needed online.
- Optional Ollama report enrichment is supported locally, with rule-based fallback text when Ollama is unavailable.

## Project Overview

The Smart Mock Interview Assistant helps users practise technical interviews for roles such as:

- Data Analyst
- Data Scientist
- Machine Learning Engineer
- NLP Engineer
- Python Developer
- Custom technical interview topics

The application asks role-based questions, evaluates typed answers with NLP scoring models, gives immediate feedback, adapts interview progression where supported, and generates a final preparation report.

## Repository Structure

```text
Project/
|-- compare/                  # Local model comparison Flask tool
|-- data/                     # Raw, interim, and processed question data
|-- docs/                     # Project planning documentation
|-- frontend/                 # Browser interface and local Express server
|-- main/                     # Main Flask app used locally and on Render
|-- notebooks/                # EDA notebook
|-- reports/                  # EDA and model evaluation evidence
|-- report_delivery/          # PDF and email report delivery
|-- results/                  # Required model checkpoint
|-- src/                      # Pipeline, interview logic, and scoring models
|-- RENDER_DEPLOYMENT.md      # Render deployment guide
|-- render.yaml               # Render service configuration
|-- requirements.txt          # Python dependencies
|-- run_all.bat               # Local Windows launcher
```

## Main Application Components

### Backend API

The main backend is defined in `main/app.py`.

Local development:

- Flask backend: `http://localhost:5000`
- Health check: `http://localhost:5000/health`

Production deployment:

- Frontend: `/`
- Backend API: `/api/...`
- API information: `/api/info`

Key API features:

- Role and domain discovery.
- Model selection before the interview starts.
- Interview session creation.
- Current-question, submit-answer, skip, repeat, and round-completion endpoints.
- Final report generation.
- Background report status polling.
- PDF report download.
- Email report delivery.

### Frontend

The frontend is in `frontend/index.html`.

Local development uses `frontend/server.js` on port `3000`. On Render, Flask serves the same frontend directly, so the Node server is not required in production.

Frontend features:

- Role selection.
- Custom-domain interview setup.
- Model selector before the interview starts.
- Chat-style interview flow.
- Immediate score and feedback display.
- Final report rendering.
- PDF download and email actions.
- Link to the model comparison tool during local development.

### Model Comparison Tool

The comparison tool in `compare/` is a separate Flask app running locally on port `5050`.

It supports:

- Single question/model similarity checks.
- Topic-based comparison across all three scoring models.
- Side-by-side scoring for Bi-LSTM, Sentence-BERT, and TF-IDF.

For online access, deploy `compare/app.py` as a second Render web service or integrate it into the main Flask app later.

## Scoring Models

The project exposes three scoring models through `src/model/model_registry.py`.

| Model key | Model | Status | Notes |
|---|---|---|---|
| `bilstm` | Siamese Bi-LSTM | Working project model | Uses the trained checkpoint in `results/siamese_bilstm.pt`. The app uses a fixed curriculum for this model because its scores are not reliable enough for threshold-based progression. |
| `bert` | Sentence-BERT | Working pretrained semantic scorer | Uses `sentence-transformers/all-MiniLM-L6-v2` to compare reference answers and user answers by semantic similarity. |
| `tfidf` | TF-IDF + Grammar | Working traditional baseline | Uses TF-IDF similarity and grammar checking. In the shared registry, the similarity score is used for comparability with the other two models. |

The models are prototype scoring tools and should not be presented as production-grade interview assessment without manually scored human validation data.

## Adaptive Interview Logic

The interview engine is implemented in `src/components/interview_session.py`.

- Sentence-BERT and TF-IDF use adaptive progression through Easy, Medium, and Hard rounds.
- The Bi-LSTM uses fixed question counts per round because its scores are stricter and less suitable for threshold gating.
- Skips are tracked and included in final reporting.
- Reports include role, domains, scoring model, answered/skipped counts, strengths, improvement areas, recommendations, and learning plan content.

## Data Pipeline

The preprocessing pipeline is:

```text
data/raw/
   -> src/components/data_ingestion.py
   -> data/interim/transformed.json
   -> src/components/data_transformation.py
   -> src/components/data_cleaner.py
   -> data/processed/questions_cleaned.json
   -> data/processed/questions_cleaned.csv
```

Run the pipeline from the project root with:

```bash
python src/components/pipeline.py
```

The application reads `data/processed/questions_cleaned.json` at runtime.

## Current Processed Dataset Summary

The cleaned dataset contains **467 question-answer records**.

Schema:

```text
id
domain
difficulty
question
reference_answer
```

Domain distribution:

| Domain | Count |
|---|---:|
| ML | 205 |
| DL | 108 |
| NLP | 37 |
| PREDICTIVE_MODELLING | 34 |
| SQL | 30 |
| Python | 28 |
| DATA_ANALYSIS | 25 |

Difficulty distribution:

| Difficulty | Count |
|---|---:|
| Easy | 156 |
| Medium | 202 |
| Hard | 109 |

EDA outputs are stored under `reports/eda/questions_eda_outputs/`, including distribution figures and CSV records for flagged quality issues.

## Local Setup

Install Python dependencies from the project root:

```bash
pip install -r requirements.txt
```

Install frontend dependencies:

```bash
cd frontend
npm install
```

Optional local LLM report support:

```bash
ollama serve
ollama pull qwen2.5:7b
```

If Ollama is not installed or the configured model is unavailable, report generation falls back to rule-based recommendations.

## Running Locally

### Option 1: Use the Windows launcher

From PowerShell in the project root:

```powershell
.\run_all.bat
```

The launcher starts:

- Main Flask app on port `5000`.
- Compare Flask app on port `5050`.

The launcher also creates `.venv` if needed and installs `requirements.txt`.

Open:

- Main app: `http://localhost:5000`
- Backend health check: `http://localhost:5000/health`
- Model comparison tool: `http://localhost:5050`
- Topic comparison page: `http://localhost:5050/topic-compare`

### Option 2: Run services manually

Backend:

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
python main\app.py
```

Compare tool:

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
python compare\app.py
```

Optional frontend server:

```bash
cd frontend
node server.js
```

## Render Deployment

The main app is prepared to deploy to Render as a single Python web service.

Recommended Render settings:

- Language: `Python 3`
- Root directory: leave blank
- Build command: `pip install -r requirements.txt`
- Start command: `gunicorn main.app:app`
- Environment variable: `FLASK_DEBUG=0`

Render supplies the `PORT` variable automatically. The app uses that port in production and serves the frontend from `/`.

See `RENDER_DEPLOYMENT.md` for a shorter step-by-step deployment guide.

## Report Delivery

The `report_delivery/` module adds PDF and email report support to the Flask backend.

PDF endpoint:

```text
GET /api/reports/<interview_id>/pdf
```

Email endpoint:

```text
POST /api/reports/<interview_id>/email
```

Email credentials are configured through `report_delivery/.env`, using `report_delivery/.env.example` as the template. Secrets are not committed to the repository.

## Project Evidence

The repository keeps supporting evidence for the Week 10 submission:

- `docs/project_plans/`: project planning PDFs.
- `notebooks/questions_eda.ipynb`: exploratory data analysis notebook.
- `reports/eda/`: EDA figures and issue lists.
- `data/raw/`: unchanged source snapshots and attribution notes.
- `reports/model_evaluation/`: archived Week 8 classifier evaluation artefacts, retained for historical evidence only.
- `RENDER_DEPLOYMENT.md`: deployment evidence and deployment instructions.

## Known Limitations

- The answer scoring is prototype-level and has not been validated against a large manually scored response dataset.
- Reference-answer similarity is only an approximation of answer quality.
- Sentence-BERT handles paraphrasing better than TF-IDF, but it can still miss domain-specific correctness.
- TF-IDF rewards vocabulary overlap and should be treated as a traditional baseline.
- The Bi-LSTM model is trained from project data and can be strict with reworded answers.
- Email sending requires SMTP credentials configured locally or as secure production environment variables.
- Ollama report enrichment is local-only in the current Render setup.
- The comparison tool is separate from the main Render service unless deployed independently.