# 🌃 Personal Dotfiles - Custom Theme

A comprehensive dotfiles setup with a custom terminal theme based on dark colors and clean aesthetics. This setup provides automated installation and configuration for both macOS and Linux systems.

## 🚀 Quick Setup

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Run the setup script
./setup.sh
```

## 🎨 Features

### **Custom Theme**
- Beautiful dark color scheme throughout all tools
- Consistent theming across vim, shell, tmux, and terminal tools
- Clean, minimal design with text-based git status

### **Vim Configuration**
- Custom color scheme with transparent backgrounds
- Custom theme inspired colors adapted to your preferences
- Comprehensive plugin setup with coc.nvim
- Visual dimming functionality
- Works perfectly with any terminal background

### **Shell Setup**
- Zsh with Oh My Zsh and custom theme
- Clean git status: `branch: main | staged: 2 | ahead: 1`
- Box drawing characters: `╭─`, `├─`, `╰─`
- FZF integration with transparent backgrounds
- Comprehensive aliases and functions

### **Terminal Tools**
- **tmux**: Custom theme with beautiful dark colors
- **bat**: Custom syntax highlighting theme  
- **fzf**: Transparent backgrounds with custom colors
- **lazygit**: Custom theme configuration
- **git**: Enhanced with git-split-diffs

## 📁 Structure

```
new_dotfiles/
├── setup.sh                 # Main setup script
├── install/
│   ├── macos/               # macOS-specific installation
│   └── linux/               # Linux-specific installation
├── config/
│   ├── vim/                 # Vim configuration
│   ├── zsh/                 # Shell configuration
│   ├── tmux/                # Tmux configuration
│   ├── git/                 # Git configuration
│   └── terminal/            # Terminal tools config
└── themes/
    ├── vim/                 # Vim color schemes
    ├── zsh/                 # Shell themes
    └── terminal/            # Terminal themes
```

## 🛠️ What Gets Installed

### **Package Managers**
- **macOS**: Homebrew
- **Linux**: APT/YUM (auto-detected)

### **Development Tools**
- Git with enhanced configuration
- Node.js (via NVM)
- Python (via Pyenv)
- Essential build tools

### **Terminal Tools**
- zsh + Oh My Zsh
- tmux + tmuxinator
- fzf (fuzzy finder)
- bat (better cat)
- lazygit (git UI)
- tree (directory visualization)
- git-split-diffs (better git diffs)

### **Applications (macOS)**
- Docker
- Visual Studio Code

## 🔧 Manual Steps

After running the setup script, you may need to:

1. **Restart your terminal** to load the new shell configuration
2. **Reload tmux config**: `tmux source-file ~/.tmux.conf`
3. **Install Vim plugins**: Open vim and run `:PlugInstall`

## 📋 Requirements

### **macOS**
- macOS 10.15+ (Catalina or later)
- Xcode Command Line Tools
- Internet connection

### **Linux**
- Ubuntu 18.04+ or similar distro
- curl/wget
- Internet connection

## 🎯 Customization

### **Colors**
All theme colors are defined in configuration files and can be easily modified:
- Vim: `themes/vim/custom.vim`
- Shell: `themes/zsh/custom.zsh-theme`
- Terminal tools: `config/terminal/*/`

### **Shell Aliases**
Common aliases are defined in the shell configuration:
- `v` - Open files with vim using fzf
- `lg` - Launch lazygit
- `gb` - Git branch selector with fzf
- `gco` - Git checkout with branch creation

### **Tmux Key Bindings**
- `<prefix> + h/j/k/l` - Navigate panes
- `<prefix> + G` - Open lazygit in popup
- `<prefix> + T` - File tree in popup
- `<prefix> + F` - File editor in popup

## 🐛 Troubleshooting

### **Font Issues**
Install a Nerd Font for proper icon display:
```bash
# The setup script includes Meslo LG font installation
```

### **Colors Not Working**
Ensure your terminal supports true color:
```bash
echo $TERM
# Should be xterm-256color or screen-256color
```

### **Permission Issues**
Make sure the setup script is executable:
```bash
chmod +x setup.sh
```

## 📝 License

MIT License - Feel free to modify and share!

## 🙏 Acknowledgments

- Inspired by beautiful dark color schemes
- Built with modern terminal tools and practices
- Designed for developer productivity