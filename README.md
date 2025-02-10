# Ghost - Microsoft 365 Management Tool

![Ghost Banner](https://your-image-link.com/banner.png)  

**Ghost** is a PowerShell-based tool for managing **Microsoft 365 services**. It allows administrators to connect to **Exchange Online** and **Microsoft Teams**, as well as to temporarily enable or disable communication across the organization.

## 🚀 Features

- ✅ **Connect** to Exchange Online and Microsoft Teams
- 🚫 **Disable** email and chat communication organization-wide
- ✅ **Enable** email and chat communication when needed
- 📌 Simple CLI parameters for easy use

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
- ExchangeOnlineManagement Module
- MicrosoftTeams Module

## 📜 License
This project is licensed under the **MIT License**.

## 🤝 Contributing
Contributions are welcome! Feel free to open an issue or submit a pull request.

