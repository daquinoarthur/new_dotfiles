#!/bin/bash

# Linux Installation Script for Custom Dotfiles
# Supports Ubuntu/Debian and RHEL/CentOS/Fedora distributions

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

# Detect Linux distribution
detect_distro() {
    log_step "Detecting Linux distribution..."
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        DISTRO_VERSION=$VERSION_ID
        log_info "Detected: $PRETTY_NAME"
        
        case $DISTRO in
            ubuntu|debian)
                PACKAGE_MANAGER="apt"
                UPDATE_CMD="apt update"
                INSTALL_CMD="apt install -y"
                ;;
            fedora|rhel|centos)
                if command -v dnf &> /dev/null; then
                    PACKAGE_MANAGER="dnf"
                    UPDATE_CMD="dnf update -y"
                    INSTALL_CMD="dnf install -y"
                else
                    PACKAGE_MANAGER="yum"
                    UPDATE_CMD="yum update -y"
                    INSTALL_CMD="yum install -y"
                fi
                ;;
            arch|manjaro)
                PACKAGE_MANAGER="pacman"
                UPDATE_CMD="pacman -Syu --noconfirm"
                INSTALL_CMD="pacman -S --noconfirm"
                ;;
            *)
                log_error "Unsupported distribution: $DISTRO"
                exit 1
                ;;
        esac
    else
        log_error "Cannot detect Linux distribution"
        exit 1
    fi
    
    log_success "Package manager: $PACKAGE_MANAGER"
}

# Configure non-interactive installation
configure_noninteractive() {
    log_step "Configuring non-interactive installation..."
    
    # Set environment variables to avoid interactive prompts
    export DEBIAN_FRONTEND=noninteractive
    export TZ=America/Fortaleza
    export NEEDRESTART_MODE=a  # Automatic restart services
    export NEEDRESTART_SUSPEND=1  # Don't ask about restarting services
    
    case $PACKAGE_MANAGER in
        apt)
            # Pre-seed timezone configuration to avoid interactive prompts
            echo 'tzdata tzdata/Areas select America' | sudo debconf-set-selections 2>/dev/null || true
            echo 'tzdata tzdata/Zones/America select Fortaleza' | sudo debconf-set-selections 2>/dev/null || true
            
            # Also try to set timezone directly
            sudo ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime 2>/dev/null || true
            echo 'America/Fortaleza' | sudo tee /etc/timezone >/dev/null 2>&1 || true
            ;;
    esac
    
    log_info "Environment configured for non-interactive installation"
    log_success "Non-interactive mode configured"
}

# Update system packages
update_system() {
    log_step "Updating system packages..."
    
    case $PACKAGE_MANAGER in
        apt)
            sudo apt update && sudo apt upgrade -y
            ;;
        dnf|yum)
            sudo $UPDATE_CMD
            ;;
        pacman)
            sudo $UPDATE_CMD
            ;;
    esac
    
    log_success "System packages updated"
}

# Install essential development tools
install_dev_tools() {
    log_step "Installing development tools..."
    
    case $PACKAGE_MANAGER in
        apt)
            local dev_tools=(
                "build-essential"     # Build tools
                "curl"                # HTTP client
                "wget"                # Download utility
                "git"                 # Version control
                "vim"                 # Text editor
                "tree"                # Directory visualization
                "jq"                  # JSON processor
                "ripgrep"             # Better grep
                "fd-find"             # Better find
                "silversearcher-ag"   # Code search
                "software-properties-common" # For adding PPAs
                "apt-transport-https" # HTTPS support for apt
                "ca-certificates"     # SSL certificates
                "gnupg"               # GPG support
                "lsb-release"         # Distribution info
            )
            ;;
        dnf|yum)
            local dev_tools=(
                "gcc"                 # C compiler
                "gcc-c++"             # C++ compiler
                "make"                # Build tool
                "curl"                # HTTP client
                "wget"                # Download utility
                "git"                 # Version control
                "vim"                 # Text editor
                "tree"                # Directory visualization
                "jq"                  # JSON processor
                "ripgrep"             # Better grep
                "fd-find"             # Better find
                "the_silver_searcher" # Code search
                "dnf-plugins-core"    # DNF plugins
            )
            ;;
        pacman)
            local dev_tools=(
                "base-devel"          # Build tools
                "curl"                # HTTP client
                "wget"                # Download utility
                "git"                 # Version control
                "vim"                 # Text editor
                "tree"                # Directory visualization
                "jq"                  # JSON processor
                "ripgrep"             # Better grep
                "fd"                  # Better find
                "the_silver_searcher" # Code search
            )
            ;;
    esac
    
    for tool in "${dev_tools[@]}"; do
        log_info "Installing $tool..."
        sudo $INSTALL_CMD "$tool" || log_warning "Failed to install $tool"
    done
    
    log_success "Development tools installed"
}

# Install terminal tools
install_terminal_tools() {
    log_step "Installing terminal tools..."
    
    case $PACKAGE_MANAGER in
        apt)
            local terminal_tools=(
                "zsh"                 # Shell
                "tmux"                # Terminal multiplexer
                "fzf"                 # Fuzzy finder
                "bat"                 # Better cat
                "eza"                 # Better ls (replacement for exa)
                "btop"                # System monitor
                "htop"                # Process viewer
                "ncdu"                # Disk usage analyzer
                "unzip"               # Archive tool
                "zip"                 # Archive tool
                "xclip"               # Clipboard utility
            )
            ;;
        dnf|yum)
            local terminal_tools=(
                "zsh"                 # Shell
                "tmux"                # Terminal multiplexer
                "fzf"                 # Fuzzy finder
                "bat"                 # Better cat
                "eza"                 # Better ls (replacement for exa)
                "btop"                # System monitor
                "htop"                # Process viewer
                "ncdu"                # Disk usage analyzer
                "unzip"               # Archive tool
                "zip"                 # Archive tool
                "xclip"               # Clipboard utility
            )
            ;;
        pacman)
            local terminal_tools=(
                "zsh"                 # Shell
                "tmux"                # Terminal multiplexer
                "fzf"                 # Fuzzy finder
                "bat"                 # Better cat
                "eza"                 # Better ls (replacement for exa)
                "btop"                # System monitor
                "htop"                # Process viewer
                "ncdu"                # Disk usage analyzer
                "unzip"               # Archive tool
                "zip"                 # Archive tool
                "xclip"               # Clipboard utility
            )
            ;;
    esac
    
    for tool in "${terminal_tools[@]}"; do
        log_info "Installing $tool..."
        sudo $INSTALL_CMD "$tool" || log_warning "Failed to install $tool"
    done
    
    log_success "Terminal tools installed"
}

# Install Git tools
install_git_tools() {
    log_step "Installing Git tools..."
    
    # Install lazygit
    if ! command -v lazygit &> /dev/null; then
        log_info "Installing lazygit..."
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
    fi
    
    # Install git-delta
    if ! command -v delta &> /dev/null; then
        log_info "Installing git-delta..."
        DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
        curl -Lo delta.tar.gz "https://github.com/dandavison/delta/releases/latest/download/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
        tar xf delta.tar.gz
        sudo install "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta" /usr/local/bin/
        rm -rf delta.tar.gz "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu"
    fi
    
    # Install git-split-diffs via npm (will be available after Node.js installation)
    
    log_success "Git tools installed"
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
        
        # Install global packages
        npm install -g git-split-diffs
    fi
    
    # Python via Pyenv
    if ! command -v pyenv &> /dev/null && [[ ! -d "$HOME/.pyenv" ]]; then
        log_info "Installing Pyenv..."
        
        # Install Python build dependencies
        case $PACKAGE_MANAGER in
            apt)
                sudo $INSTALL_CMD make build-essential libssl-dev zlib1g-dev \
                libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
                ;;
            dnf|yum)
                sudo $INSTALL_CMD make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite \
                sqlite-devel openssl-devel tk-devel libffi-devel xz-devel
                ;;
            pacman)
                sudo $INSTALL_CMD make gcc zlib bzip2 readline sqlite openssl tk libffi xz
                ;;
        esac
        
        # Install Pyenv
        curl https://pyenv.run | bash
        
        # Add to PATH
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        
        # Install latest Python
        local python_version=$(pyenv install --list | grep -E "^[[:space:]]*3\.[0-9]+\.[0-9]+$" | tail -1 | sed 's/^[[:space:]]*//')
        pyenv install "$python_version"
        pyenv global "$python_version"
    fi
    
    # Go
    if ! command -v go &> /dev/null; then
        log_info "Installing Go..."
        
        # Try to get latest version, fallback to known stable version
        GO_VERSION=$(curl -s https://api.github.com/repos/golang/go/releases/latest | sed -n 's/.*"tag_name": "go\([^"]*\)".*/\1/p' | head -1)
        
        # Fallback to stable version if API call fails
        if [[ -z "$GO_VERSION" ]]; then
            GO_VERSION="1.23.4"  # Known stable version
            log_info "Using fallback Go version: $GO_VERSION"
        else
            log_info "Found Go version: $GO_VERSION"
        fi
        
        # Download and install Go
        if curl -Lo go.tar.gz "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" 2>/dev/null; then
            sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz
            rm go.tar.gz
            
            # Add to PATH (will be handled by shell config)
            echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.profile"
            log_success "Go $GO_VERSION installed"
        else
            log_warning "Failed to download Go, skipping installation"
        fi
    fi
    
    log_success "Programming tools installed"
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

# Install vim-plug
install_vim_plug() {
    log_step "Installing vim-plug..."
    
    # Install vim-plug if not already installed
    if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
        log_info "Downloading vim-plug..."
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>/dev/null || \
        wget -O "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>/dev/null || \
        log_warning "Failed to download vim-plug"
    else
        log_info "vim-plug already installed"
    fi
    
    log_success "vim-plug setup complete"
}

# Install fonts (if GUI environment is available)
install_fonts() {
    log_step "Installing fonts..."
    
    # Check if running in GUI environment
    if [[ -n "$DISPLAY" ]] || [[ -n "$WAYLAND_DISPLAY" ]]; then
        log_info "GUI environment detected, installing Nerd Fonts..."
        
        # Create fonts directory
        local fonts_dir="$HOME/.local/share/fonts"
        mkdir -p "$fonts_dir"
        
        # Download and install Nerd Fonts
        local fonts=(
            "Meslo"
            "FiraCode"
            "JetBrainsMono"
        )
        
        for font in "${fonts[@]}"; do
            if [[ ! -f "$fonts_dir/${font}*" ]]; then
                log_info "Installing $font Nerd Font..."
                curl -Lo "${font}.zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.zip"
                unzip -o "${font}.zip" -d "$fonts_dir/"
                rm "${font}.zip"
            fi
        done
        
        # Update font cache
        fc-cache -fv
        
        log_success "Fonts installed"
    else
        log_info "No GUI environment detected, skipping font installation"
    fi
}

# Configure shell defaults
configure_shell_defaults() {
    log_step "Configuring shell defaults..."
    
    # In Docker or CI environments, skip shell change
    if [[ -f /.dockerenv ]] || [[ -n "$CI" ]]; then
        log_info "Container environment detected, skipping shell change"
        log_info "Shell configurations will be available when you start zsh manually"
        return
    fi
    
    # Set zsh as default shell
    local zsh_path=$(which zsh)
    if [[ "$SHELL" != "$zsh_path" ]]; then
        if ! grep -q "$zsh_path" /etc/shells; then
            if sudo -n echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null 2>&1; then
                log_info "Added zsh to /etc/shells"
            else
                log_warning "Could not add zsh to /etc/shells (needs sudo)"
            fi
        fi
        
        if timeout 5 chsh -s "$zsh_path" 2>/dev/null; then
            log_success "Default shell set to zsh"
        else
            log_warning "Could not change default shell to zsh"
            log_info "You can manually run: chsh -s $zsh_path"
        fi
    else
        log_info "Zsh is already the default shell"
    fi
}

# Install Docker (optional)
install_docker() {
    log_step "Installing Docker..."
    
    if ! command -v docker &> /dev/null; then
        log_info "Installing Docker..."
        
        case $PACKAGE_MANAGER in
            apt)
                # Add Docker's official GPG key
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
                
                # Add Docker repository
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                
                # Install Docker
                sudo apt update
                sudo $INSTALL_CMD docker-ce docker-ce-cli containerd.io docker-compose-plugin
                ;;
            dnf|yum)
                sudo $INSTALL_CMD dnf-plugins-core
                sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
                sudo $INSTALL_CMD docker-ce docker-ce-cli containerd.io docker-compose-plugin
                ;;
            pacman)
                sudo $INSTALL_CMD docker docker-compose
                ;;
        esac
        
        # Add user to docker group
        local current_user="${USER:-$(whoami)}"
        if [[ -n "$current_user" ]]; then
            sudo usermod -aG docker "$current_user"
            log_info "Added $current_user to docker group"
        else
            log_warning "Could not determine current user for docker group"
        fi
        
        # Enable and start Docker service (skip in containers)
        if [[ ! -f /.dockerenv ]]; then
            sudo systemctl enable docker 2>/dev/null || log_warning "Could not enable docker service"
            sudo systemctl start docker 2>/dev/null || log_warning "Could not start docker service"
        else
            log_info "Skipping docker service start in container environment"
        fi
        
        log_success "Docker installed"
        log_warning "Please logout and login again to use Docker without sudo"
    else
        log_info "Docker already installed"
    fi
}

# Main installation function
main() {
    log_info "Starting Linux installation..."
    echo
    
    detect_distro
    configure_noninteractive
    update_system
    install_dev_tools
    install_terminal_tools
    install_git_tools
    install_programming_tools
    install_oh_my_zsh
    install_vim_plug
    install_fonts
    configure_shell_defaults
    
    # Install Docker automatically
    install_docker
    
    echo
    log_success "Linux installation complete!"
    echo
    log_warning "Please restart your shell or logout/login to apply all changes"
}

# Run main function
main "$@"