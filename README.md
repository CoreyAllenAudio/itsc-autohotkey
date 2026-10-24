# ITSC AutoHotKey

A starter toolkit of AutoHotkey v2 scripts for IT support work, at the office or at home.

> **Status: work in progress.** Most libraries below are planned and not yet in the repo.
> Current research focus: customizable hotkeys and mouse-button interoperability for common IT workflows.

## Overview

Repetitive IT tasks — running network diagnostics, opening the same set of admin tools, pasting
standard ticket notes — are good candidates for hotkeys. This repo is a starting template: a small
entry-point script plus a `lib/` folder of focused, reusable libraries you can pick from and extend.

Everything here is kept generic. There are no hardcoded machine paths, hostnames, or credentials,
so you can clone it and adapt it to your own environment.

## Tech Stack

- [AutoHotkey v2.0](https://www.autohotkey.com/) runtime (Windows only)
- AHK scripting, organized as libraries under `lib/`
- Optional: [Ahk2Exe](https://www.autohotkey.com/docs/v2/Scripts.htm#ahk2exe) to compile scripts into standalone `.exe` files

## Getting Started

1. Install [AutoHotkey v2](https://www.autohotkey.com/).
2. Clone the repo:
   ```powershell
   git clone https://github.com/CoreyAllenAudio/<repo-name>.git
   ```
3. Double-click `Main.ahk` (or right-click → **Run script**). An **H** icon appears in the system
   tray while the script is running.
4. Press `Ctrl+Alt+1` to confirm everything works.

To reload after editing a file, right-click the tray icon → **Reload Script**. To stop, choose **Exit**.

### Editing in VSCode (optional)

Open the folder in VSCode and accept the prompt to install the recommended extension,
[AHK++](https://marketplace.visualstudio.com/items?itemName=mark-wiemer.vscode-autohotkey-plus-plus).
It provides syntax highlighting, IntelliSense, and run/debug commands for AHK v2.

## Project Structure

```
.
├── Main.ahk          # Entry point: includes libraries and defines hotkeys
├── lib/              # Reusable libraries, loaded with #Include <Name>
│   └── Greetings.ahk
└── .vscode/
    └── extensions.json   # Recommended VSCode extensions
```

AutoHotkey automatically searches the `lib/` folder next to the script, so `#Include <Greetings>`
loads `lib/Greetings.ahk` without a path.

## Libraries

| Library | Purpose | Status |
|---|---|---|
| `Greetings` | Minimal example library; verifies your setup | Available |
| `NetworkTools` | Hotkeys for common networking commands (ping, ipconfig, etc.) | Planned |
| `OpenTools` | Launch your own set of IT applications | Planned |
| `ClipboardTools` | Copy and paste automation | Planned |
| `InDevelopment` | Experimental functions — **use at your own risk** | Planned |

## Hotkeys

| Hotkey | Action | Library |
|---|---|---|
| `Ctrl+Alt+1` | Show a test greeting | `Greetings` |

## Conventions

- Start every `.ahk` file with `#Requires AutoHotkey v2.0`.
- Keep each library focused on one area. Add it to `Main.ahk` with `#Include <Name>`.
- **Never commit machine-specific or sensitive data**: local paths, hostnames, usernames,
  credentials, or anything tied to a specific employer's environment.
- Compiled `.exe` files are ignored by git; build them locally.

## Disclaimer

These scripts send keystrokes and run commands on your machine. Read a script before running it,
test outside production first, and follow your organization's software and automation policies.

## License

[MIT](LICENSE)
