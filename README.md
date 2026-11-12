# Plugin Apple Xcode pour Codex

Ce dossier réunit les skills officiels exportés par Xcode et le serveur MCP Apple. Le manifeste Codex et sa configuration MCP sont assemblés localement. Avec Xcode 27.2 (build `27B52`), le plugin fournit 16 skills, dont les spécialistes SwiftUI, App Intents, accessibilité et traduction.

## Publier les skills après une mise à jour de Xcode

Dans un dépôt Git avec une branche distante configurée ou un remote `origin`, lance cette commande dans le Terminal.

```zsh
/Users/yanis/Developer/Plugin-Skills/xcode-integration/actualiser.zsh
```

Si Codex suit ton dépôt GitHub, récupère la version publiée avec `codex plugin marketplace upgrade apple-xcode-local`, puis ouvre un nouveau chat.

## Fonctionnement

`actualiser.zsh` appelle `xcrun agent plugin path --plugin-format codex` et utilise le chemin retourné par Xcode. Il remplace les dossiers de `skills/` par ceux de cet export. S’il y a des changements, il crée un commit limité à `skills/` au format [Conventional Commits 1.0.0](https://www.conventionalcommits.org/fr/v1.0.0/). Le titre indique le build Xcode et le corps détaille l’export et les dossiers touchés. Il pousse ensuite la branche courante, ce qui permet aussi de réessayer un push après un échec. Le [catalogue](.agents/plugins/marketplace.json) référence la racine de ce dossier avec `./`.

Le [manifeste](.codex-plugin/plugin.json) référence les skills et le [fichier MCP](.mcp.json), qui lance le pont officiel `xcrun mcpbridge`. Pour utiliser ses outils, ouvre ton projet dans Xcode et autorise les agents externes dans **Settings → Intelligence → Model Context Protocol**.

## Vérification et entretien

```zsh
codex plugin marketplace list
codex plugin list
```

Vérifie que le catalogue `apple-xcode-local` et le plugin `xcode-integration` figurent dans les listes. Dans un nouveau chat avec ton projet ouvert dans Xcode, demande au MCP Xcode de lister les schémas du projet pour vérifier la connexion.

Si le script retourne un export inattendu, vérifie le Xcode actif avec `xcode-select -p` et sa version avec `xcodebuild -version`. Si tu déplaces un catalogue enregistré comme dossier local, retire son enregistrement avec `codex plugin marketplace remove apple-xcode-local`, puis ajoute son nouveau chemin avec `codex plugin marketplace add`.

Pour désinstaller le plugin et retirer son catalogue de Codex, exécute ces commandes.

```zsh
codex plugin remove xcode-integration@apple-xcode-local
codex plugin marketplace remove apple-xcode-local
```

[Format et installation des plugins locaux](https://developers.openai.com/plugins/build/plugins#add-a-marketplace-from-the-cli) · [Accès MCP officiel à Xcode](https://developer.apple.com/documentation/xcode/giving-external-agents-access-to-xcode)
