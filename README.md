# Winget Manager

Script em PowerShell para facilitar a gestão de actualizações no `winget`.

Este script permite:

- ver os programas com actualizações disponíveis
- actualizar todos os pacotes de uma vez
- actualizar pacotes um a um
- colocar pacotes em pin individualmente
- listar pacotes pinned
- actualizar pacotes pinned um a um
- remover pin dos pacotes individualmente

Foi pensado para tornar o uso do `winget` mais prático, interactivo e simples no dia-a-dia.

## Forma recomendada de iniciar

A melhor maneira de usar o script é criar um atalho para o PowerShell com o comando de arranque já definido.

Exemplo:

```powershell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Scripts\winget-manager_1.3.ps1"
