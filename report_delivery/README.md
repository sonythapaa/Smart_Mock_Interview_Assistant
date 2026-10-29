# Report Delivery

This module adds PDF download and email delivery for completed interview reports.

It is registered by the main Flask backend in `main/app.py`, so these routes are available from the backend on port `5000`.

## Endpoints

- `GET /api/reports/<interview_id>/pdf`
- `POST /api/reports/<interview_id>/email` with `{ "email": "name@example.com" }`

The frontend calls these endpoints from the final report screen.

## Email Configuration

1. Copy `report_delivery/.env.example` to `report_delivery/.env`.
2. Enter SMTP settings from the chosen email provider.
3. For Gmail, use an App Password rather than the normal account password.
4. Restart the Flask backend after changing `.env`.

Credentials are read by the backend only. They are not exposed in frontend code or API responses.

## Generated Files

Generated PDF files are retained under `output/pdf/`. Runtime output folders are ignored by Git.
