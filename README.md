# Winget Manager

Script em PowerShell para facilitar a gestão de actualizações no `winget`.

Este script foi pensado para tornar o uso do `winget` mais prático, interactivo e simples no dia-a-dia, permitindo gerir actualizações e pins de forma rápida através de menus.

## Funcionalidades

- ver programas com actualizações disponíveis
- actualizar todos os pacotes de uma vez
- actualizar pacotes um a um
- aplicar pin a pacotes individualmente
- listar pacotes com pin
- actualizar pacotes com pin um a um
- remover pin dos pacotes individualmente

## Requisitos

Antes de usar o script, confirma que tens:

- Windows com PowerShell
- `winget` instalado e funcional
- permissões para executar scripts PowerShell, ou uso do parâmetro `-ExecutionPolicy Bypass`

## Instalação

1. Guarda o ficheiro do script numa pasta à tua escolha.

   Exemplo:

   ```powershell
   C:\Program Files\Scripts\winget-manager_1.3.ps1

## Recomendação de utilização

Para uma utilização mais rápida e cómoda, recomenda-se criar um atalho no ambiente de trabalho para executar o script directamente com o PowerShell.

### Como criar o atalho

1. Clica com o botão direito no ambiente de trabalho.
2. Escolhe `Novo > Atalho`.
3. No campo da localização, cola o comando do PowerShell com o caminho correcto para o ficheiro `.ps1`.
   Por exemplo:

   ```powershell
   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Scripts\winget-manager_1.3.ps1"
4. Dá um nome ao atalho, por exemplo, `Winget Manager`.
5. Clica em `Concluir`.

Depois disso, basta abrir o atalho sempre que quiseres iniciar o script.
