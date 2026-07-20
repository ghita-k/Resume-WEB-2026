# Prédire le prix du Bitcoin avec l'IA : arrêtons de prédire un prix, prédisons un intervalle de confiance

> **Idée d'article — Data Science & IA appliquées à la finance crypto**
> Statut : brouillon / plan détaillé

## L'angle nouveau

La quasi-totalité des articles « Bitcoin Price Prediction with AI » suivent la même recette :
télécharger l'historique des prix, entraîner un LSTM, afficher une courbe prédite qui colle
à la courbe réelle… avec un jour de retard. Ce type de modèle ne prédit rien : il recopie
la veille.

**L'idée neuve de cet article : changer la question.** Au lieu de demander à l'IA
« quel sera le prix demain ? » (question à laquelle personne ne sait répondre), on lui demande :

1. **Dans quel régime de marché sommes-nous ?** (accumulation, euphorie, capitulation, range)
2. **Quel est l'intervalle probable du prix à J+7, avec une garantie statistique ?**
   (prédiction conforme / *conformal prediction*)
3. **Quels signaux non-prix portent l'information ?** (données on-chain, sentiment analysé
   par LLM, flux des ETF)

Le livrable n'est plus une courbe trompeuse, mais un **tableau de bord probabiliste honnête** :
« BTC a 90 % de chances d'être entre X et Y dans 7 jours, régime actuel : distribution,
confiance du modèle : faible car volatilité anormale ».

## Plan proposé

### 1. Pourquoi les LSTM « qui marchent » sont un mensonge
- Démonstration du piège : un modèle naïf qui prédit `prix(t+1) = prix(t)` obtient un RMSE
  quasi identique aux LSTM des tutoriels.
- Notion de marche aléatoire et d'efficience (partielle) du marché.

### 2. Construire des features qui contiennent réellement de l'information
- **On-chain** : MVRV, SOPR, réserves des exchanges, activité des adresses (API Glassnode
  ou données publiques Blockchain.com).
- **Sentiment** : scoring de titres d'actualité et de posts Reddit/X par un LLM
  (embedding + classification), agrégé en indice journalier — plus robuste que le
  classique « Fear & Greed ».
- **Macro et flux** : flux nets des ETF spot, DXY, taux réels, corrélation glissante
  avec le Nasdaq.
- **Dérivés** : funding rates, open interest, skew des options (proxy de la peur).

### 3. Détecter le régime de marché avant de prédire
- Modèle de Markov caché (HMM) ou clustering temporel pour identifier 3-4 régimes.
- Insight clé : un modèle entraîné par régime bat un modèle global — et savoir
  « dans quel régime on est » est déjà une prédiction exploitable en soi.

### 4. Prédire une distribution, pas un point
- Régression quantile avec gradient boosting (LightGBM) ou réseau à sortie
  distributionnelle.
- **Prédiction conforme (conformal prediction)** : la contribution technique de
  l'article. Elle garantit mathématiquement la couverture de l'intervalle
  (ex. 90 % des vrais prix tombent dans l'intervalle annoncé), sans hypothèse
  sur la distribution des rendements — crucial pour un actif à queues épaisses
  comme le BTC.
- Comparaison avec les modèles de fondation temporels récents (Chronos d'Amazon,
  TimesFM de Google) utilisés en zéro-shot : que valent-ils sur la crypto ?

### 5. Évaluer comme un quant, pas comme un data scientist de tutoriel
- Backtest *walk-forward* avec purge et embargo (éviter la fuite temporelle).
- Métriques : couverture réelle des intervalles, pinball loss, et surtout
  **P&L simulé d'une stratégie simple** basée sur les signaux (avec frais et slippage).
- Le test ultime : le modèle bat-il « acheter et ne rien faire » ajusté du risque ?

### 6. Limites et éthique
- Non-stationnarité : le marché de 2026 (ETF, adoption institutionnelle) n'est pas
  celui de 2017 ; tout modèle se périme.
- Ceci n'est pas un conseil financier : l'IA quantifie l'incertitude, elle ne
  l'élimine pas.

## Stack technique envisagée

| Brique | Outil |
|---|---|
| Données prix & dérivés | API Binance / CoinGecko, `ccxt` |
| Données on-chain | Glassnode / Blockchain.com API |
| Sentiment | LLM (embeddings + few-shot scoring), `praw` pour Reddit |
| Modélisation | Python, `pandas`, `LightGBM`, `hmmlearn`, `MAPIE` (conformal) |
| Modèles de fondation | Chronos / TimesFM en inférence zéro-shot |
| Dashboard | Streamlit ou Next.js + graphiques Plotly |

## Pourquoi cet article se démarque

- Il **assume l'imprévisibilité** du Bitcoin au lieu de la maquiller — posture rare
  et crédible pour un profil data scientist.
- Il introduit la **prédiction conforme**, technique encore peu vulgarisée, sur un
  cas d'usage grand public.
- Il combine trois sources de données (on-chain, sentiment LLM, dérivés) que les
  tutoriels traitent séparément, jamais ensemble.
- Il se termine par un livrable démontrable en portfolio : un dashboard probabiliste
  en ligne, mis à jour quotidiennement.
