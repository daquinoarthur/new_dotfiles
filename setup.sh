#!/bin/bash

# PERSONAL DOTFILES SETUP SCRIPT
# ==============================
# Automated installation and configuration for macOS and Linux

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ASCII art header
print_header() {
    echo -e "${PURPLE}"
    cat << "EOF"
   ╭─────────────────────────────────────────────────────────────╮
   │  Personal Dotfiles - Custom Theme Setup                     │
   │                                                             │
   │  Automated installation for macOS and Linux                 │
   ╰─────────────────────────────────────────────────────────────╯
EOF
    echo -e "${NC}"
}

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_step() {
    echo -e "${CYAN}🔄 $1${NC}"
}

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        log_info "Detected: macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        log_info "Detected: Linux"
        
        # Detect Linux distribution
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            DISTRO=$ID
            log_info "Distribution: $PRETTY_NAME"
        fi
    else
        log_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

# Check prerequisites
check_prerequisites() {
    log_step "Checking prerequisites..."
    
    # Check for internet connection
    if ! curl -s --connect-timeout 5 https://google.com > /dev/null 2>&1 && \
       ! wget -q --spider --timeout=5 https://google.com > /dev/null 2>&1; then
        log_warning "Internet connectivity check failed, but proceeding anyway..."
        log_info "If installation fails, please check your network connection"
    fi
    
    # Check if running as root
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root"
        log_info "Please create a regular user account and run this script from there"
        exit 1
    fi
    
    log_success "Prerequisites check passed"
}

# Backup existing configurations
backup_configs() {
    log_step "Backing up existing configurations..."
    
    local backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # List of files to backup
    local files_to_backup=(
        ".vimrc"
        ".zshrc" 
        ".bashrc"
        ".tmux.conf"
        ".gitconfig"
        ".vim"
        ".oh-my-zsh/custom/themes"
    )
    
    for file in "${files_to_backup[@]}"; do
        if [[ -e "$HOME/$file" ]]; then
            cp -r "$HOME/$file" "$backup_dir/" 2>/dev/null || true
            log_info "Backed up: $file"
        fi
    done
    
    log_success "Backup created at: $backup_dir"
}

# Create symbolic links
create_symlinks() {
    log_step "Creating symbolic links..."
    
    # Helper function to create symlink with backup
    create_symlink() {
        local source="$1"
        local target="$2"
        local description="$3"
        
        # Create target directory if needed
        local target_dir="$(dirname "$target")"
        [[ ! -d "$target_dir" ]] && mkdir -p "$target_dir"
        
        # Remove existing file/link
        [[ -e "$target" ]] && rm -rf "$target"
        
        # Create symlink
        ln -sf "$source" "$target"
        log_info "Linked: $description"
    }
    
    # Vim configuration
    create_symlink "$SCRIPT_DIR/config/vim/.vimrc" "$HOME/.vimrc" "Vim config"
    create_symlink "$SCRIPT_DIR/config/vim" "$HOME/.vim" "Vim directory"
    
    # Ensure vim-plug autoload directory exists
    mkdir -p "$HOME/.vim/autoload"
    
    # Shell configuration
    create_symlink "$SCRIPT_DIR/config/zsh/zshrc" "$HOME/.zshrc" "Zsh config"
    create_symlink "$SCRIPT_DIR/config/zsh/bashrc" "$HOME/.bashrc" "Bash config"
    
    # Tmux configuration
    create_symlink "$SCRIPT_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf" "Tmux config"
    
    # Git configuration
    create_symlink "$SCRIPT_DIR/config/git/.gitconfig" "$HOME/.gitconfig" "Git config"
    
    # Terminal tools
    create_symlink "$SCRIPT_DIR/config/terminal/bat/config" "$HOME/.config/bat/config" "Bat config"
    create_symlink "$SCRIPT_DIR/config/terminal/lazygit/config.yml" "$HOME/.config/lazygit/config.yml" "Lazygit config"
    
    # Custom theme
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        create_symlink "$SCRIPT_DIR/themes/zsh/custom.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/custom.zsh-theme" "Custom Zsh theme"
    fi
    
    log_success "Symbolic links created"
}

# Install bat themes
install_bat_themes() {
    log_step "Installing bat themes..."
    
    local bat_themes_dir="$HOME/.config/bat/themes"
    mkdir -p "$bat_themes_dir"
    
    # Copy custom themes
    if [[ -d "$SCRIPT_DIR/config/terminal/bat/themes" ]]; then
        cp "$SCRIPT_DIR/config/terminal/bat/themes"/*.tmTheme "$bat_themes_dir/" 2>/dev/null || true
    fi
    
    # Build bat cache
    if command -v bat &> /dev/null; then
        bat cache --build &> /dev/null || true
        log_success "Bat themes installed"
    fi
}

# Post-installation steps
post_install() {
    log_step "Performing post-installation setup..."
    
    # Install Vim plugins if vim-plug is available
    if [[ -f "$HOME/.vim/autoload/plug.vim" ]] && command -v vim &> /dev/null; then
        log_info "Installing Vim plugins..."
        vim +PlugInstall +qall 2>/dev/null || true
    else
        log_warning "vim-plug or vim not available, skipping plugin installation"
        log_info "You can manually run: vim +PlugInstall +qall"
    fi
    
    # Set up Tmux Plugin Manager
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        log_info "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || true
    fi
    
    log_success "Post-installation setup complete"
}

# Main execution
main() {
    print_header
    
    log_info "Starting dotfiles setup..."
    echo
    
    # Run setup steps
    detect_os
    check_prerequisites
    backup_configs
    
    # Run OS-specific installation
    local install_script="$SCRIPT_DIR/install/$OS/install.sh"
    if [[ -f "$install_script" ]]; then
        log_step "Running $OS installation script..."
        bash "$install_script"
    else
        log_error "Installation script not found: $install_script"
        exit 1
    fi
    
    # Common setup steps
    create_symlinks
    install_bat_themes
    post_install
    
    echo
    log_success "🎉 Dotfiles setup complete!"
    echo
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Restart your terminal"
    echo "  2. Reload tmux config: tmux source-file ~/.tmux.conf"
    echo "  3. Open vim and run :PlugInstall if needed"
    echo
    echo -e "${CYAN}Enjoy your beautiful custom terminal! 🌃${NC}"
}

# Run main function
main "$@"
