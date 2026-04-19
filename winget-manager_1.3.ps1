# NÃO mexer na codificação nem no chcp aqui.
# Deixa a consola usar o que o Windows tiver por omissão.
$OutputEncoding = [System.Text.UTF8Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::UTF8

Write-Host "A verificar actualizações..." -ForegroundColor Cyan
# Correr o winget e apanhar o output
$upRaw = winget upgrade --include-unknown
$upText = $upRaw | Out-String
# Separar por linhas
$linhas = $upText -split "`r?`n"
# Limpar linhas com só "-" ou "\" ou vazias
$linhasLimpas = $linhas | Where-Object {
    $t = $_.Trim()
    -not [string]::IsNullOrWhiteSpace($t) -and $t -ne "-" -and $t -ne "\"
}
Write-Host ""
Write-Host "===== PROGRAMAS COM ACTUALIZAÇÕES =====" -ForegroundColor Yellow
$semUpdates =
    ($upText -match "Nenhum pacote instalado foi encontrado") -or
    ($linhasLimpas.Count -eq 0)
if ($semUpdates) {
    # Se não há nada para actualizar (ou está tudo pinned)
    Write-Host "Nenhum pacote instalado foi encontrado." -ForegroundColor DarkGray
}
else {
    # Mostrar apenas as linhas limpas
    $linhasLimpas | ForEach-Object { Write-Host $_ }
}
Write-Host "========================================="
if (-not $semUpdates) {
    # Só mostra o menu se houver coisas para actualizar
    Write-Host ""
    Write-Host "Escolhe uma opção:" -ForegroundColor Cyan
    Write-Host "1 - Actualizar TODOS"
    Write-Host "2 - Actualizar um a um"
    Write-Host "3 - Pôr em pin um a um"
    Write-Host "======================="
    $choice = Read-Host "Opção"
    if ($choice -eq "1") {
        Write-Host "`nA actualizar tudo..." -ForegroundColor Green
        winget upgrade --include-unknown -h
        Write-Host "`nActualização em massa concluída." -ForegroundColor Green
    }
    elseif ($choice -eq "2") {
        Write-Host "`nModo manual seleccionado.`n" -ForegroundColor Cyan
        # Voltar a pedir lista ao winget
        $listLines = winget upgrade --include-unknown
        # Detectar dinamicamente o índice do cabeçalho
        $headerIndex = -1
        for ($i = 0; $i -lt $listLines.Count; $i++) {
            if ($listLines[$i] -match "^Nome\s+ID\s+Versão\s+Disponível\s+Origem") {
                $headerIndex = $i
                break
            }
        }
        if ($headerIndex -ge 0) {
            $headerLine = $listLines[$headerIndex]
            # Obter posições das colunas
            $idStart = $headerLine.IndexOf("ID")
            $versionStart = $headerLine.IndexOf("Versão")
            $availableStart = $headerLine.IndexOf("Disponível")
            $sourceStart = $headerLine.IndexOf("Origem")
            $listLines = $listLines | Select-Object -Skip ($headerIndex + 1)
        } else {
            # Se não encontrar cabeçalho, assume sem skip (fallback)
            $idStart = $null
            $versionStart = $null
            $availableStart = $null
            $sourceStart = $null
        }
        # Agora percorrer as linhas
        foreach ($line in $listLines) {
            $text = $line.ToString().Trim()
            if ([string]::IsNullOrWhiteSpace($text)) { continue }
            if ($text -match "^-{5,}$") { continue }
            # Ignorar linhas de resumo e mensagens
            if ($text -match "atualiza" -or
                $text -match "upgrades" -or
                $text -match "Nenhum pacote instalado foi encontrado" -or
                $text -match "pacotes têm pinos" -or
                $text -match "packages have pins") { continue }
            # Extrair usando posições se disponíveis, senão fallback para split
            if ($idStart -and $versionStart -and $line.Length -ge $sourceStart) {
                $name = $line.Substring(0, $idStart).Trim()
                $id = $line.Substring($idStart, $versionStart - $idStart).Trim()
                # Ignorar se name ou id vazios
                if ([string]::IsNullOrWhiteSpace($name) -or [string]::IsNullOrWhiteSpace($id)) { continue }
            } else {
                # Fallback para split se posições não definidas
                $parts = $text -split "\s{2,}"
                if ($parts.Count -lt 2) { continue }
                $name = $parts[0]
                $id = $parts[1]
            }
            Write-Host "`nActualizar: $name ?" -ForegroundColor Yellow
            $ans = Read-Host "(s/n)"
            if ($ans -eq "s") {
                Write-Host "A actualizar $name..." -ForegroundColor Green
                winget upgrade --id $id --include-unknown -h
                Write-Host "Concluído.`n" -ForegroundColor Green
            }
            else {
                Write-Host "Ignorado.`n" -ForegroundColor DarkGray
            }
        }
        Write-Host "`nTodas as entradas processadas." -ForegroundColor Cyan
    }
    elseif ($choice -eq "3") {
        Write-Host "`nModo de pinning manual seleccionado.`n" -ForegroundColor Cyan
        # Voltar a pedir lista ao winget
        $listLines = winget upgrade --include-unknown
        # Detectar dinamicamente o índice do cabeçalho
        $headerIndex = -1
        for ($i = 0; $i -lt $listLines.Count; $i++) {
            if ($listLines[$i] -match "^Nome\s+ID\s+Versão\s+Disponível\s+Origem") {
                $headerIndex = $i
                break
            }
        }
        if ($headerIndex -ge 0) {
            $headerLine = $listLines[$headerIndex]
            # Obter posições das colunas
            $idStart = $headerLine.IndexOf("ID")
            $versionStart = $headerLine.IndexOf("Versão")
            $availableStart = $headerLine.IndexOf("Disponível")
            $sourceStart = $headerLine.IndexOf("Origem")
            $listLines = $listLines | Select-Object -Skip ($headerIndex + 1)
        } else {
            # Se não encontrar cabeçalho, assume sem skip (fallback)
            $idStart = $null
            $versionStart = $null
            $availableStart = $null
            $sourceStart = $null
        }
        # Agora percorrer as linhas
        foreach ($line in $listLines) {
            $text = $line.ToString().Trim()
            if ([string]::IsNullOrWhiteSpace($text)) { continue }
            if ($text -match "^-{5,}$") { continue }
            # Ignorar linhas de resumo e mensagens
            if ($text -match "atualiza" -or
                $text -match "upgrades" -or
                $text -match "Nenhum pacote instalado foi encontrado" -or
                $text -match "pacotes têm pinos" -or
                $text -match "packages have pins") { continue }
            # Extrair usando posições se disponíveis, senão fallback para split
            if ($idStart -and $versionStart -and $line.Length -ge $sourceStart) {
                $name = $line.Substring(0, $idStart).Trim()
                $id = $line.Substring($idStart, $versionStart - $idStart).Trim()
                # Ignorar se name ou id vazios
                if ([string]::IsNullOrWhiteSpace($name) -or [string]::IsNullOrWhiteSpace($id)) { continue }
            } else {
                # Fallback para split se posições não definidas
                $parts = $text -split "\s{2,}"
                if ($parts.Count -lt 2) { continue }
                $name = $parts[0]
                $id = $parts[1]
            }
            Write-Host "`nPôr em pin: $name ?" -ForegroundColor Yellow
            $ans = Read-Host "(s/n)"
            if ($ans -eq "s") {
                Write-Host "A pôr em pin $name..." -ForegroundColor Green
                winget pin add --id $id
                Write-Host "Concluído.`n" -ForegroundColor Green
            }
            else {
                Write-Host "Ignorado.`n" -ForegroundColor DarkGray
            }
        }
        Write-Host "`nTodas as entradas processadas." -ForegroundColor Cyan
    }
    else {
        Write-Host "`nOpção inválida, não foram feitas actualizações." -ForegroundColor Red
    }
}
# Parte dos PINNED (mostra sempre, independentemente de haver updates ou não)
Write-Host "`nQueres ver a lista de pacotes PINNED (com pino)?" -ForegroundColor Cyan
$verPinned = Read-Host "(s/n)"
if ($verPinned -eq "s") {
    Write-Host "`n===== PACOTES PINNED =====" -ForegroundColor Yellow
    winget pin list
    Write-Host "==========================`n"

    # Pergunta para actualizar um a um
    Write-Host "Queres actualizar um a um os pacotes PINNED?" -ForegroundColor Cyan
    Write-Host "(nota: só funciona se o winget/pacote suportar --include-pinned)" -ForegroundColor DarkGray
    $updPinnedManual = Read-Host "(s/n)"
    if ($updPinnedManual -eq "s") {
        Write-Host "`nModo manual para pinned seleccionado.`n" -ForegroundColor Cyan
        # Pedir lista de pinned
        $pinnedLines = winget pin list
        # Detectar dinamicamente o índice do cabeçalho
        $headerIndex = -1
        for ($i = 0; $i -lt $pinnedLines.Count; $i++) {
            if ($pinnedLines[$i] -match "^Nome\s+ID\s+Versão\s+Origem\s+Tipo de marcador") {
                $headerIndex = $i
                break
            }
        }
        if ($headerIndex -ge 0) {
            $headerLine = $pinnedLines[$headerIndex]
            # Obter posições das colunas
            $idStart = $headerLine.IndexOf("ID")
            $versionStart = $headerLine.IndexOf("Versão")
            $pinnedLines = $pinnedLines | Select-Object -Skip ($headerIndex + 1)
        } else {
            # Fallback
            $idStart = $null
            $versionStart = $null
        }
        # Percorrer as linhas
        foreach ($line in $pinnedLines) {
            $text = $line.ToString().Trim()
            if ([string]::IsNullOrWhiteSpace($text)) { continue }
            if ($text -match "^-{5,}$") { continue }
            # Ignorar mensagens como "Nenhum pacote pinned encontrado"
            if ($text -match "Nenhum" -or $text -match "No pinned") { continue }
            # Extrair name e id
            if ($idStart -and $versionStart -and $line.Length -ge $versionStart) {
                $name = $line.Substring(0, $idStart).Trim()
                $id = $line.Substring($idStart, $versionStart - $idStart).Trim()
                if ([string]::IsNullOrWhiteSpace($name) -or [string]::IsNullOrWhiteSpace($id)) { continue }
            } else {
                $parts = $text -split "\s{2,}"
                if ($parts.Count -lt 2) { continue }
                $name = $parts[0]
                $id = $parts[1]
            }
            Write-Host "`nActualizar pinned: $name ?" -ForegroundColor Yellow
            $ans = Read-Host "(s/n)"
            if ($ans -eq "s") {
                Write-Host "A actualizar $name (pinned)..." -ForegroundColor Green
                winget upgrade --id $id --include-unknown --include-pinned -h
                Write-Host "Concluído.`n" -ForegroundColor Green
            }
            else {
                Write-Host "Ignorado.`n" -ForegroundColor DarkGray
            }
        }
        Write-Host "`nTodas as entradas pinned processadas." -ForegroundColor Cyan
    } else {
        # Se 'n' para actualizar um a um, pergunta por unpin um a um
        Write-Host "Queres remover pin um a um os pacotes PINNED?" -ForegroundColor Cyan
        $unpinPinnedManual = Read-Host "(s/n)"
        if ($unpinPinnedManual -eq "s") {
            Write-Host "`nModo manual para remover pin seleccionado.`n" -ForegroundColor Cyan
            # Pedir lista de pinned
            $pinnedLines = winget pin list
            # Detectar dinamicamente o índice do cabeçalho
            $headerIndex = -1
            for ($i = 0; $i -lt $pinnedLines.Count; $i++) {
                if ($pinnedLines[$i] -match "^Nome\s+ID\s+Versão\s+Origem\s+Tipo de marcador") {
                    $headerIndex = $i
                    break
                }
            }
            if ($headerIndex -ge 0) {
                $headerLine = $pinnedLines[$headerIndex]
                # Obter posições das colunas
                $idStart = $headerLine.IndexOf("ID")
                $versionStart = $headerLine.IndexOf("Versão")
                $pinnedLines = $pinnedLines | Select-Object -Skip ($headerIndex + 1)
            } else {
                # Fallback
                $idStart = $null
                $versionStart = $null
            }
            # Percorrer as linhas
            foreach ($line in $pinnedLines) {
                $text = $line.ToString().Trim()
                if ([string]::IsNullOrWhiteSpace($text)) { continue }
                if ($text -match "^-{5,}$") { continue }
                # Ignorar mensagens como "Nenhum pacote pinned encontrado"
                if ($text -match "Nenhum" -or $text -match "No pinned") { continue }
                # Extrair name e id
                if ($idStart -and $versionStart -and $line.Length -ge $versionStart) {
                    $name = $line.Substring(0, $idStart).Trim()
                    $id = $line.Substring($idStart, $versionStart - $idStart).Trim()
                    if ([string]::IsNullOrWhiteSpace($name) -or [string]::IsNullOrWhiteSpace($id)) { continue }
                } else {
                    $parts = $text -split "\s{2,}"
                    if ($parts.Count -lt 2) { continue }
                    $name = $parts[0]
                    $id = $parts[1]
                }
                Write-Host "`nRemover pin: $name ?" -ForegroundColor Yellow
                $ans = Read-Host "(s/n)"
                if ($ans -eq "s") {
                    Write-Host "A remover pin de $name..." -ForegroundColor Green
                    winget pin remove --id $id
                    Write-Host "Concluído.`n" -ForegroundColor Green
                }
                else {
                    Write-Host "Ignorado.`n" -ForegroundColor DarkGray
                }
            }
            Write-Host "`nTodas as entradas pinned processadas." -ForegroundColor Cyan
        }
    }
}
Write-Host "`nScript terminado." -ForegroundColor Cyan
Pause