param([switch]$NoBrowser, [ValidateSet('Default','Chrome','Edge','Firefox')][string]$Browser = 'Default')
$ErrorActionPreference = 'Stop'
$projectRoot = $PSScriptRoot
$localUrl = 'http://localhost:4175'
function Open-MedTechBrowser {
    if ($NoBrowser) { return }
    if ($Browser -eq 'Default') { Start-Process $localUrl; return }
    $browserExe = @{Chrome='chrome.exe'; Edge='msedge.exe'; Firefox='firefox.exe'}[$Browser]
    $relativePath = @{Chrome='Google\Chrome\Application\chrome.exe'; Edge='Microsoft\Edge\Application\msedge.exe'; Firefox='Mozilla Firefox\firefox.exe'}[$Browser]
    $candidates = @()
    foreach ($registryRoot in @('HKCU:','HKLM:')) {
        try { $candidates += (Get-Item -LiteralPath "$registryRoot\Software\Microsoft\Windows\CurrentVersion\App Paths\$browserExe" -ErrorAction Stop).GetValue('') } catch {}
    }
    foreach ($installRoot in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LOCALAPPDATA)) {
        if ($installRoot) { $candidates += Join-Path $installRoot $relativePath }
    }
    $browserPath = $candidates | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) } | Select-Object -First 1
    if ($browserPath) { Start-Process -FilePath $browserPath -ArgumentList $localUrl; return }
    Write-Host "$Browser nije pronadjen. Otvaram podrazumevani pregledac."
    Start-Process $localUrl
}
function Test-MedTech {
    try {
        $status = Invoke-RestMethod -Uri 'http://127.0.0.1:4175/api/health' -TimeoutSec 2
        return ($status.ok -eq $true -and $status.app -eq 'balkan-medtech')
    } catch { return $false }
}
if (Test-MedTech) { Open-MedTechBrowser; exit 0 }
$nodeCommand = Get-Command node.exe -ErrorAction SilentlyContinue
$bundledNode = Join-Path $projectRoot 'runtime\node.exe'
$nodePath = if (Test-Path -LiteralPath $bundledNode) { $bundledNode } elseif ($nodeCommand) { $nodeCommand.Source } else { $null }
if (-not $nodePath) {
    $runtimeRoot = Join-Path $env:ProgramFiles 'WindowsApps'
    $nodePath = Get-ChildItem -LiteralPath $runtimeRoot -Directory -Filter 'OpenAI.CodexPrimaryRuntime*' -ErrorAction SilentlyContinue |
        Sort-Object Name -Descending | ForEach-Object { Join-Path $_.FullName 'dependencies\node\bin\node.exe' } |
        Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
}
if (-not $nodePath) { throw 'Potreban je Node.js 24 ili noviji. Instalirajte ga i ponovo pokrenite POKRENI.cmd.' }
$nodeVersion = & $nodePath --version
if ([int]($nodeVersion.TrimStart('v').Split('.')[0]) -lt 24) { throw 'Potreban je Node.js 24 ili noviji.' }
$dataRoot = Join-Path $projectRoot 'data'
New-Item -ItemType Directory -Path $dataRoot -Force | Out-Null
$serverScript = Join-Path $projectRoot 'server.cjs'
$priorPort = $env:PORT
try {
    $env:PORT = '4175'
    $serverProcess = Start-Process -FilePath $nodePath -ArgumentList @('"' + $serverScript + '"') -WorkingDirectory $projectRoot -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $dataRoot 'server.log') -RedirectStandardError (Join-Path $dataRoot 'server-error.log')
} finally { $env:PORT = $priorPort }
Set-Content -LiteralPath (Join-Path $dataRoot 'server.pid') -Value $serverProcess.Id
for ($attempt = 0; $attempt -lt 30; $attempt++) {
    if (Test-MedTech) { Open-MedTechBrowser; Write-Host "Balkan MedTech je pokrenut: $localUrl"; exit 0 }
    if ($serverProcess.HasExited) { break }
    Start-Sleep -Milliseconds 500
}
throw 'Server nije pokrenut. Pogledajte data\server-error.log. Ako je port 4175 zauzet, zatvorite aplikaciju koja ga koristi.'
