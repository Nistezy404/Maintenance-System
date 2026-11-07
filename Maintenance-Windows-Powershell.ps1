#requires -Version 5.1
<#
Toolkit de Manutenção para Windows 10/11
Menu para Microsoft Defender, limpeza e manutenção do sistema.
Execute como Administrador para operações do sistema.
#>

$ErrorActionPreference = 'Continue'
$LogPath = Join-Path $env:LOCALAPPDATA 'ToolkitManutencao\toolkit.log'
$LogDir = Split-Path -Parent $LogPath
New-Item -ItemType Directory -Path $LogDir -Force | Out-Null

function Write-Log([string]$Message) {
    $line = "[{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
    Write-Host $line
    Add-Content -LiteralPath $LogPath -Value $line -Encoding UTF8
}
function Test-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    return ([Security.Principal.WindowsPrincipal]::new($id)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
function Confirm-Action([string]$Prompt) {
    $answer = Read-Host "$Prompt (s/N)"
    return $answer -match '^(s|sim)$'
}
function Require-Admin {
    if (-not (Test-Admin)) { Write-Log 'Esta ação exige PowerShell como Administrador.'; return $false }
    return $true
}
function Update-Defender {
    if (-not (Require-Admin)) { return }
    try { Update-MpSignature -ErrorAction Stop; Write-Log 'Assinaturas do Microsoft Defender atualizadas.' }
    catch { Write-Log "Falha ao atualizar o Defender: $($_.Exception.Message)" }
}
function Invoke-DefenderScan([ValidateSet('QuickScan','FullScan')][string]$ScanType) {
    if (-not (Require-Admin)) { return }
    $label = if ($ScanType -eq 'QuickScan') { 'rápida' } else { 'completa' }
    if (-not (Confirm-Action "Iniciar verificação $label do Microsoft Defender? Ela pode levar algum tempo")) { return }
    try { Start-MpScan -ScanType $ScanType -ErrorAction Stop; Write-Log "Verificação $label iniciada/concluída pelo Microsoft Defender." }
    catch { Write-Log "Falha na verificação: $($_.Exception.Message)" }
}
function Show-DefenderStatus {
    try {
        $status = Get-MpComputerStatus -ErrorAction Stop
        $status | Select-Object AntivirusEnabled,RealTimeProtectionEnabled,AntivirusSignatureLastUpdated,QuickScanEndTime,FullScanEndTime | Format-List | Out-String | ForEach-Object { Write-Host $_ }
        Write-Log 'Status do Microsoft Defender consultado.'
    } catch { Write-Log "Não foi possível consultar o Defender: $($_.Exception.Message)" }
}
function Clean-Temp {
    if (-not (Confirm-Action 'Excluir arquivos temporários antigos (mais de 7 dias) do usuário e do Windows?')) { return }
    $cutoff = (Get-Date).AddDays(-7)
    $paths = @($env:TEMP, (Join-Path $env:WINDIR 'Temp')) | Select-Object -Unique
    foreach ($path in $paths) {
        if (-not (Test-Path -LiteralPath $path)) { continue }
        Get-ChildItem -LiteralPath $path -Force -File -Recurse -ErrorAction SilentlyContinue |
            Where-Object { $_.LastWriteTime -lt $cutoff } |
            Remove-Item -Force -ErrorAction SilentlyContinue
        Get-ChildItem -LiteralPath $path -Force -Directory -Recurse -ErrorAction SilentlyContinue |
            Sort-Object FullName -Descending | Where-Object { $_.LastWriteTime -lt $cutoff } |
            Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    }
    Write-Log 'Limpeza de temporários antigos concluída. Arquivos em uso foram ignorados.'
}
function Invoke-SystemRepair {
    if (-not (Require-Admin)) { return }
    if (-not (Confirm-Action 'Executar DISM RestoreHealth e SFC /scannow?')) { return }
    Write-Log 'Executando DISM RestoreHealth...'
    & DISM.exe /Online /Cleanup-Image /RestoreHealth
    Write-Log "DISM finalizado (código $LASTEXITCODE). Executando SFC..."
    & sfc.exe /scannow
    Write-Log "SFC finalizado (código $LASTEXITCODE)."
}
function Show-Diagnostics {
    Write-Log 'Diagnóstico do sistema'
    Get-ComputerInfo -Property WindowsProductName,WindowsVersion,OsBuildNumber,CsName | Format-List
    Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{N='Livre (GB)';E={[math]::Round($_.Free/1GB,2)}}, @{N='Usado (GB)';E={[math]::Round($_.Used/1GB,2)}} | Format-Table -AutoSize
    Get-Service | Where-Object Status -eq 'Stopped' | Select-Object -First 15 Name,DisplayName,Status | Format-Table -AutoSize
    try { Get-MpComputerStatus | Select-Object AntivirusEnabled,RealTimeProtectionEnabled,AntivirusSignatureLastUpdated | Format-List } catch { Write-Host 'Status do Defender indisponível.' }
    Write-Log 'Diagnóstico concluído.'
}

while ($true) {
    Write-Host "`n========= TOOLKIT DE MANUTENÇÃO WINDOWS =========" -ForegroundColor Cyan
    Write-Host '1) Atualizar assinaturas do Microsoft Defender'
    Write-Host '2) Verificação rápida do Defender'
    Write-Host '3) Verificação completa do Defender'
    Write-Host '4) Limpar temporários antigos'
    Write-Host '5) Reparar imagem e arquivos do Windows (DISM + SFC)'
    Write-Host '6) Diagnóstico do sistema'
    Write-Host '0) Sair'
    $choice = Read-Host 'Escolha uma opção'
    switch ($choice) {
        '1' { Update-Defender }
        '2' { Invoke-DefenderScan QuickScan }
        '3' { Invoke-DefenderScan FullScan }
        '4' { Clean-Temp }
        '5' { Invoke-SystemRepair }
        '6' { Show-Diagnostics }
        '0' { Write-Host 'Saindo.'; return }
        default { Write-Host 'Opção inválida.' -ForegroundColor Yellow }
    }
}
