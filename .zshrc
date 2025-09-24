# If not running interactively, do nothing
[[ $- != *i* ]] && return

# --- environment helpers
# prefer user-local bin in PATH early (adjust if you manage PATH elsewhere)
#export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# load rust/cargo env if present
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# load any local env script if present
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

export PATH=$PATH:$HOME/go/bin # add go packaged like bootdev to path
export GPG_TTY=$(tty) # add GPG key to startup

alias lvim='NVIM_APPNAME="lazyvim" nvim'

# --- history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY         # append to history file
setopt INC_APPEND_HISTORY     # write immediately
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
export HISTORY_IGNORE=""
# share history across sessions if you want realtime sync:
# setopt SHARE_HISTORY

# --- aliases (guard tools exist)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -A --icons=always --color=always --git'
else
  alias ls='ls -A --color=auto'
fi
if command -v grep >/dev/null 2>&1; then
  alias grep='grep --color=auto'
fi

# --- completions + fpath (set before compinit)
fpath=("$HOME/.config/zsh/eza/completions/zsh" "$HOME/.config/zsh/zsh-completions" $fpath)

# initialize completion system
autoload -U compinit
# if compinit warns about insecure files, run `compaudit` and fix permissions, or use -u consciously
compinit

# --- fzf (reverse-search integration)
if command -v fzf >/dev/null 2>&1; then
  # enable key bindings and completion integration provided by fzf
  source <(fzf --zsh) || true
fi


# --- fzf-tab (if installed)
if [ -f "$HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh" ]; then
  source "$HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh"
  zstyle ':completion:*' menu no
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
  zstyle ':fzf-tab:*' use-fzf-default-opts yes
  zstyle ':fzf-tab:*' switch-group '<' '>'
  # preview cd and zoxide completions with eza if eza exists
  if command -v eza >/dev/null 2>&1; then
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always --color=always --git $realpath'
  fi
  # disable sorting for git-checkout completion
  zstyle ':completion:*:git-checkout:*' sort false
fi

# --- zoxide (if installed)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# --- oh-my-posh (if installed)
if command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh-themes/themes/quick-term2.omp.json)"
fi

# --- completions path for extra completion files
# ensure fpath already set above. compinit run already.
# (additional completion dirs can be pushed here)
# fpath=("$HOME/.config/zsh/other-completions" $fpath)

# --- autosuggestions + syntax-highlighting
[ -f "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
# syntax-highlighting must be last
[ -f "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --- history substring search and key bindings (after autosuggestions / highlighting)
[ -f "$HOME/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh" ] && source "$HOME/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# emacs/vicmd bindings
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# --- completion colors
# Use LS_COLORS for list-colors if present. Avoid using unknown ${eza} var.
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# --- final housekeeping
# export FPATH once (Zsh uses fpath array; exporting FPATH is optional)
export FPATH

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
