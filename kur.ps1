# Muck mod paketini oyun klasorune kopyalar.
# Kullanim: kur.bat               -> Muck'i kendisi bulur
#           kur.bat "D:\...\Muck" -> klasoru elle verirsin
param([string]$OyunKlasoru)

$ErrorActionPreference = 'Stop'
$modKlasoru = Join-Path $PSScriptRoot 'mod'

function Test-Muck([string]$yol) {
    $yol -and (Test-Path -LiteralPath (Join-Path $yol 'Muck.exe'))
}

function Find-Muck {
    # Steam'in kurulu oldugu yerler (registry + varsayilanlar)
    $steamYollari = @()
    foreach ($anahtar in 'HKCU:\Software\Valve\Steam',
                         'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam',
                         'HKLM:\SOFTWARE\Valve\Steam') {
        $p = Get-ItemProperty $anahtar -ErrorAction SilentlyContinue
        if ($p.SteamPath)   { $steamYollari += $p.SteamPath }
        if ($p.InstallPath) { $steamYollari += $p.InstallPath }
    }
    $steamYollari += "${env:ProgramFiles(x86)}\Steam", "$env:ProgramFiles\Steam"

    # Her Steam'in kutuphane klasorleri (libraryfolders.vdf)
    $kutuphaneler = @()
    foreach ($s in $steamYollari) {
        $s = $s -replace '/', '\'
        $kutuphaneler += $s
        $vdf = Join-Path $s 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $vdf) {
            foreach ($m in Select-String -LiteralPath $vdf -Pattern '"path"\s+"(.+?)"') {
                $kutuphaneler += $m.Matches[0].Groups[1].Value -replace '\\\\', '\'
            }
        }
    }

    # Kafelerde sik gorulen klasorler, her surucude
    foreach ($d in Get-PSDrive -PSProvider FileSystem) {
        $kutuphaneler += "$($d.Root)SteamLibrary", "$($d.Root)Steam",
                         "$($d.Root)Games\Steam", "$($d.Root)Oyunlar\Steam"
    }

    foreach ($k in $kutuphaneler | Select-Object -Unique) {
        $aday = Join-Path $k 'steamapps\common\Muck'
        if (Test-Muck $aday) { return $aday }
    }
    return $null
}

if (-not (Test-Path -LiteralPath (Join-Path $modKlasoru 'BepInEx'))) {
    Write-Host "HATA: 'mod\BepInEx' klasoru yok. Zip'i tamamen cikardin mi?" -ForegroundColor Red
    exit 1
}

if (-not (Test-Muck $OyunKlasoru)) { $OyunKlasoru = Find-Muck }

while (-not (Test-Muck $OyunKlasoru)) {
    Write-Host "Muck klasoru bulunamadi." -ForegroundColor Yellow
    Write-Host "Steam > Muck > sag tik > Yonet > Yerel dosyalara goz at, acilan klasoru buraya surukle ve Enter'a bas."
    $OyunKlasoru = (Read-Host 'Klasor').Trim().Trim('"')
    if (-not $OyunKlasoru) { exit 1 }
}

Write-Host "Muck bulundu: $OyunKlasoru" -ForegroundColor Cyan
if (Get-Process Muck -ErrorAction SilentlyContinue) {
    Write-Host "Muck acik! Oyunu kapatip kur.bat'i tekrar calistir." -ForegroundColor Red
    exit 1
}
try {
    # Paketten cikarilan modlar oyunda kalmasin diye eski modlari sil
    $eskiModlar = Join-Path $OyunKlasoru 'BepInEx\plugins'
    if (Test-Path -LiteralPath $eskiModlar) { Remove-Item -LiteralPath $eskiModlar -Recurse -Force }
    Copy-Item -Path (Join-Path $modKlasoru '*') -Destination $OyunKlasoru -Recurse -Force
} catch {
    Write-Host "Kopyalanamadi: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "kur.bat'a sag tik > Yonetici olarak calistir dene."
    exit 1
}

Write-Host ""
Write-Host "KURULUM TAMAM! Steam'den Muck'i acabilirsin." -ForegroundColor Green
Write-Host "(Kafe bilgisayari yeniden baslarsa kur.bat'i tekrar calistir.)"
