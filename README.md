# Web Resume (EN) — Ghita EL KADIRI

One-page web resume **in English** for **Ghita EL KADIRI**, Cloud / DevOps / DevSecOps Engineer.

French version: **[Resume-WEB-2026](https://github.com/ghita-k/Resume-WEB-2026)**.

## Live site (GitHub Pages)

Expected URL:

**https://ghita-k.github.io/CV-WEB-English-2026/**

### Enable the site (one-time)

1. Open the repository: https://github.com/ghita-k/CV-WEB-English-2026
2. Go to **Settings → Pages**
3. Under **Build and deployment**, set **Source: GitHub Actions**
4. Wait 1–2 minutes for the `Deploy GitHub Pages` workflow
5. Open the URL above

The site updates automatically on every push to `main`.

## Run locally

### Windows
```bat
cd path\to\CV-WEB-English-2026
py -m http.server 8080
```
Then open `http://127.0.0.1:8080/`

Or double-click `index.html`.

### macOS / Linux
```bash
python3 -m http.server 8080
```

## Structure

```
index.html
css/styles.css
js/main.js
assets/
.github/workflows/pages.yml
```

## Features

- Responsive design (desktop / mobile)
- Experience timeline, active scroll navigation
- Reveal animations (respects `prefers-reduced-motion`)
- “Export PDF” / printable version
- Automatic deployment via GitHub Pages
