# Winget Manager

Script em PowerShell para facilitar a gestão de actualizações no `winget`.

Este script foi pensado para tornar o uso do `winget` mais prático, interactivo e simples no dia-a-dia, permitindo gerir actualizações e actualizações escondidas de forma rápida através de menus.

## Funcionalidades

- ver programas com actualizações disponíveis
- actualizar todos os programas de uma vez
- gerir programas um a um
- actualizar individualmente
- desinstalar individualmente
- ignorar individualmente
- esconder actualizações uma a uma
- ver actualizações escondidas
- actualizar programas escondidos
- voltar a mostrar actualizações escondidas

## Requisitos

Antes de usar o script, confirma que tens:

- Windows com PowerShell
- `winget` instalado e funcional
- permissões para executar scripts PowerShell, ou uso do parâmetro `-ExecutionPolicy Bypass`

## Instalação

1. Guarda o ficheiro do script numa pasta à tua escolha.

   Por exemplo:

   ```powershell
   C:\Program Files\Scripts\winget-manager_1.4.4.ps1
   ```

2. Podes executar o script manualmente pelo PowerShell, ou seguir a recomendação abaixo para um acesso mais rápido.

## Recomendação de utilização

Para uma utilização mais rápida e cómoda, recomenda-se criar um atalho no ambiente de trabalho para executar o script directamente com o PowerShell.

### Como criar o atalho

1. Clica com o botão direito no ambiente de trabalho.
2. Escolhe `Novo > Atalho`.
3. No campo da localização, cola o comando do PowerShell com o caminho correcto para o ficheiro `.ps1`.

   Por exemplo:

   ```powershell
   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Scripts\winget-manager_1.4.4.ps1"
   ```

4. Dá um nome ao atalho, por exemplo, `Winget Manager`.
5. Clica em `Concluir`.

Depois disso, basta abrir o atalho sempre que quiseres iniciar o script.

## Utilização

Depois de iniciares o script, segue as opções apresentadas no menu interactivo.

O script permite gerir actualizações e actualizações escondidas sem teres de escrever manualmente os comandos do `winget` sempre que quiseres fazer manutenção.

## Novidades da versão 1.4.4

- gestão manual de programas um a um
- opção para actualizar, desinstalar ou ignorar individualmente
- opção para esconder actualizações uma a uma
- melhoria da linguagem do menu, com textos mais claros e naturais
- correcções no parsing da saída do `winget`, para garantir que os nomes e IDs dos programas são lidos correctamente

## Notas

- o caminho do script no atalho deve ser alterado conforme a pasta onde o guardaste
- se mudares o nome do ficheiro, actualiza também o comando do atalho
- o uso de `-ExecutionPolicy Bypass` serve para facilitar a execução directa do script
- algumas operações, como a desinstalação, podem depender do suporte do próprio `winget` para o programa em causa

## Exemplo de arranque manual

Se preferires, também podes iniciar o script manualmente com este comando:

```powershell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Scripts\winget-manager_1.4.4.ps1"
```

## Licença

Uso livre. Podes adaptar e melhorar conforme as tuas necessidades.
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

   Por exemplo:

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
