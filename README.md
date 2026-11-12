# Agent Toolkit

<img src="assets/agent-toolkit.png" alt="Deux outils croisés en pixel art" width="88" height="88">

Catalogue de plugins Codex maintenu dans ce dépôt. Chaque plugin est un paquet indépendant sous `plugins/`.

## Plugins

- [Intégration Xcode](plugins/xcode-integration/README.md) réunit les skills exportés par Xcode et le pont MCP Apple.

## Installer et actualiser dans Codex

Enregistre le catalogue une fois, puis installe le plugin qui t’intéresse.

```zsh
codex plugin marketplace add yanix2445/agent-toolkit --ref main
codex plugin add xcode-integration@agent-toolkit
```

Après un push sur `main`, actualise le catalogue puis ouvre un nouveau chat.

```zsh
codex plugin marketplace upgrade agent-toolkit
```

## Ajouter un plugin

Place le paquet dans `plugins/<nom-du-plugin>/` et ajoute une entrée dans le [catalogue commun](.agents/plugins/marketplace.json). Son `source.path` est relatif à la racine du dépôt, par exemple `./plugins/xcode-integration`.

[Format des plugins et catalogues Codex](https://developers.openai.com/plugins/build/plugins#marketplace-metadata)
