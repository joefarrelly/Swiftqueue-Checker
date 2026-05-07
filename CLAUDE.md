# SwiftQueue Checker

A Python script that polls SwiftQueue for appointment slots earlier than a target date, and sends Telegram alerts to registered devices.

## What it does

- Polls a SwiftQueue URL every 60 seconds (`run_checker`)
- Alerts registered Telegram chat IDs when a slot on or before `TARGET_DATE` appears
- Auto-registers any Telegram device that messages the bot (`run_listener`)
- Persists registered chat IDs to `config.json`

## Setup

Copy `.env.example` to `.env` and fill in:

```
TELEGRAM_TOKEN=   # from @BotFather
TARGET_DATE=      # DD/MM/YYYY
SWIFTQUEUE_URL=   # e.g. https://www.swiftqueue.co.uk/wigan.php
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run:

```bash
python swiftqueue_checker.py
```

Or with Docker:

```bash
docker compose up
```

## Key files

- `swiftqueue_checker.py` — single-file entrypoint, all logic lives here
- `config.json` — persisted list of registered Telegram chat IDs (not committed)
- `.env` — secrets (not committed)

## Notes

- `config.json` is written at runtime and should not be committed with real chat IDs
- The checker deduplicates alerts within a run via an in-memory `alerted` set; restarting the process resets it
- `fetch_slots()` parses SwiftQueue's HTML — if the site structure changes, this is the first place to check
