# 🛠️ Maintenance System

<div align="center">

### Windows & Linux Maintenance and Diagnostics Toolkit

![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Debian%2013-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-121011?style=for-the-badge&logo=gnubash&logoColor=white)

**Automation • System Administration • Troubleshooting • Security • Diagnostics**

[Repository](https://github.com/Nistezy404/Maintenance-System) | [Report an Issue](https://github.com/Nistezy404/Maintenance-System/issues)

</div>

---

## 📖 Overview

**Maintenance System** is a collection of interactive scripts designed to automate operating system maintenance, troubleshooting, security checks and system diagnostics on Windows and Debian-based Linux environments.

The project aims to reduce repetitive administrative tasks, simplify preventive maintenance and support IT infrastructure operations using PowerShell, Batch and Bash.

## 🚀 Features

### 🪟 Windows Maintenance

| Feature | Description |
|---|---|
| 🛡️ Defender Updates | Update Microsoft Defender security intelligence. |
| 🔍 Antivirus Scanning | Perform quick and full scans. |
| 🧹 Temporary File Cleanup | Remove temporary files older than seven days. |
| 🔧 System Repair | Execute DISM RestoreHealth and SFC /scannow. |
| 📊 System Diagnostics | Check OS information, disk usage, stopped services and Defender status. |
| 📋 Logging | Maintain persistent activity records. |
| ⚙️ Interactive Menu | Execute operations from a terminal menu. |

### 🐧 Linux Maintenance

Target environment: **Debian 13 (Trixie)**.

| Feature | Description |
|---|---|
| 📦 Package Management | Update packages and repair package configuration. |
| 🧹 System Cleanup | Remove unused packages, caches and old temporary files. |
| 📜 Journal Maintenance | Apply systemd journal retention limits. |
| 📊 Diagnostics | Inspect disk, memory, uptime and failed services. |
| 🔐 Integrity Checks | Check package integrity using debsums when installed. |
| 🕒 Shell History | Optional shell-history cleanup. |
| 🔄 Full Maintenance | Execute update and cleanup operations in sequence. |
| 📝 Logging | Record terminal output in a log file. |

## 🧰 Technologies

**Windows:** PowerShell 5.1+, Batch, Microsoft Defender, DISM and SFC.

**Linux:** Bash, APT, dpkg, systemd, journalctl and debsums.

## 📂 Project Structure

```text
Maintenance-System/
├── Maintenance-System-CMD.cmd
├── Maintenance-Windows-Powershell.ps1
├── manutenção_limpeza.sh
└── README.md
```

## 📥 Installation

Clone the repository:

```bash
git clone https://github.com/Nistezy404/Maintenance-System.git
cd Maintenance-System
```

## 🪟 Windows Usage

**Requirements:** Windows 10/11, PowerShell 5.1+ and Microsoft Defender for antivirus functions.

Open PowerShell in the project directory and execute:

```powershell
.\Maintenance-Windows-Powershell.ps1
```

Some operations require Administrator privileges.

**CMD launcher:** `Maintenance-System-CMD.cmd` is also provided. Before using it, correct its reference from `Toolkit-Manutencao-Windows.ps1` to `Maintenance-Windows-Powershell.ps1`.

### Interactive Menu

```text
========= TOOLKIT DE MANUTENÇÃO WINDOWS =========

1) Atualizar assinaturas do Microsoft Defender
2) Verificação rápida do Defender
3) Verificação completa do Defender
4) Limpar temporários antigos
5) Reparar imagem e arquivos (DISM + SFC)
6) Diagnóstico do sistema
0) Sair
```

**Log location:**

```text
%LOCALAPPDATA%\ToolkitManutencao\toolkit.log
```

## 🐧 Linux Usage

**Requirements:** Debian 13, Bash, APT, systemd and root privileges. `debsums` is optional.

Execute:

```bash
sudo bash ./manutenção_limpeza.sh
```

### Interactive Menu

```text
========= TOOLKIT DE MANUTENÇÃO =========

1) Atualizar sistema
2) Limpar sistema
3) Limpar logs
4) Diagnóstico do sistema
5) Verificar integridade
6) Limpar histórico
7) Manutenção completa
0) Sair
```

**Log location:**

```text
/var/log/toolkit_manutencao.log
```

## 🔒 Security Considerations

These scripts execute administrative operations that may modify system configuration or delete files.

- Review the source code before execution.
- Back up important data before maintenance.
- Test cleanup routines in a controlled environment.
- Use elevated privileges only when necessary.
- Review retention and audit requirements before deleting logs or shell history.
- Avoid running full maintenance on critical systems without reviewing each operation.

**Important:** The Linux cleanup routine removes cached files, and its full maintenance operation includes shell-history cleanup. The Windows cleanup may recursively remove old temporary directories. Review these operations before using them in production.

## 💼 Use Cases

- IT Support N1/N2
- Windows and Linux Administration
- Endpoint Maintenance
- Infrastructure Troubleshooting
- Security Operations Support
- Homelabs and Technical Training
- Shell Scripting and Automation

## 🗺️ Future Improvements

- [ ] Add dry-run support for cleanup routines.
- [ ] Add confirmations before destructive Linux operations.
- [ ] Improve error handling and exit-code validation.
- [ ] Introduce configurable cleanup policies.
- [ ] Generate structured diagnostic reports.
- [ ] Add automated tests and static analysis.
- [ ] Integrate ShellCheck and PSScriptAnalyzer.

## 👨‍💻 Author

**Mauricio Robert**

Cybersecurity Student | IT Infrastructure | Security Research & Development

[GitHub](https://github.com/Nistezy404) | [LinkedIn](https://www.linkedin.com/in/mauricio-robert-9b79b3309/)

---

<div align="center">

**Built for learning, automation and practical system administration.**

⭐ If this project is useful, consider starring the repository.

</div>
