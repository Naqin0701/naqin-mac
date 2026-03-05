# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                                                                           ║
# ║                            Shell Options                                   ║
# ║                                                                           ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                           Directory Navigation                            ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Type directory name to cd into it
setopt AUTO_CD

# cd automatically pushes directories to stack
setopt AUTO_PUSHD

# Ignore duplicates in directory stack
setopt PUSHD_IGNORE_DUPS

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                             Globbing Patterns                             ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Enable extended globbing patterns
setopt EXTENDED_GLOB