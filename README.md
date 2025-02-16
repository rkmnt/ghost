# Ghost - Microsoft 365 Management Tool

![Supported OS](https://img.shields.io/badge/Supported-macOS-blue?style=for-the-badge&logo=apple)

**Ghost** is a PowerShell-based tool for managing **Microsoft 365 services**. It allows administrators to connect to **Exchange Online** and **Microsoft Teams**, as well as to temporarily enable or disable communication across the organization.

## 🚀 Features

- ✅ **Connect** to Exchange Online and Microsoft Teams
- 🚫 **Disable** email and chat communication organization-wide
- ✅ **Enable** email and chat communication when needed
- 📌 **Simple CLI interface** with intuitive parameters
- 🔄 **Automatically installs missing PowerShell modules** (ExchangeOnlineManagement, MicrosoftTeams)
- 🔍 **Validates input parameters** before execution

## 🖥 Supported Operating Systems

Ghost is officially supported on:
- **macOS** ✅

## 🎯 Usage

```sh
ghost -c -u admin@domain.com [-d | -e]
```

### Available Options

| Flag | Alias | Description |
|------|-------|-------------|
| `-c` | `--connect` | Connects to Microsoft 365 services |
| `-u` | `--user` | Specifies the admin email for connection (**Required with -c**) |
| `-d` | `--disable` | Disables Outlook and Teams communication |
| `-e` | `--enable` | Enables Outlook and Teams communication |
| `-h` | `--help` | Displays help information and available options |

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

### Show Help
```sh
ghost -h
```

## 🛠 Requirements

- PowerShell **7+**
- ExchangeOnlineManagement Module *(Auto-installed if missing)*
- MicrosoftTeams Module *(Auto-installed if missing)*
- Homebrew (for automatic dependency installation on macOS)

## 🔄 Automatic Module Installation
Ghost ensures that all required PowerShell modules are installed before execution.

### **How It Works:**
1. **Ghost checks for required modules** (`ExchangeOnlineManagement`, `MicrosoftTeams`) at runtime.
2. If a module is missing, it prompts the user for permission to install it.
3. If the user agrees, Ghost **installs** the missing module and proceeds with execution.

This ensures that administrators can run the tool seamlessly without worrying about missing dependencies.

## ⚠️ Parameter Validation
- If `-c` (connect) is used, **`-u <email>` must be provided**.
- If **no parameters** are provided, Ghost automatically displays help.

## 📦 Installation

### **Manual Installation**
```sh
git clone https://github.com/rkmnt/ghost.git
cd ghost
./install.sh
```

### **Run Ghost**
```sh
ghost -h
```

## 🔧 Uninstall Ghost
To completely remove Ghost from your system:
```sh
rm -rf ~/.local/share/ghost
rm ~/.local/bin/ghost
```

---

### **💡 Notes**
- Ghost **does not store credentials**, it relies on **Microsoft Secure Authentication**.
- Use **PowerShell Core (pwsh)** for best compatibility.
- If you encounter issues, try running:
  ```sh
  pwsh -ExecutionPolicy Unrestricted -File ghost.ps1
  ```

---
### **📬 Support & Issues**
If you encounter any problems or want to suggest improvements, feel free to open an **issue** on GitHub!
