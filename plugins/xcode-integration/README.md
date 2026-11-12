# Plugin Apple Xcode pour Codex

Ce dossier réunit les skills officiels exportés par Xcode et le serveur MCP Apple. Le manifeste Codex et sa configuration MCP sont assemblés localement. Avec Xcode 27.2 (build `27B52`), le plugin fournit 16 skills, dont les spécialistes SwiftUI, App Intents, accessibilité et traduction.

## Publier les skills après une mise à jour de Xcode

Depuis la racine du dépôt Git, lance cette commande dans le Terminal.

```zsh
./plugins/xcode-integration/actualiser.zsh
```

Récupère la version publiée avec `codex plugin marketplace upgrade plugin-skills`, puis ouvre un nouveau chat. Le [guide du dépôt](../../README.md) décrit l’installation depuis GitHub.

## Fonctionnement

`actualiser.zsh` appelle `xcrun agent plugin path --plugin-format codex` et utilise le chemin retourné par Xcode. Il remplace les dossiers de `skills/` par ceux de cet export. S’il y a des changements, il crée un commit limité à `skills/` au format [Conventional Commits 1.0.0](https://www.conventionalcommits.org/fr/v1.0.0/). Le titre indique le build Xcode et le corps détaille l’export et les dossiers touchés. Il pousse ensuite la branche courante, ce qui permet aussi de réessayer un push après un échec. Le [catalogue commun](../../.agents/plugins/marketplace.json) référence ce paquet avec `./plugins/xcode-integration`.

Le [manifeste](.codex-plugin/plugin.json) référence les skills et le [fichier MCP](.mcp.json), qui lance le pont officiel `xcrun mcpbridge`. Pour utiliser ses outils, ouvre ton projet dans Xcode et autorise les agents externes dans **Settings → Intelligence → Model Context Protocol**.

## Vérification et entretien

```zsh
codex plugin marketplace list
codex plugin list
```

Vérifie que le catalogue `plugin-skills` et le plugin `xcode-integration` figurent dans les listes. Dans un nouveau chat avec ton projet ouvert dans Xcode, demande au MCP Xcode de lister les schémas du projet pour vérifier la connexion.

Si le script retourne un export inattendu, vérifie le Xcode actif avec `xcode-select -p` et sa version avec `xcodebuild -version`.

Pour désinstaller ce plugin dans Codex, utilise cette commande.

```zsh
codex plugin remove xcode-integration@plugin-skills
```

[Format et installation des plugins locaux](https://developers.openai.com/plugins/build/plugins#add-a-marketplace-from-the-cli) · [Accès MCP officiel à Xcode](https://developer.apple.com/documentation/xcode/giving-external-agents-access-to-xcode)
