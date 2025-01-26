# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} 
# End configuration added by Zim install




## Added by Allen
#
# Source
#
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zoxide


# Options
#
# setopt EXTENDED_HISTORY
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M viins '^v' edit-command-line

# Aliases
#
alias TSc='sudo timeshift --create'
alias wine='env LANG=zh_CN.UTF-8 LANG=zh_CN.UTF-8 wine'
# alias wine-game='WINEPREFIX=~/.local/share/wineprefixes/game/ wine'
# alias pkgclean='sudo pacman -Rns $(pacman -Qqdt) && yes | sudo pacman -Sc && yes | paru -Sc'
alias pkgclean='sudo pacman -Sc && paru -Scc'
alias vim='nvim'
alias ls='lsd'
alias you-get='you-get -o ~/Videos'
# alias you-get-cookies='you-get -o ~/Videos -c ~/.mozilla/firefox/g1t7i3hf.default-release/cookies.sqlite'
alias prac-rs='cd ~/rust_work/rust-by-practice && git pull; mdbook serve -p 8888 -n 127.0.0.1 zh-CN/ && firefox http://127.0.0.1:8888/'
alias nc='mpd; ncmpcpp'
# alias ncmpcpp='mpd; waylyrics &> /dev/null &; ncmpcpp'
alias farsee='curl -F "c=@-" "https://fars.ee/"'
alias se='sudoedit'
alias hledger='hledger --file ~/repo/hledger/.hledger.journal'
alias HL='hledger'
alias HLa='hledger add'
alias HLb='hledger bs'
alias HLi='hledger is'
alias HLp='hledger print -x'
alias hledger-web='hledger-web -f ~/repo/hledger/.hledger.journal'
alias HLw='hledger-web'
alias tree='lsd --tree'
alias ranger='env LANG=zh_CN.UTF-8 LANGUAGE=zh_CN ranger'
alias yazi='env LANG=zh_CN.UTF-8 LANGUAGE=zh_CN yazi'
alias rm="echo This is not the command you are looking for. Use \'trash\' instead.; false"
alias get-ip="ip -4 addr | rg -i ppp0 -i | rg -i inet"
alias pac="sudo pacman -Syu"
# alias \$=' '
# alias %=' '
alias tree1='lsd --tree --depth 1'
alias tree2='lsd --tree --depth 2'
# alias ddg='w3m duckduckgo.com/lite'
# alias abs='w3m https://linux.die.net/abs-guide/'
alias sshlocal='ssh vboxer@127.0.0.1 -p 2222'
alias cmd-wrapped='cmd-wrapped -s atuin'
alias mf='musicfox'
alias nb="newsboat -r"
alias rw="random-wallpaper.sh"

# bat
alias cat="bat"
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# fzf
alias fpcache="pacman -Qq | fzf --preview 'ls /var/cache/pacman/pkg/{}-[0-9]*.pkg.tar.zst'"
alias fpact="pacman -Qq | fzf --preview 'pactree -d1 {}'"
alias fpactr="pacman -Qq | fzf --preview 'pactree -rd1 {}'"
alias ffont="fc-list | fzf"

# chezmoi
alias chr="chezmoi re-add"
alias cha="chezmoi add"
alias chg="chezmoi git --"

# config
alias i3c='nvim ~/.config/i3/config'

# Suffix aliases
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'


# Tools
#
if [ ! -n "$DISPLAY" ]; then # If in TTY console
    export STARSHIP_CONFIG=~/.config/starship/starship-tty.toml
    export ZELLIJ_CONFIG_FILE=~/.config/zellij/config-tty.kdl
    eval "$(zellij setup --generate-auto-start zsh)"
else
    export STARSHIP_CONFIG=~/.config/starship/starship-nerd-font-symbols.toml
fi

# eval "$(zellij setup --generate-auto-start zsh)"
eval "$(starship init zsh)"

source <(fzf --zsh)

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' atuin-search

eval $(thefuck --alias)



# Functions
# 
# Change the current working directory when exiting Yazi.
# Use y instead of yazi to start, and press q to quit, 
# you'll see the CWD changed. 
# Sometimes, you don't want to change, press Q to quit.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	\rm -f -- "$tmp"
}

# Create a Zellij instance with a useful session name
# either uses the current directory name, 
# or a parameter as the session_name variable. 
# It then tries to join an existing zellij session with that name, or creates a new one
function za() {
  local session_name=${1:-${PWD:t}}
  zellij attach "$session_name" || zellij -s "$session_name"
}
