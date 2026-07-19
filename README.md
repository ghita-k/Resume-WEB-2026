# CV Web — Ghita EL KADIRI

CV web one-page premium pour **Ghita EL KADIRI**, Ingénieure Cloud / DevOps / DevSecOps.

Contenu basé sur le CV PDF et le profil LinkedIn.

## Lancer en local

### Windows
```bat
cd chemin\vers\Resume-WEB-2026
py -m http.server 8080
```
Puis ouvrir `http://127.0.0.1:8080/`

Ou double-cliquer `index.html`.

### macOS / Linux
```bash
python3 -m http.server 8080
```

## Structure

```
index.html
css/styles.css
js/main.js
assets/favicon.svg
```

## Fonctionnalités

- Design responsive (desktop / mobile)
- Timeline d’expérience, navigation active au scroll
- Animations d’apparition (respecte `prefers-reduced-motion`)
- Bouton « Exporter PDF » / version imprimable
