# Ghost - Microsoft 365 Management Tool

**Ghost** is a PowerShell-based tool for managing **Microsoft 365 services**. It allows administrators to connect to **Exchange Online** and **Microsoft Teams**, as well as to temporarily enable or disable communication across the organization.

## 🚀 Features

- ✅ **Connect** to Exchange Online and Microsoft Teams
- 🚫 **Disable** email and chat communication organization-wide
- ✅ **Enable** email and chat communication when needed
- 📌 Simple CLI parameters for easy use
- 🔄 **Automatically installs missing PowerShell modules** (ExchangeOnlineManagement, MicrosoftTeams)

## 🎯 Usage

```sh
ghost -c -u admin@domain.com [-d | -e]
```

### Available Options

| Flag | Alias | Description |
|------|-------|-------------|
| `-c` | `--connect` | Connects to Microsoft 365 services |
| `-u` | `--user` | Specifies the admin email for connection |
| `-d` | `--disable` | Disables Outlook and Teams communication |
| `-e` | `--enable` | Enables Outlook and Teams communication |
| `-h` | `--help` | Displays help information |

## 📌 Example Commands

### Connect to Microsoft 365
```sh
ghost -c -u admin@domain.com
```

### Disable Communication
```sh
ghost -c -u admin@domain.com -d
```

### Enable Communication
```sh
ghost -c -u admin@domain.com -e
```

## 🛠 Requirements

- PowerShell 7+
- ExchangeOnlineManagement Module *(Auto-installed if missing)*
- MicrosoftTeams Module *(Auto-installed if missing)*

## 🔄 Automatic Module Installation
If required PowerShell modules are missing, Ghost will automatically prompt for installation and proceed with installation if confirmed by the user.

### How it Works:
1. **Ghost checks for required modules** at runtime.
2. If a module is missing, it asks the user for permission to install it.
3. If the user agrees, Ghost installs the missing module and proceeds with execution.

This ensures that administrators can run the tool seamlessly without worrying about missing dependencies.

