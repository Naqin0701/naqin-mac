# ===================== ZSH AUTOSUGGESTIONS =====================
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^y' autosuggest-accept
# ===================== ZSH AUTOSUGGESTIONS =====================

# ZSH SYNTAX HIGHLIGHTING
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH COMPLETION
fpath=(~/.zsh/zsh-completion/src $fpath)
