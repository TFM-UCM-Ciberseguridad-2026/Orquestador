Clear-Host

Write-Host "[*] Buscando actualizaciones en Backend, Frontend y BBDD..." -ForegroundColor Yellow

git submodule update --remote

$cambios = git status --porcelain
if ([string]::IsNullOrWhiteSpace($cambios)) {
    Write-Host "[+] Todos los submódulos están al día. No hay nada que subir al Orquestador." -ForegroundColor Green
    exit 0
}

Write-Host "[*] Nuevos commits detectados. Preparando la integración..." -ForegroundColor Yellow

git add .

$FECHA = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "chore: actualización de submódulos ($FECHA)" | Out-Null

Write-Host "[*] Subiendo la nueva versión a GitHub..." -ForegroundColor Yellow

git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "[+] ¡Orquestador actualizado y subido con éxito! El equipo ya puede descargarlo." -ForegroundColor Green
} else {
    Write-Host "[-] Error: No se pudo subir a GitHub. Revisa tu conexión o permisos." -ForegroundColor Red
}
