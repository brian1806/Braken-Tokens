### Braken Tokens 🛡️🦆
Braken Tokens é uma ferramenta de Deception desenvolvida em PowerShell para criar arquivos "isca" (Canary Tokens) em sistemas **Windows**. O script automatiza a criação de múltiplos arquivos e configura as regras de auditoria do sistema para que qualquer interação com esses arquivos gere eventos rastreáveis.

# 🚀 Como funciona?
O script utiliza a infraestrutura de auditoria nativa do Windows para monitorar o acesso a arquivos específicos. Quando um "adversário" (ou usuário curioso) abre, edita ou deleta o arquivo, o Windows gera um Event ID 4663.

**Táticas do MITRE ATT&CK®**
Este projeto aborda as seguintes técnicas:

* T1078 (Valid Accounts): Detecta quando uma conta legítima acessa arquivos sensíveis.

* T1083 (File and Directory Discovery): Detecta exploração de diretórios por adversários.

* T1566 (Phishing): Pode ser usado para plantar arquivos "isca" em pastas de rede para detectar infiltração inicial.

# 🛠️ Recursos
Interface Interativa: Painel para cadastro de múltiplas iscas em uma única execução.

Automação de Auditoria: Configura automaticamente o auditpol para o subsistema de File System.

SACL dinâmica: Aplica permissões de auditoria para o grupo "Authenticated Users" (SID: S-1-5-11).

Feedback Visual: Barra de progresso e status de implantação por arquivo.

# 📋 Pré-requisitos
Para que o script funcione corretamente, ele deve ser executado como Administrador, pois altera políticas de auditoria do sistema (auditpol).
Habilitar a execução de Script na máquina.
Serviço de Auditoria: O serviço "Log de Eventos do Windows" deve estar em execução

# 🖥️ Nota Técnica: 

O script utiliza o GUID universal ```{0ccee921-0529-11d8-bd0a-00c04f0e0370}``` para ativar a auditoria de Sistema de Arquivos via auditpol. Isso garante compatibilidade com sistemas operacionais em qualquer idioma

# ⚙️ Configuração e Uso
**Execução:**
Abra o PowerShell como administrador e execute o script:

PowerShell
.\BrakenTokens.ps1

**Cadastro:**
Insira o caminho da pasta e o nome do arquivo (ex: C:\Financeiro e senhas_banco.txt).

**Monitoramento:**
Para visualizar os alertas, abra o Visualizador de Eventos (Event Viewer):

Vá em Logs do Windows -> Segurança.

Filtre pelo Event ID **4663**.

No campo *"Nome do Objeto"*, você verá o caminho do seu Braken Token acionado.

# ⚠️ Aviso Legal
Este script foi desenvolvido para fins educacionais e de defesa cibernética. O autor não se responsabiliza pelo uso indevido da ferramenta. Sempre teste em ambiente controlado antes de aplicar em produção.

*Desenvolvido por: Anthony Brian*

````Foco: Defesa Ativa e Cybersecurity.````
