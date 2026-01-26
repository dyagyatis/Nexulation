<#
.SYNOPSIS
    Центральный хаб установки драйверов.
    - NVIDIA: Вызывает внешний скрипт Install-CleanNvidia.ps1 (Repack + Mod Config)
    - AMD/INTEL: Ставит стандартные драйверы через Winget
#>

$ErrorActionPreference = "SilentlyContinue"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   AUTO-DETECTING GPU HARDWARE ID...      " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Получаем список видеоадаптеров
$gpuCards = Get-CimInstance Win32_VideoController
$installed = $false

foreach ($card in $gpuCards) {
    $id = $card.PNPDeviceID
    $name = $card.Name
    
    Write-Host "Found GPU: $name ($id)" -ForegroundColor Gray

    # =======================================================
    # 1. NVIDIA (Vendor ID: 10DE) -> ЗАПУСК ВНЕШНЕГО СКРИПТА
    # =======================================================
    if ($true) {   # <--- МЫ ЗАСТАВЛЯЕМ ЕГО ЗАЙТИ СЮДА
    Write-Host "SIMULATING NVIDIA GPU..." -ForegroundColor Magenta

        # Ищем скрипт Install-CleanNvidia.ps1 в ТОЙ ЖЕ папке, где лежит этот файл
        $cleanerScript = "$PSScriptRoot\Install-CleanNvidia.ps1"
        
        if (Test-Path $cleanerScript) {
            Write-Host "Exec: $cleanerScript" -ForegroundColor DarkGray
            
            # Запускаем скрипт очистки и ждем его завершения
            # Используем оператор '&', чтобы логи выводились в это же окно
            & $cleanerScript
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "NVIDIA Installation Component Finished." -ForegroundColor Green
            } else {
                Write-Error "NVIDIA Script failed with exit code $LASTEXITCODE"
            }
        } else {
            Write-Error "CRITICAL: Script 'Install-CleanNvidia.ps1' not found in $PSScriptRoot!"
        }
        
        $installed = $true
        break # Прерываем цикл (дискретка найдена, встройка не нужна)
    }

    # =======================================================
    # 2. AMD (Vendor ID: 1002) -> WINGET
    # =======================================================
    elseif ($id -match "VEN_1002") {
        Write-Host ">> AMD Detected. Installing Adrenalin Edition..." -ForegroundColor Red
        winget install --id AMD.Adrenalin.Edition -e --silent --accept-package-agreements --accept-source-agreements
        $installed = $true
        break
    }

    # =======================================================
    # 3. INTEL (Vendor ID: 8086) -> WINGET
    # =======================================================
    elseif ($id -match "VEN_8086" -and $name -notmatch "UHD|HD Graphics") {
        Write-Host ">> INTEL Detected. Installing Graphics Driver..." -ForegroundColor Blue
        winget install --id Intel.GraphicsDriver -e --silent --accept-package-agreements --accept-source-agreements
        $installed = $true
        break
    }
}

if (-not $installed) {
    Write-Warning "No dedicated GPU detected or Driver installation skipped."
    Write-Host "Standard Microsoft Basic Display Adapter will be used." -ForegroundColor Yellow
}

Write-Host "GPU Driver Check Completed." -ForegroundColor Cyan