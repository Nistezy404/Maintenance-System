# 🧰 Windows Maintenance Toolkit

Toolkit interativo para manutenção, limpeza e diagnóstico do Windows 10/11. Inclui operações do Microsoft Defender, limpeza cautelosa de arquivos temporários e reparo de arquivos do sistema.

## 🚀 Funcionalidades

- 🛡️ Atualização das definições do Microsoft Defender
- 🔍 Verificação rápida ou completa com o Microsoft Defender
- 🧹 Remoção de arquivos temporários com mais de 7 dias
- ⚙️ Reparo da imagem e dos arquivos do Windows com DISM e SFC
- 📊 Diagnóstico de versão do Windows, espaço em disco, serviços parados e status do Defender
- 📋 Registro persistente das atividades
- 🎨 Menu interativo no PowerShell, iniciado diretamente ou pelo Prompt de Comando
- ✅ Confirmação antes de iniciar verificações, limpeza ou reparos

## 📦 Requisitos

- Windows 10 ou Windows 11
- Windows PowerShell 5.1 ou superior
- Microsoft Defender disponível para as funções de antivírus
- Permissão de Administrador para atualizar definições, iniciar verificações e executar reparos do sistema

Não é necessário instalar módulos adicionais para as funções principais.

## ▶️ Como usar

Mantenha os arquivos `.ps1` e `.cmd` na mesma pasta.

### 🔹 PowerShell

Abra o PowerShell na pasta do toolkit e execute:

```powershell
.\Toolkit-Manutencao-Windows.ps1
```

Para funções que exigem privilégios elevados, abra o PowerShell como Administrador antes de executar o script.

### 🔹 Prompt de Comando (CMD)

Execute `Toolkit-Manutencao-Windows.cmd` pelo Explorador de Arquivos ou pelo CMD. Ele abre o menu PowerShell do toolkit. Para tarefas administrativas, inicie o CMD como Administrador.

## 📋 Opções do menu

1. Atualizar assinaturas do Microsoft Defender
2. Iniciar verificação rápida
3. Iniciar verificação completa
4. Limpar temporários antigos
5. Reparar a imagem e os arquivos do Windows (DISM + SFC)
6. Exibir diagnóstico do sistema
0. Sair

## 📊 Logs

As atividades são registradas em:

```text
%LOCALAPPDATA%\ToolkitManutencao\toolkit.log
```

## 🔒 Segurança e operação

- O toolkit não desativa o Microsoft Defender nem remove itens da quarentena.
- A limpeza considera arquivos temporários com mais de 7 dias e ignora arquivos em uso ou sem permissão.
- O script solicita confirmação antes de iniciar as operações que podem alterar o sistema ou remover arquivos.
- Verificações completas e reparos podem levar bastante tempo.
- O toolkit não apaga o histórico do terminal.
- Execute como Administrador somente quando precisar das funções que exigem elevação.

## 🧩 Estrutura do projeto

```text
.
├── Toolkit-Manutencao-Windows.ps1
├── Toolkit-Manutencao-Windows.cmd
└── README.md
```

## 💡 Casos de uso

- Manutenção de computadores pessoais com Windows
- Atualização e verificação do Microsoft Defender
- Diagnóstico básico de disco, serviços e sistema
- Reparação de componentes do Windows
