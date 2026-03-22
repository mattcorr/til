# TIL

This repo contains the source for Matt Corr's "Today I Learned" site, now built with Zensical.

## Local preview

```console
python3.13 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
zensical serve
```

Use Python 3.13 or newer for local preview.

If you already have an older `.venv` from the MkDocs setup, delete and recreate it with Python 3.13 before installing the requirements.

## Deployment

GitHub Actions builds and deploys the static site to GitHub Pages from `main`.
