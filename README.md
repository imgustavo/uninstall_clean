# Advanced Application Uninstaller

![Bash](https://img.shields.io/badge/Shell-Zsh-4EAA25?logo=gnu-bash)
![License](https://img.shields.io/badge/License-MIT-blue)

A powerful, interactive script to completely remove applications from Linux systems, including associated processes, packages, configurations, and residual files.

## Features

- **Complete Removal**: Uninstalls applications across multiple package managers (APT, Snap, Flatpak)
- **Process Cleanup**: Finds and kills running processes (with confirmation)
- **Configuration Purge**: Removes config files from common locations
- **Residual Cleanup**: Finds and removes leftover files system-wide
- **Interactive Prompts**: Confirms each destructive action
- **Comprehensive Logging**: Detailed log file of all actions
- **Color-coded Output**: Easy-to-read terminal interface
- **Root Detection**: Auto-elevates with sudo when needed

## Installation

### System-wide Installation (recommended):

```bash
sudo curl -o /usr/local/bin/cleanuninstall https://raw.githubusercontent.com/yourrepo/cleanuninstall/main/cleanuninstall.sh
sudo chmod +x /usr/local/bin/cleanuninstall
```

## User Installation:

```bash
mkdir -p ~/.local/bin
curl -o ~/.local/bin/cleanuninstall https://raw.githubusercontent.com/yourrepo/cleanuninstall/main/cleanuninstall.sh
chmod +x ~/.local/bin/cleanuninstall
```

Note: For user installation, ensure ~/.local/bin is in your PATH:


```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc  # or ~/.zshrc
source ~/.bashrc
```

## Usage

Basic syntax:

```bash
cleanuninstall <application_name>
```

Examples:

```bash
cleanuninstall vscode
cleanuninstall google-chrome
cleanuninstall sublime-text
```

## Workflow
1. Process Check: Identifies running application processes

2. Package Removal: Uninstalls via all detected package managers

3. Config Cleanup: Removes user and system configuration files

4. Residual Cleanup: Finds and removes leftover files

5. System Cleanup: Optional apt autoremove and cleanup

## Requirements
- Linux (tested on Debian/Ubuntu and derivatives)

- Zsh (or Bash with minor adjustments)

- Standard GNU tools: grep, awk, find, ps, etc.

- Root access (for system-wide uninstallation)

# Supported Package Managers

- APT (Debian/Ubuntu)

- Snap

- Flatpak

# Configuration
The script automatically detects configuration files in these locations:

- ~/.config/<app>

- ~/.local/share/<app>

- /etc/<app>

- /opt/<app>

# Logging

A detailed log is created at:

```bash
~/uninstaller_<app>.log
```

## Safety Features
- Interactive confirmation before each destructive action

- No silent deletions - everything is logged

- Preserves terminal session processes

- Validates application names for safety

- Skip option available for every step

## Troubleshooting

Q: Script doesn't find my application
A: Try using the exact package name as shown in your package manager

Q: Getting permission errors
A: Ensure you're running with sudo or as root

Q: Process detection shows wrong applications
A: Use more specific application names or report an issue

---
***Pro Tip:*** Combine with watch to monitor system changes during uninstall:

```bash
watch -d 'df -h; echo; ls -l ~/.config | grep -i <app>'
```

## License
MIT License - See LICENSE for details
