# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                                                                           ║
# ║                           Custom Functions                                ║
# ║                                                                           ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                          Yazi File Manager                              ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Yazi wrapper that changes directory on exit
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                            Zoxide Wrapper                               ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Zoxide with zi fallback for interactive selection
function z() {
    if [[ -z "$1" ]]; then
        zi
    else
        __zoxide_z "$@"
    fi
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                         Conda Initialization                            ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Start Conda with Mamba support
function startconda() {
    source ~/miniforge3/etc/profile.d/conda.sh
    eval "$(mamba shell hook --shell zsh)"
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                         Copy PWD to Clipboard                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Copy current working directory to system clipboard (no trailing newline)
function cpwd() {
    printf '%s' "$PWD" | pbcopy
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                         Claude Code Functions                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

CC_PROFILES="$HOME/.config/claude-code/profiles.conf"

# 切换 profile：cc deepseek / cc openrouter / cc（不带参数列出所有）
function cc() {
  local profile="$1"

  # 不带参数：列出所有可用 profiles
  if [[ -z "$profile" ]]; then
    echo "可用 profiles："
    grep -v '^\s*#' "$CC_PROFILES" | grep -v '^\s*$' | while IFS='|' read -r name rest; do
      if [[ "$name" == "$CC_ACTIVE_PROFILE" ]]; then
        echo "  ● $name（当前）"
      else
        echo "  ○ $name"
      fi
    done
    return 0
  fi

  # 特殊值：切回官方 Anthropic
  if [[ "$profile" == "anthropic" ]]; then
    _cc_unload
    echo "✓ 已切回 Claude Code 官方模式"
    return 0
  fi

  # 从配置文件里找到对应行
  local line
  line=$(grep -v '^\s*#' "$CC_PROFILES" | grep "^${profile}|")

  if [[ -z "$line" ]]; then
    echo "错误：找不到 profile「$profile」"
    echo "运行 cc 查看可用列表"
    return 1
  fi

  # 解析字段
  IFS='|' read -r name base_url model opus_model sonnet_model haiku_model subagent_model effort <<< "$line"

  # 从 Keychain 取密钥
  local token
  token=$(security find-generic-password -a "$name" -s "claude-code-${name}" -w 2>/dev/null)

  if [[ -z "$token" ]]; then
    echo "错误：Keychain 中找不到「claude-code-${name}」的密钥"
    echo "请先运行："
    echo "  security add-generic-password -a \"$name\" -s \"claude-code-${name}\" -w \"你的密钥\""
    return 1
  fi

  # 卸载旧配置，加载新配置
  _cc_unload
  export ANTHROPIC_BASE_URL="$base_url"
  export ANTHROPIC_AUTH_TOKEN="$token"
  export ANTHROPIC_MODEL="$model"
  export ANTHROPIC_DEFAULT_OPUS_MODEL="$opus_model"
  export ANTHROPIC_DEFAULT_SONNET_MODEL="$sonnet_model"
  export ANTHROPIC_DEFAULT_HAIKU_MODEL="$haiku_model"
  export CLAUDE_CODE_SUBAGENT_MODEL="$subagent_model"
  export CLAUDE_CODE_EFFORT_LEVEL="$effort"
  export CC_ACTIVE_PROFILE="$name"

  echo "✓ 已切换到 $name（$base_url）"
}

# 卸载所有相关环境变量
function _cc_unload() {
  unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL \
        ANTHROPIC_DEFAULT_OPUS_MODEL ANTHROPIC_DEFAULT_SONNET_MODEL \
        ANTHROPIC_DEFAULT_HAIKU_MODEL CLAUDE_CODE_SUBAGENT_MODEL \
        CLAUDE_CODE_EFFORT_LEVEL CC_ACTIVE_PROFILE
}

# 查看当前状态
function ccstatus() {
  if [[ -z "$CC_ACTIVE_PROFILE" ]]; then
    echo "当前：官方 Anthropic 模式"
  else
    echo "当前 profile：$CC_ACTIVE_PROFILE"
    echo "BASE_URL：$ANTHROPIC_BASE_URL"
    echo "MODEL：$ANTHROPIC_MODEL"
  fi
}

# Tab 补全
_cc_profiles() {
  local profiles
  profiles=$(grep -v '^\s*#' "$CC_PROFILES" 2>/dev/null | grep -v '^\s*$' | cut -d'|' -f1 | tr '\n' ' ')
  compadd anthropic $profiles
}
compdef _cc_profiles cc
