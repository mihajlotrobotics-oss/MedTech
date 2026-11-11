$ErrorActionPreference = 'Stop'
$pidPath = Join-Path $PSScriptRoot 'data\server.pid'
if (-not (Test-Path -LiteralPath $pidPath)) { Write-Host 'Nema zabelezenog lokalnog servera.'; exit 0 }
$serverProcessId = [int](Get-Content -LiteralPath $pidPath -Raw)
$serverProcess = Get-CimInstance Win32_Process -Filter "ProcessId = $serverProcessId"
$expectedScript = Join-Path $PSScriptRoot 'server.cjs'
if ($serverProcess -and $serverProcess.Name -eq 'node.exe' -and $serverProcess.CommandLine.Contains('"' + $expectedScript + '"')) {
    Stop-Process -Id $serverProcessId
    Write-Host 'Lokalni server je zaustavljen. Rezervacije su sacuvane.'
} elseif ($serverProcess) {
    throw 'Proces ne odgovara ovom serveru. Nije zaustavljen.'
}
Remove-Item -LiteralPath $pidPath -ErrorAction SilentlyContinue
