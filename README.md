# Macos DotFiles

## Install Packages by brew

### Packages

```bash
brew install mac-mouse-fix
brew install --cask raycast
brew install --cask ghostty
brew install stow
brew install eza
brew install neovim
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick
brew install --cask zed
brew install starship
brew install bat fastfetch
brew install fnm
brew install --cask claude-code
brew install gh
brew install --cask zotero
brew install --cask obsidian
brew install --cask karabiner-elements
brew install --cask pearcleaner
brew install --cask mactex-no-gui
brew install --cask skim
brew install --cask iina
brew install age
brew tap farion1231/ccswitch
brew install --cask cc-switch
```

### Fonts

```bash
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-source-han-sans-vf
brew install --cask font-maple-mono-cn
brew install --cask font-lxgw-wenkai
#  For Reading
brew install --cask font-atkinson-hyperlegible
```

## Install by Download

- WeChat
- Vivaldi
- VS Code
- Clash Verge
- Shottr
- MS Office
- Keynote, Pages, Numbers
- Endnote 2025 Mac

## Stow Manage config

```bash
stow eza
stow ghostty
stow git
stow starship
stow zsh
stow conda
```

## Age usage

### Encrypt / Decrypt a Single File (Passphrase mode)

**Encrypt** a file.

```bash
age -p secret.txt > secret.txt.age
# or with output file
age -p -o secret.txt.age secret.txt
```

**Decrypt** a file.

```bash
age -d secret.txt.age > secret-decrypted.txt
# or overwrite original (careful!)
age -d -o secret.txt secret.txt.age
```

### Encrypt / Decrypt a Folder (Standard Workflow)

**Step 1: Pack the folder** (use tar + compression)

```bash
# Good compression (gzip)
tar czf myfolder.tar.gz myfolder/

# Better compression (xz – smaller file)
tar cJf myfolder.tar.xz myfolder/
```

**Step 2:** Encrypt the archive

```bash
age -p myfolder.tar.gz > myfolder.tar.gz.age
# or
age -p -o myfolder.tar.gz.age myfolder.tar.gz
```

**Step 3:** Decrypt + Unpack

```bash
# Decrypt
age -d myfolder.tar.gz.age > myfolder.tar.gz

# Unpack
tar xzf myfolder.tar.gz
```
