# ===================================================================
# Script: BRAKEN TOKENS
# Linguagem: PowerShell
# Objetivo: Interface profissional para múltiplos Canary Tokens.
# ===================================================================

# -------------------------------
# 0. Cabeçalho Visual
# -------------------------------
Clear-Host
$asciiArt = @"
                                                  @@                                                  
                                                @@@@@@@                                              
                                              @@@@@@@@@@                                            
                                     @      @@@@@@@@@@@@@@      @                                    
                                    @@@   @@@@@@@@@@@@@@@@@@   @@@                                   
                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                  
                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                  
                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                  
                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                  
                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                               
                                   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                
                @@@@@@@@@@@@@@     @@@@@@@@ @@@@@@@@@@@@@ @@@@@@@@@@      @@@@@@@@@@@@@@              
             @@@@@@@@@@@@@@@@@@    @@@@@@@   @@@@@@@@@@@   @@@@@@@@@    @@@@@@@@@@@@@@@@@             
            @@@@@@        @@@@@@    @@@@@@   @@@@@@@@@@@   @@@@@@@@    @@@@@@@        @@@@          
          @@@@@            @@@@@@    @@@@@@ @@@@@@@@@@@@@ @@@@@@@    @@@@@@            @@@        
          @@@@              @@@@@@    @@@@@@@@@@@@@@@@@@@@@@@@@@   @@@@@@             @@@@        
          @@@@         @    @@@@@@    @@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@    @        @@@@        
          @@@@@@        @@    @@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@    @@      @@@@@        
          @@@@@@@@@@@@@@@@    @@@@@@   @@@@@@@@@@@@@@@@@@@@@@@    @@@@@@    @@@@@@@@@@@        
            @@@@@@@@@@@@      @@@@@@   @@@@@@@@@@@@@@@@@@@@@@@   @@@@@@      @@@@@@@          
                                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                              
              @@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@            
            @@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@          
            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          
            @@@@@@@@            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            @@@@@@@@          
            @@@@@@                  @@@@@@@@@@@@@@@ @@@@@@@@@@@@@@                  @@@@@@          
            @@@@                    @@@@@@@@@@@@@@  @@@@@@@@@@@@@@                    @@@@          
            @@@@              @@@  @@@@@@@@@@@@@@    @@@@@@@@@@@@@   @@@              @@@@          
            @@@@                @   @@@@@@@@@@@@@    @@@@@@@@@@@@@   @                @@@@          
            @@@@              @@  @@@@@@@@@@@@          @@@@@@@@@@@@  @@              @@@@          
             @@@@@           @@@  @@@@@@@@@@              @@@@@@@@@@  @@@            @@@@            
              @@@@@@@@@@@@@@@@@ @@@@@@        @@      @@        @@@@@  @@@@@@@@@@@@@@@@@            
                @@@@@@@@@@@@@@  @@@@            @@  @@            @@@@  @@@@@@@@@@@@@@              
                  @@@@@@@@@@@@  @@              @@  @@              @@  @@@@@@@@@@@@                
                  @@@@@@@@@@  @@@@              @@  @@              @@@@  @@@@@@@@@                
                              @@@               @@  @@               @@@                      
                              @@@@              @@  @@              @@@@                            
                              @@@@@@@@@@    @@@@@@  @@@@@@    @@@@@@@@@@                            
                                  @@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@                                
                                    @@@@@@@@@@@@@@  @@@@@@@@@@@@@@                                  
                                      @@@@@@@@@@      @@@@@@@@@@       
      
               ____  ____      _    _  _______ _   _     _____ ___  _  _______ _   _ ____ 
              |  _ \|  _ \    / \  | |/ / ____| \ | |   |_   _/ _ \| |/ / ____| \ | / ___| 
 	      | |_) | |_) |  / _ \ | ' /|  _| |  \| |     | || | | | ' /|  _| |  \| \___ \ 
              |  _ <|  _ <  / ___ \| . \| |___| |\  |     | || |_| | . \| |___| |\  |___) |
              |____/|_| \_\/_/   \_\_|\_\_____|_| \_|     |_| \___/|_|\_\_____|_| \_|____/

"@
Write-Host $asciiArt -ForegroundColor Blue

# -------------------------------
# 1. Variáveis Globais
# -------------------------------
$listaDeTokens = @()
$grupoAuditadoSID = "S-1-5-11" 
$conteudoArquivo  = "Como conteúdo, coloque apenas informações que não falsas!"

# -------------------------------
# 2. Coleta de Dados Interativa
# -------------------------------
Write-Host "`n+---------------------------------------------------------+" -ForegroundColor Green
Write-Host "¦             PAINEL DE CADASTRO DE ISCAS                 ¦" -ForegroundColor Green
Write-Host "+---------------------------------------------------------+" -ForegroundColor Green

Do {
    Write-Host "`n[+] Configurando novo ponto de monitoramento:" -ForegroundColor White
    $diretorio = Read-Host "    > Caminho da PASTA"
    $arquivo   = Read-Host "    > Nome do ARQUIVO (ex: dados.xlsx)"
    
    $caminhoFinal = Join-Path -Path $diretorio -ChildPath $arquivo
    $listaDeTokens += [PSCustomObject]@{
        ID      = $listaDeTokens.Count + 1
        Arquivo = $arquivo
        Caminho = $caminhoFinal
    }

    Write-Host "`n[?] Registro adicionado com sucesso!" -ForegroundColor Green
    $continuar = Read-Host "    Deseja adicionar outro? (S/N)"
} While ($continuar -eq "S" -or $continuar -eq "s")

# -------------------------------
# 3. Resumo Antes da Instalação
# -------------------------------
Write-Host "`n`n=== REVISÃO DOS TOKENS AGENDADOS ===" -ForegroundColor Yellow
$listaDeTokens | Format-Table ID, Arquivo, Caminho -AutoSize

Write-Host "Pressione qualquer tecla para iniciar a implantação..." -ForegroundColor Gray
$null = [System.Console]::ReadKey()

# -------------------------------
# 4. Funções de Processamento
# -------------------------------

function Executar-Instalacao {
    param($Path, $Content, $SID)
    
    $diretorio = Split-Path $Path
    
    # Cria pasta se não existir
    if (-not (Test-Path $diretorio)) {
        New-Item -Path $diretorio -ItemType Directory -Force | Out-Null
    }
    
    # Cria o arquivo
    Set-Content -Path $Path -Value $Content -Force
    
    # Ativa Auditoria via Auditpol
    auditpol /set /subcategory:"File System" /success:enable /failure:disable 2>$null | Out-Null
    
    # Aplica SACL
    try {
        $SecurityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($SID)
        $acl = Get-Acl $Path
        $auditRule = New-Object System.Security.AccessControl.FileSystemAuditRule(
            $SecurityIdentifier, 
            "ReadData, ReadAttributes, WriteData, WriteAttributes, Delete, DeleteSubdirectoriesAndFiles",
            "None",
            "None",
            "Success"
        )
        $acl.SetAuditRule($auditRule)
        Set-Acl -Path $Path -AclObject $acl
        return $true
    } catch { return $false }
}

# -------------------------------
# 5. Execução com Barra de Progresso
# -------------------------------
$total = $listaDeTokens.Count
$atual = 0

foreach ($token in $listaDeTokens) {
    $atual++
    $percentual = ($atual / $total) * 100
    
    Write-Progress -Activity "Implantando Braken Tokens" -Status "Processando: $($token.Arquivo)" -PercentComplete $percentual
    
    $resultado = Executar-Instalacao -Path $token.Caminho -Content $conteudoArquivo -SID $grupoAuditadoSID
    
    if ($resultado) {
        Write-Host "[ OK ] " -NoNewline -ForegroundColor Green
        Write-Host "$($token.Caminho)" -ForegroundColor Gray
    } else {
        Write-Host "[ ERRO ] " -NoNewline -ForegroundColor Red
        Write-Host "$($token.Caminho)" -ForegroundColor Gray
    }
    Start-Sleep -Milliseconds 200 # Apenas para o visual da barra de progresso ser percebido
}

Write-Host "`n`n**************************************************" -ForegroundColor Green
Write-Host "    IMPLANTAÇÃO FINALIZADA COM SUCESSO!" -ForegroundColor Green
Write-Host "**************************************************" -ForegroundColor Green
