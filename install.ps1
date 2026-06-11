# claude-config-team 설치 스크립트 (Windows PowerShell)
# skills/ -> ~/.claude/skills/, agents/ -> ~/.claude/agents/ 복사

$ErrorActionPreference = 'Stop'

$repoRoot = $PSScriptRoot
$claudeDir = Join-Path $HOME '.claude'
$skillsDir = Join-Path $claudeDir 'skills'
$agentsDir = Join-Path $claudeDir 'agents'

New-Item -ItemType Directory -Force $skillsDir, $agentsDir | Out-Null

Get-ChildItem (Join-Path $repoRoot 'skills') -Directory | ForEach-Object {
    $dest = Join-Path $skillsDir $_.Name
    if (Test-Path $dest) { Write-Host "덮어쓰기: $($_.Name)" -ForegroundColor Yellow }
    Copy-Item $_.FullName $skillsDir -Recurse -Force
    Write-Host "스킬 설치: $($_.Name)" -ForegroundColor Green
}

Get-ChildItem (Join-Path $repoRoot 'agents') -File -Filter *.md | ForEach-Object {
    Copy-Item $_.FullName $agentsDir -Force
    Write-Host "에이전트 설치: $($_.BaseName)" -ForegroundColor Green
}

Write-Host ""
Write-Host "설치 완료. ~/.claude/CLAUDE.md에 슬래시 커맨드 등록 스니펫을 추가하세요 (README 참고)." -ForegroundColor Cyan
