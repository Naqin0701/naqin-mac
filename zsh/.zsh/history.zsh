# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                                                                           ║
# ║                           History Configuration                           ║
# ║                                                                           ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                              History Settings                             ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# History file location
HISTFILE="${HOME}/.zsh_history"

# Number of history entries to keep in memory
HISTSIZE=10000

# Number of history entries to save to file
SAVEHIST=10000

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                           History Options                                 ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Append to history instead of overwriting
setopt APPEND_HISTORY

# Ignore consecutive duplicate commands
setopt HIST_IGNORE_DUPS

# Ignore all duplicate commands
setopt HIST_IGNORE_ALL_DUPS

# Remove duplicates when saving to file
setopt HIST_SAVE_NO_DUPS

# Share history across multiple zsh sessions
setopt SHARE_HISTORY