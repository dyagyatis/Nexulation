<#
.SYNOPSIS
    NVIDIA ULTIMATE CLEANER
    1. Скачивает драйвер.
    2. Скачивает твой mod-setup.cfg.
    3. Переносит версию драйвера в твой конфиг (Version Injection).
    4. Удаляет весь мусор (Telemetry, GFE, PhysX), оставляя структуру NVCleanstall.
    5. Тихая установка.
#>

$ErrorActionPreference = "Stop"

# ==========================================
# 1. НАСТРОЙКИ И ПУТИ
# ==========================================
$SevenZip = "$PSScriptRoot\7zr.exe"
$WorkDir = "$env:TEMP\NvidiaClean"
# Ссылка на твой МОДИФИЦИРОВАННЫЙ конфиг (с NVIDIA App текстами)
$ModConfigUrl = "https://raw.githubusercontent.com/dyagyatis/nv/refs/heads/main/mod-setup.cfg"

# Проверка архиватора (если нет рядом - качаем)
if (-not (Test-Path $SevenZip)) {
    Write-Warning "7zr.exe not found in Executables! Downloading fallback..."
    $SevenZip = "$WorkDir\7zr.exe"
    if (-not (Test-Path $WorkDir)) { New-Item -ItemType Directory -Path $WorkDir | Out-Null }
    Invoke-WebRequest "https://www.7-zip.org/a/7zr.exe" -OutFile $SevenZip
}

# Очистка временной папки
if (Test-Path $WorkDir) { Remove-Item $WorkDir -Recurse -Force }
New-Item -ItemType Directory -Path $WorkDir | Out-Null

# ==========================================
# 2. СКАЧИВАНИЕ ОФИЦИАЛЬНОГО ДРАЙВЕРА
# ==========================================
Write-Host "Downloading Official NVIDIA Driver (Winget)..." -ForegroundColor Cyan
$wingetCmd = "winget download --id Nvidia.Display.Driver -d $WorkDir -e --accept-source-agreements --accept-package-agreements"
Invoke-Expression $wingetCmd

$DriverFile = Get-ChildItem "$WorkDir\*.exe" | Where-Object { $_.Name -ne "7zr.exe" } | Select-Object -First 1 -ExpandProperty FullName
if (-not $DriverFile) { Write-Error "Driver download failed!" }

# ==========================================
# 3. РАСПАКОВКА
# ==========================================
Write-Host "Unpacking..." -ForegroundColor Cyan
$ExtractDir = "$WorkDir\Extracted"
Start-Process $SevenZip -ArgumentList "x `"$DriverFile`" -o`"$ExtractDir`" -y" -Wait

# ==========================================
# 4. ОЧИСТКА ФАЙЛОВ (WhiteList - Оставляем только базу)
# ==========================================
Write-Host "Debloating Files (Keeping Driver + NVI2)..." -ForegroundColor Yellow

# СПИСОК ТОГО, ЧТО ОСТАВЛЯЕМ (Точная копия NVCleanstall Min)
$KeepFolders = @("Display.Driver", "NVI2")
$KeepFiles   = @("setup.exe", "setup.cfg", "ListDevices.txt", "EULA.txt")

# Удаляем лишние папки
Get-ChildItem -Path $ExtractDir -Directory | ForEach-Object {
    if ($_.Name -notin $KeepFolders) {
        Remove-Item $_.FullName -Recurse -Force
    }
}
# Удаляем лишние файлы
Get-ChildItem -Path $ExtractDir -File | ForEach-Object {
    if ($_.Name -notin $KeepFiles) {
        Remove-Item $_.FullName -Force
    }
}

# ==========================================
# 5. МАГИЯ КОНФИГА (Подмена + Инъекция Версии)
# ==========================================
Write-Host "Performing Setup.cfg Surgery..." -ForegroundColor Yellow
$CfgPath = "$ExtractDir\setup.cfg"

# ШАГ А: Читаем версию из РОДНОГО файла (пока он еще существует)
[xml]$origXml = Get-Content $CfgPath
$RealVersion = $origXml.setup.version
Write-Host " >> Detected Real Driver Version: $RealVersion" -ForegroundColor Cyan

# ШАГ Б: Скачиваем твой mod-setup.cfg и затираем им родной файл
Write-Host " >> Downloading custom config from GitHub..." -ForegroundColor Cyan
try {
    Invoke-WebRequest $ModConfigUrl -OutFile $CfgPath -ErrorAction Stop
} catch {
    Write-Warning "Failed to download GitHub config! Reverting to logic with original file."
    # Если инета нет или github лежит - работаем с тем что есть, версия уже в переменной
}

# ШАГ В: Вписываем реальную версию в файл (Инъекция)
[xml]$newXml = Get-Content $CfgPath
$newXml.setup.version = $RealVersion
Write-Host " >> Injected version $RealVersion into config." -ForegroundColor Green

# ШАГ Г: Чистим XML от удаленных компонентов (Telemetry, PhysX, GFE/NvApp)
$nodesToRemove = @()
foreach ($package in $newXml.setup.packages.package) {
    if ($package.name -notin $KeepFolders) {
        $nodesToRemove += $package
    }
}

foreach ($node in $nodesToRemove) {
    $newXml.setup.packages.RemoveChild($node) | Out-Null
}

$newXml.Save($CfgPath)

# ==========================================
# 6. УСТАНОВКА
# ==========================================
Write-Host "Installing Clean Driver..." -ForegroundColor Green
$SetupExe = "$ExtractDir\setup.exe"
# -s = Silent, -n = Clean Install
$proc = Start-Process $SetupExe -ArgumentList "-s -n" -Wait -PassThru

if ($proc.ExitCode -eq 0) {
    Write-Host "SUCCESS: Driver Installed!" -ForegroundColor Green
} else {
    Write-Error "Installation failed with exit code $($proc.ExitCode)"
}

# ==========================================
# 7. УБОРКА
# ==========================================
if (Test-Path $WorkDir) { Remove-Item $WorkDir -Recurse -Force }
Write-Host "Done." -ForegroundColor Green