# TIL

This repo contains the source for Matt Corr's "Today I Learned" site, now built with MkDocs and the Material theme.

## Local preview

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

## Deployment

GitHub Actions builds and deploys the static site to GitHub Pages from `main`.
