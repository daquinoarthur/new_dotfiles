#!/bin/bash

# macOS Installation Script for Custom Dotfiles
# Installs Homebrew and all necessary packages

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }
log_step() { echo -e "${BLUE}🔄 $1${NC}"; }

# Check for Xcode Command Line Tools
install_xcode_tools() {
    log_step "Checking Xcode Command Line Tools..."
    
    if ! xcode-select -p &> /dev/null; then
        log_info "Installing Xcode Command Line Tools..."
        xcode-select --install
        
        log_warning "Please complete Xcode Command Line Tools installation"
        log_warning "Then run this script again"
        exit 0
    fi
    
    log_success "Xcode Command Line Tools installed"
}

# Install Homebrew
install_homebrew() {
    log_step "Installing Homebrew..."
    
    if command -v brew &> /dev/null; then
        log_info "Homebrew already installed"
        brew update
    else
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == 'arm64' ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
    
    log_success "Homebrew installed and updated"
}

# Install essential development tools
install_dev_tools() {
    log_step "Installing development tools..."
    
    local dev_tools=(
        "git"              # Version control
        "curl"             # HTTP client
        "wget"             # Download utility
        "tree"             # Directory visualization
        "jq"               # JSON processor
        "ripgrep"          # Better grep
        "fd"               # Better find
        "silver-searcher"  # Code search (ag)
    )
    
    for tool in "${dev_tools[@]}"; do
        if ! brew list "$tool" &> /dev/null; then
            log_info "Installing $tool..."
            brew install "$tool"
        fi
    done
    
    log_success "Development tools installed"
}

# Install terminal tools
install_terminal_tools() {
    log_step "Installing terminal tools..."
    
    local terminal_tools=(
        "zsh"              # Shell
        "tmux"             # Terminal multiplexer
        "tmuxinator"       # Tmux session manager
        "fzf"              # Fuzzy finder
        "bat"              # Better cat
        "eza"              # Better ls
        "bottom"           # System monitor
        "lazygit"          # Git UI
        "git-delta"        # Better git diff
        "git-split-diffs"  # Side-by-side git diffs
    )
    
    for tool in "${terminal_tools[@]}"; do
        if ! brew list "$tool" &> /dev/null; then
            log_info "Installing $tool..."
            brew install "$tool"
        fi
    done
    
    # Install fzf key bindings
    if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
        "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
    fi
    
    log_success "Terminal tools installed"
}

# Install programming languages and tools
install_programming_tools() {
    log_step "Installing programming languages and tools..."
    
    # Node.js via NVM
    if [[ ! -d "$HOME/.nvm" ]]; then
        log_info "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        
        # Source NVM
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        # Install latest LTS Node.js
        nvm install --lts
        nvm use --lts
        nvm alias default node
    fi
    
    # Python via Pyenv
    if ! command -v pyenv &> /dev/null; then
        log_info "Installing Pyenv..."
        brew install pyenv
        
        # Install Python build dependencies
        brew install openssl readline sqlite3 xz zlib
        
        # Install latest Python
        local python_version=$(pyenv install --list | grep -E "^\s*3\.[0-9]+\.[0-9]+$" | tail -1 | tr -d ' ')
        pyenv install "$python_version"
        pyenv global "$python_version"
    fi
    
    # Go
    if ! brew list "go" &> /dev/null; then
        log_info "Installing Go..."
        brew install go
    fi
    
    log_success "Programming tools installed"
}

# Install applications via Homebrew Cask
install_applications() {
    log_step "Installing applications..."
    
    local applications=(
        "docker"           # Containerization
        "visual-studio-code" # Code editor
        "iterm2"           # Better terminal
        "rectangle"        # Window management
    )
    
    for app in "${applications[@]}"; do
        if ! brew list --cask "$app" &> /dev/null; then
            log_info "Installing $app..."
            brew install --cask "$app" || log_warning "Failed to install $app"
        fi
    done
    
    log_success "Applications installed"
}

# Install Oh My Zsh
install_oh_my_zsh() {
    log_step "Installing Oh My Zsh..."
    
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        # Install useful plugins
        local plugin_dir="$HOME/.oh-my-zsh/custom/plugins"
        
        # zsh-autosuggestions
        if [[ ! -d "$plugin_dir/zsh-autosuggestions" ]]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
        fi
        
        # zsh-syntax-highlighting
        if [[ ! -d "$plugin_dir/zsh-syntax-highlighting" ]]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting "$plugin_dir/zsh-syntax-highlighting"
        fi
    else
        log_info "Oh My Zsh already installed"
    fi
    
    log_success "Oh My Zsh setup complete"
}

# Install fonts
install_fonts() {
    log_step "Installing fonts..."
    
    # Install Nerd Fonts
    local fonts=(
        "font-meslo-lg-nerd-font"
        "font-fira-code-nerd-font"
        "font-jetbrains-mono-nerd-font"
    )
    
    # Add font tap if not already added
    brew tap homebrew/cask-fonts || true
    
    for font in "${fonts[@]}"; do
        if ! brew list --cask "$font" &> /dev/null; then
            log_info "Installing $font..."
            brew install --cask "$font" || log_warning "Failed to install $font"
        fi
    done
    
    log_success "Fonts installed"
}

# Configure macOS defaults
configure_macos_defaults() {
    log_step "Configuring macOS defaults..."
    
    # Show hidden files in Finder
    defaults write com.apple.finder AppleShowAllFiles -bool true
    
    # Show file extensions in Finder
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    
    # Disable the "Are you sure you want to open this application?" dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    
    # Enable full keyboard access for all controls
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    
    # Set fast key repeat
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 10
    
    # Show the ~/Library folder
    chflags nohidden ~/Library
    
    log_success "macOS defaults configured"
}

# Set default shell to zsh
set_default_shell() {
    log_step "Setting default shell to zsh..."
    
    local zsh_path="/bin/zsh"
    if [[ "$SHELL" != "$zsh_path" ]]; then
        if ! grep -q "$zsh_path" /etc/shells; then
            echo "$zsh_path" | sudo tee -a /etc/shells
        fi
        chsh -s "$zsh_path"
        log_success "Default shell set to zsh"
    else
        log_info "Zsh is already the default shell"
    fi
}

# Main installation function
main() {
    log_info "Starting macOS installation..."
    echo
    
    install_xcode_tools
    install_homebrew
    install_dev_tools
    install_terminal_tools
    install_programming_tools
    install_applications
    install_oh_my_zsh
    install_fonts
    configure_macos_defaults
    set_default_shell
    
    echo
    log_success "macOS installation complete!"
}

# Run main function
main "$@"