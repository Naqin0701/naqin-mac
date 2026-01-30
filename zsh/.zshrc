# -----------------
# History settings
# -----------------
HISTFILE="${HOME}/.zsh_history"   # History file location
HISTSIZE=10000                    # Number of history entries in memory
SAVEHIST=10000                    # Number of history entries saved to file
setopt APPEND_HISTORY             # Append to history instead of overwriting
setopt HIST_IGNORE_DUPS           # Ignore consecutive duplicate commands
setopt HIST_IGNORE_ALL_DUPS       # Ignore all duplicate commands
setopt HIST_SAVE_NO_DUPS          # Remove duplicates when saving
setopt SHARE_HISTORY              # Share history across multiple zsh sessions

# -----------------
# Completion system
# -----------------
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select                    # Menu-style selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'                  # Case-insensitive + fuzzy matching

# -----------------
# Useful options
# -----------------
setopt AUTO_CD                    # Type directory name to cd into it
setopt AUTO_PUSHD                 # cd automatically pushes directories to stack
setopt PUSHD_IGNORE_DUPS          # Ignore duplicates in directory stack
setopt EXTENDED_GLOB              # Enable extended globbing patterns

# -----------------
# Common aliases
# -----------------
alias ls='eza --color=auto --icons=auto --group-directories-first'
alias ll='eza -l -h --icons=auto --git --group-directories-first'
alias la='eza -a --icons=auto --group-directories-first'
alias lla='eza -la -h --icons=auto --git --group-directories-first'
alias lt='eza --tree --icons=auto --git-ignore'
alias llt='eza --tree -l --icons=auto --git'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# -----------------
# Environment variables (optional)
# -----------------
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export http_proxy=http://127.0.0.1:7897
export https_proxy=http://127.0.0.1:7897
export all_proxy=sockes5://127.0.0.1:7897


# functions
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
function z() {
    if [[ -z "$1" ]]; then
        zi
    else
        __zoxide_z "$@"
    fi
}
# Mac-like open command
function open() {
    if [[ $# -eq 0 ]]; then
        # No arguments → open current directory
        xdg-open . >/dev/null 2>&1
        return
    fi

    local file
    for file in "$@"; do
        if [[ -e "$file" || "$file" =~ ^(https?|ftp):// ]]; then
            xdg-open "$file" >/dev/null 2>&1 &
        else
            print -u2 "open: cannot access '$file': No such file or directory"
        fi
    done
}
function startconda() {
    source ~/miniforge3/etc/profile.d/conda.sh
    eval "$(mamba shell hook --shell zsh)"
}

# fzf
export FZF_DEFAULT_OPTS="
  --height 60% --layout=reverse --border
  --preview 'bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || eza -TL 3 --icons --color=always {} 2>/dev/null || tree -C {} 2>/dev/null'
  --preview-window='right:50%:wrap'
  --color=bg+:#2d2d2d,fg+:#ffffff,hl+:#5fd7ff,pointer:#ff79c6
"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# plugins
source <(fzf --zsh)
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"


