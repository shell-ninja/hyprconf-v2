# Neon Night

[![Version](https://vsmarketplacebadge.apphb.com/version/chaseadamsio.vscode-theme-neon-night.svg)](https://marketplace.visualstudio.com/items/chaseadamsio.vscode-theme-neon-night)
[![Downloads](https://vsmarketplacebadge.apphb.com/installs/chaseadamsio.vscode-theme-neon-night.svg)](https://marketplace.visualstudio.com/items/chaseadamsio.vscode-theme-neon-night)

> A dark theme for VS Code

![Full Preview](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/full-preview.png)

| JavaScript | React | Vue |
|:---:|:---:|:---:|
| ![JavaScript Screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/javascript.png) |![React Screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/react.png) | ![Vue Screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/vue.png) |

| Go | Dockerfile | HTML |
|:---:|:---:|:---:|
| ![Go Screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/go.png) | ![Dockerfile screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/docker.png) | ![HTML Screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/html.png) |

| JSON | TOML | YAML |
|:---:|:---:|:---:|
| ![JSON Screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/json.png) | ![TOML Screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/toml.png) | ![YAML screen](https://github.com/chaseadamsio/vscode-theme-neon-night/raw/master/static/preview/yaml.png)


## Getting Started

You can find the Neon Night theme in the [Visual Studio Code Marketplace](https://marketplhub.visualstudio.com/items?itemName=chaseadamsio.vscode-theme-neon-night).

## Installation

1. Open the **Extensions** sidebar in VS Code. `View → Extensions`
2. Search for `Neon Night`, choose "Neon Night" by **chaseadamsio**
3. Click **Install** to install it
4. Click **Reload** to reload VS Code
5. From the menu bar click: Code > Preferences > Color Theme > **Neon Night** (or any of the variants listed)
6. 🎉🎉 Enjoy!

## Syntax Colors

|      USAGE       |                                HEX CODES                                 |
| ---------------- | ------------------------------------------------------------------------ |
| Background       | ![#20242d](https://placehold.it/15/20242d/000000?text=+) `#20242d`       |
| Background Dark  | ![#1B1E26](https://placehold.it/15/1B1E26/000000?text=+) `#1B1E26`       |
| Foreground       | ![#C7C8FF](https://placehold.it/15/C7C8FF/000000?text=+) `#C7C8FF`       |
| Black       | ![#20242d](https://placehold.it/15/20242d/000000?text=+) `#20242d`       |
| White       | ![#C7C8FF](https://placehold.it/15/C7C8FF/000000?text=+) `#C7C8FF`       |
| Magenta         | ![#DD92F6](https://placehold.it/15/DD92F6/000000?text=+) `#DD92F6`       |
| Blue         | ![#69B4F9](https://placehold.it/15/69B4F9/000000?text=+) `#69B4F9`       |
| Cyan        | ![#8CE8ff](https://placehold.it/15/8CE8ff/000000?text=+) `#8CE8ff`       |
| Green        | ![#7EFDD0](https://placehold.it/15/7EFDD0/000000?text=+) `#7EFDD0`       |
| Red        | ![#FF8E8E](https://placehold.it/15/FF8E8E/000000?text=+) `#FF8E8E`       |
| Yellow        | ![#FCAD3F](https://placehold.it/15/FCAD3F/000000?text=+) `#FCAD3F`       |
| Diff Added       | ![#7EFDD011](https://placehold.it/15/7EFDD011/000000?text=+) `#7EFDD011` |
| Diff Removed     | ![#FF8E8E11](https://placehold.it/15/FF8E8E11/000000?text=+) `#FF8E8E11` |

## Development

Run the `develop:init` task:

```sh

yarn prepublish && yarn develop:init
```

This will create a symlink in the VS Code extensions and build the theme for the first time. After running this, follow the Installation instructions to load the theme.

## Publishing

- **`prepublish`** - Creates the `neon-night.json` and `package.json` in `<ROOT>/themes` and copies relevant files (README, license, static assets)
- **`vscode:publish`** - Publishes `themes` as the root directory for the extension.

Designed with 💜 by **[Chase Adams](https://github.com/chaseadamsio)**. You can find me on [Twitter at chaseadamsio](https://twitter.com/chaseadamsio).
