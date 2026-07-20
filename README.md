# CV Web (FR) — Ghita EL KADIRI

CV web one-page **en français** pour **Ghita EL KADIRI**, Ingénieure Cloud / DevOps / DevSecOps.

Version anglaise : **[CV-WEB-English-2026](https://github.com/ghita-k/CV-WEB-English-2026)**.

## Site en ligne (GitHub Pages)

URL prévue :

**https://ghita-k.github.io/Resume-WEB-2026/**

### Activer le site (une seule fois)

1. Ouvre le dépôt : https://github.com/ghita-k/Resume-WEB-2026
2. Va dans **Settings → Pages**
3. Sous **Build and deployment**, choisis **Source : GitHub Actions**
4. Attends 1–2 minutes que le workflow `Deploy GitHub Pages` finisse
5. Ouvre l’URL ci-dessus

Le site se met à jour automatiquement à chaque push sur `main`.

## Lancer en local

### Windows
```bat
cd path\to\Resume-WEB-2026
py -m http.server 8080
```
Puis ouvre `http://127.0.0.1:8080/`

Ou double-clique sur `index.html`.

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

## Fonctionnalités

- Design responsive (desktop / mobile)
- Timeline d’expérience, navigation active au scroll
- Animations reveal (respecte `prefers-reduced-motion`)
- Export PDF / version imprimable
- Déploiement automatique via GitHub Pages
