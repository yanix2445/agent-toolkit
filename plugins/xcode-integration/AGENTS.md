# Maintenance de l’intégration Apple Xcode

- Consulter [le guide utilisateur](README.md) pour l’installation, la mise à jour et les vérifications.
- Le [catalogue commun](../../.agents/plugins/marketplace.json) expose `xcode-integration@plugin-skills` avec le chemin `./plugins/xcode-integration`. Le manifeste `.codex-plugin/plugin.json`, le fichier `.mcp.json` et les skills sont dans ce dossier.
- `actualiser.zsh` remplace `skills/` par les dossiers retournés par `xcrun agent plugin path --plugin-format codex`, crée un commit limité à `skills/` et pousse la branche. L’export Apple est la source de vérité pour les skills et leurs références.
- Suivre Conventional Commits 1.0.0 pour les messages. Les synchronisations utilisent `chore(xcode)` et indiquent le build Xcode dans le titre ainsi que les dossiers concernés dans le corps.
- Utiliser le skill OpenAI `plugin-creator` pour faire évoluer ou valider le manifeste. Garder la commande officielle `xcrun mcpbridge` dans `.mcp.json`.
- Après une actualisation, vérifier les skills découverts par Codex et le serveur MCP dans un profil ou un chat qui a chargé le nouveau paquet. Avec le build `27B52`, un profil vierge a chargé 16 skills et découvert 54 outils sur le serveur intégré.
