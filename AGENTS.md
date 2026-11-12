# Maintenance du catalogue Plugin Skills

- Utiliser [le catalogue commun](.agents/plugins/marketplace.json) pour référencer les plugins. Le nom du catalogue est `plugin-skills`.
- Placer chaque paquet sous `plugins/<nom-du-plugin>/` avec son manifeste et les composants qu’il fournit. Faire correspondre le nom du dossier, le manifeste et l’entrée du catalogue.
- Lire les consignes du plugin concerné avant de modifier ses fichiers. Les scripts propres à un plugin sont maintenus dans son dossier.
- Limiter chaque commit à son sujet et suivre [Conventional Commits 1.0.0](https://www.conventionalcommits.org/fr/v1.0.0/). Vérifier la découverte du plugin dans Codex après un changement de catalogue ou de manifeste.
