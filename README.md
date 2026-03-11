# TIL

This repo contains the source for Matt Corr's "Today I Learned" site, now built with MkDocs and the Material theme.

## Local preview

```console
python3.10 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

Use Python 3.10 or newer for local preview.

## Deployment

GitHub Actions builds and deploys the static site to GitHub Pages from `main`.
