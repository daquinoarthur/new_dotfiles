# Custom Oh My Zsh Theme
# A modern, clean theme with custom colors and text descriptions
# Version: 2.0

# Custom Color Palette
local c_bg="%F{#1a1b26}"
local c_fg="%F{#c0caf5}"
local c_blue="%F{#7aa2f7}"
local c_purple="%F{#bb9af7}"
local c_cyan="%F{#7dcfff}"
local c_green="%F{#9ece6a}"
local c_yellow="%F{#e0af68}"
local c_red="%F{#f7768e}"
local c_gray="%F{#565f89}"
local c_light_gray="%F{#a9b1d6}"
local reset="%f"

# Text descriptions (no icons)
local label_git=""
local label_branch="branch:"
local label_staged="staged:"
local label_unstaged="unstaged:"
local label_untracked="untracked:"
local label_stash="stash:"
local label_ahead="ahead:"
local label_behind="behind:"
local label_clean="clean"
local label_time="time:"

# Helper function to get current directory (no icons)
function _c_current_dir() {
    local dir_path="${PWD/#$HOME/~}"
    
    # Show directory with appropriate colors
    if [[ "$PWD" == "$HOME" ]]; then
        echo "${c_blue}~${reset}"
    elif [[ -d ".git" ]]; then
        echo "${c_blue}${dir_path}${reset}"
    else
        echo "${c_blue}${dir_path}${reset}"
    fi
}

# Git status function with custom colors
function _c_git_status() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return
    fi

    local git_status=""
    local branch_name
    local separator=" ${c_gray}|${reset} "
    
    # Get branch name
    branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    
    if [[ -n "$branch_name" ]]; then
        git_status+="${c_green}${label_branch} ${branch_name}${reset}"
        
        # Check for changes
        local staged=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
        local unstaged=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
        local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
        local stashed=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
        
        # Show status indicators with separators
        [[ $staged -gt 0 ]] && git_status+="${separator}${c_green}${label_staged} ${staged}${reset}"
        [[ $unstaged -gt 0 ]] && git_status+="${separator}${c_yellow}${label_unstaged} ${unstaged}${reset}"
        [[ $untracked -gt 0 ]] && git_status+="${separator}${c_red}${label_untracked} ${untracked}${reset}"
        [[ $stashed -gt 0 ]] && git_status+="${separator}${c_cyan}${label_stash} ${stashed}${reset}"
        
        # Check for ahead/behind
        local ahead_behind
        ahead_behind=$(git rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null)
        if [[ -n "$ahead_behind" ]]; then
            local behind=$(echo "$ahead_behind" | cut -f1)
            local ahead=$(echo "$ahead_behind" | cut -f2)
            
            [[ $ahead -gt 0 ]] && git_status+="${separator}${c_cyan}${label_ahead} ${ahead}${reset}"
            [[ $behind -gt 0 ]] && git_status+="${separator}${c_red}${label_behind} ${behind}${reset}"
        fi
        
        # Clean status
        if [[ $staged -eq 0 && $unstaged -eq 0 && $untracked -eq 0 ]]; then
            git_status+="${separator}${c_green}${label_clean}${reset}"
        fi
    fi
    
    echo "$git_status"
}

# Command execution time
function _c_exec_time() {
    if [[ -n "$_c_command_start_time" ]]; then
        local end_time=$(date +%s)
        local elapsed=$((end_time - _c_command_start_time))
        
        if [[ $elapsed -gt 2 ]]; then
            echo " ${c_gray}${label_time} ${elapsed}s${reset}"
        fi
    fi
}

# Pre-command hook to capture start time
function _c_preexec() {
    _c_command_start_time=$(date +%s)
}

# Post-command hook to clear start time
function _c_precmd() {
    unset _c_command_start_time
}

# Add hooks
autoload -Uz add-zsh-hook
add-zsh-hook preexec _c_preexec
add-zsh-hook precmd _c_precmd

# Check if user has write permissions
function _c_prompt_char() {
    if [[ ! -w "$PWD" ]]; then
        echo "${c_red}[LOCKED]${reset}"
    elif [[ $UID -eq 0 ]]; then
        echo "${c_red}#${reset}"
    else
        echo ""
    fi
}

# Virtual environment indicator
function _c_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        echo " ${c_yellow}(${venv_name})${reset}"
    fi
}


# Main prompt construction
PROMPT='
${c_purple}╭─${reset} $(_c_current_dir)$(_c_venv)
${c_purple}├─${reset} $(_c_git_status)$(_c_exec_time)
${c_purple}╰─$(_c_prompt_char) '


# Right prompt (optional)
RPROMPT=''

# Continuation prompt
PROMPT2="${c_purple}╰─${reset} ${c_gray}>${reset} "

# Selection prompt
PROMPT3="${c_yellow}?${reset} "

# Execution trace prompt
PROMPT4="${c_gray}+${reset} "
