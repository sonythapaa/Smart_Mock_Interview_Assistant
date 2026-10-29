# Deploying on Render

This project can run on Render as one Python web service. Flask serves both:

- the interview API under `/api`
- the browser frontend from `frontend/index.html`

## Steps

1. Push this repository to GitHub.
2. In Render, create a new Web Service or Blueprint from the GitHub repo.
3. Use these settings if Render asks for them manually:
   - Environment: `Python`
   - Build command: `pip install -r requirements.txt`
   - Start command: `gunicorn main.app:app`
4. Deploy the service.
5. Open the Render URL. The main app should load at `/`.

## Notes

- Render provides the `PORT` environment variable automatically.
- The app no longer needs the separate Node frontend server in production.
- Ollama is local-only here. On Render, final reports will use the rule-based fallback unless you add a hosted LLM service.
- The model comparison tool in `compare/` is still a separate Flask app. Deploy it as a second Render service if you need it online.
- The ML dependencies are heavy, so choose a Render instance with enough memory if the free tier struggles.
