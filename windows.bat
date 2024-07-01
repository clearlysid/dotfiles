@echo off

:: Install Apps 

winget install "Microsoft.VisualStudioCode"
winget install "GitHub.GitHubDesktop"
winget install "Google.Chrome"
winget install "Microsoft.PowerToys"
winget install "Figma.Figma"

:: Install Rust
winget install "Microsoft.VisualStudio.2022.Community" --override "--add Microsoft.VisualStudio.Workload.NativeDesktop"
winget install "Rustlang.Rustup"


:: Install Node
winget install "OpenJS.NodeJS"

:: Install Bun
winget install "Oven-sh.Bun"
