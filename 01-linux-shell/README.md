# 🐧 Capítulo 01: Linux & Shell

Primeiro capítulo da saga. Aqui aprendo a trabalhar pelo terminal, que é a base de tudo em DevOps: servidores, containers e pipelines são operados por linha de comando.

**Ambiente usado:** Git Bash (Windows). Mais à frente pretendo migrar para o WSL, para ter um Linux completo.

---

## 📋 Conteúdo

- [Navegação](#-navegação)
- [Arquivos e pastas](#-arquivos-e-pastas)
- [Leitura e busca](#-leitura-e-busca)
- [Pipe e redirecionamento](#-pipe-e-redirecionamento)
- [Permissões](#-permissões)
- [Variáveis](#-variáveis)
- [Scripts Bash](#-scripts-bash)
- [Processos](#-processos)
- [Labs](#-labs)
- [Erros que cometi e o que aprendi](#-erros-que-cometi-e-o-que-aprendi)
- [Checklist do capítulo](#-checklist-do-capítulo)

---

## 🧭 Navegação

| Comando | O que faz |
|---|---|
| `pwd` | mostra a pasta atual |
| `ls` / `ls -la` | lista arquivos (com detalhes e ocultos) |
| `cd pasta` | entra na pasta |
| `cd ..` | sobe um nível |
| `cd ~` | vai para a home |
| `cd -` | volta para a pasta anterior |
| `clear` | limpa a tela |

**Atalhos:** `Tab` completa nomes, `↑` repete o comando anterior, `Ctrl+C` interrompe.

---

## 📁 Arquivos e pastas

| Comando | O que faz |
|---|---|
| `mkdir pasta` | cria pasta (`-p` cria o caminho inteiro) |
| `touch arq` | cria arquivo vazio |
| `cp origem destino` | copia (`-r` para pastas) |
| `mv origem destino` | move ou renomeia |
| `rm arq` | apaga arquivo (`-r` para pastas) |

> ⚠️ O terminal não tem lixeira. O `rm` apaga de vez.

**Para que serve o `cp`:** backup antes de editar configuração, criar `.env` a partir de `.env.example`, reaproveitar labs e copiar arquivos para o lugar certo num deploy.

---

## 🔎 Leitura e busca

| Comando | O que faz |
|---|---|
| `cat arq` | mostra o conteúdo |
| `head -n 5 arq` | primeiras 5 linhas |
| `tail -n 5 arq` | últimas 5 linhas |
| `grep "texto" arq` | procura um texto |
| `wc -l arq` | conta linhas |

---

## 🔗 Pipe e redirecionamento

O **pipe** (`|`) manda a saída de um comando como entrada do próximo.

```bash
ls | wc -l                       # quantos itens tem na pasta
history | grep "git" | tail -n 5 # os 5 últimos comandos git usados
```

| Símbolo | Destino da saída |
|---|---|
| `\|` | outro comando |
| `>` | arquivo (sobrescreve) |
| `>>` | arquivo (adiciona no final) |

---

## 🔐 Permissões

O `ls -l` mostra algo como `-rwxr-xr--`, dividido em **dono**, **grupo** e **outros**.

| Letra | Significa | Valor |
|---|---|---|
| `r` | ler | 4 |
| `w` | escrever | 2 |
| `x` | executar | 1 |

```bash
chmod +x script.sh     # torna executável
chmod 755 script.sh    # dono rwx, grupo e outros r-x
chmod 644 arquivo.txt  # dono rw-, grupo e outros r--
```

---

## 📦 Variáveis

```bash
nome="Giulio"          # sem espaços ao redor do =
echo "Olá, $nome"
export AMBIENTE="dev"  # disponível para outros programas
echo $HOME $USER $PATH # variáveis de ambiente
```

---

## 📜 Scripts Bash

### Estrutura básica

```bash
#!/bin/bash        # interpretador
arquivo="$1"       # primeiro argumento do script

if [ condição ]; then
  # verdadeiro
else
  # falso
fi                 # fecha o if

for i in 1 2 3; do
  echo "$i"
done               # fecha o for
```

### Testes úteis dentro do `[ ]`

| Teste | Significa |
|---|---|
| `-z "$x"` | string vazia |
| `-n "$x"` | string não vazia |
| `-f arq` | existe e é arquivo |
| `-d pasta` | existe e é pasta |
| `-e caminho` | existe (arquivo ou pasta) |
| `"$a" = "$b"` | strings iguais (com espaços dentro dos colchetes) |
| `! teste` | inverte o teste, ex.: `[ ! -f "$1" ]` |
| `-eq`, `-gt`, `-ge` | comparações numéricas |

### `scripts/ola.sh`

Recebe um nome como argumento, mostra a data e faz uma contagem.

```bash
./ola.sh Giulio
```

### `scripts/backup.sh`

Recebe um arquivo, verifica se ele existe e cria uma cópia `.bak`.

```bash
#!/bin/bash

arquivo="$1"

if [ -z "$arquivo" ]; then
  echo "Uso: ./backup.sh NOME_DO_ARQUIVO"
  exit 1
fi

if [ -f "$arquivo" ]; then
  cp "$arquivo" "$arquivo.bak"
  echo "Backup criado: $arquivo.bak"
else
  echo "Esse arquivo não existe"
fi
```

```bash
./backup.sh notes.md     # cria notes.md.bak
./backup.sh              # mostra a mensagem de uso
```

---

## 🔄 Processos

Um **processo** é um programa em execução. Cada processo tem um **PID** (identificador único) e um **PPID** (PID do processo que o criou). Quando rodo `sleep 300` no terminal, o Bash cria um processo novo para o `sleep`.

> ⚠️ **Ambiente:** os testes foram feitos no **Git Bash** (MSYS2 sobre Windows), que não é um Linux completo. Onde há diferença para o Linux/WSL, ela está indicada.

### Comandos

| Comando | O que faz | Observação |
|---|---|---|
| `ps` | Lista os processos do terminal atual | No Git Bash mostra também o `WINPID` |
| `ps -W` | Lista os processos do Windows inteiro | Exclusivo do Git Bash |
| `ps aux` | Lista todos os processos (Linux/WSL) | Saída diferente no Git Bash |
| `top` / `htop` | Monitor em tempo real | Não existem no Git Bash. Usar WSL |
| `comando &` | Executa em segundo plano | Devolve o terminal na hora |
| `jobs` | Lista os jobs do terminal | `%1`, `%2`... identificam cada um |
| `echo $!` | PID do último processo em segundo plano | |
| `fg` / `bg` | Traz para o primeiro plano / continua em segundo plano | `Ctrl+Z` e `bg` são instáveis no Git Bash |
| `kill PID` | Envia SIGTERM (pede para encerrar) | Permite ao processo limpar antes de sair |
| `kill -9 PID` | Envia SIGKILL (força o encerramento) | Último recurso, não permite limpeza |
| `kill %N` | Encerra o job número N | |
| `pgrep` / `pkill` | Buscar/encerrar por nome (Linux/WSL) | Não vêm no Git Bash |
| `tasklist` / `taskkill //F //IM nome.exe` | Equivalentes do Windows | Usar `//` com duas barras no Git Bash |

### Sinais: SIGTERM vs SIGKILL

`kill` não "mata" diretamente, ele **envia um sinal** ao processo.

- **SIGTERM (15)**, padrão do `kill PID`: pede educadamente. O programa pode salvar dados e fechar arquivos.
- **SIGKILL (9)**, `kill -9 PID`: o sistema encerra na hora. O processo não consegue limpar nada.

Regra: começar sempre pelo SIGTERM e usar `-9` só se o processo não responder.

### Exercício prático

```bash
sleep 500 &
sleep 600 &
jobs              # lista os dois
ps                # mostra os PIDs
kill %1           # encerra o job 1
jobs              # só sobrou um
kill $!           # encerra o último criado
```

### Conceito-chave: código de saída (exit code)

O `if` do Bash não avalia o texto impresso, avalia o **código de saída** do comando:

- `0` → sucesso (verdadeiro)
- diferente de `0` → falha (falso)

O código do último comando fica em `$?`:

```bash
ps -W | grep -i bash | grep -v grep > /dev/null
echo $?    # 0 se encontrou, 1 se não encontrou
```

### Script 1: `scripts/monitor.sh`

Verifica se um processo está rodando, pelo nome.

```bash
#!/bin/bash
# Uso: ./monitor.sh <nome-do-processo>

if [ -z "$1" ]; then
  echo "Uso: $0 <nome-do-processo>"
  exit 1
fi

if ps -W | grep -i "$1" | grep -v grep > /dev/null; then
  echo "✅ $1 está rodando"
else
  echo "❌ $1 não está rodando"
fi
```

**Como a linha principal funciona**

```bash
if ps -W | grep -i "$1" | grep -v grep > /dev/null; then
```

| Parte | Função |
|---|---|
| `ps -W` | lista os processos do Windows |
| `\|` | entrega a saída de um comando como entrada do próximo |
| `grep -i "$1"` | filtra as linhas com o nome recebido, ignorando maiúsculas |
| `grep -v grep` | remove o próprio `grep` da lista, para ele não se achar |
| `> /dev/null` | descarta a saída: só interessa o código de saída |
| `if` | executa o `then` se o código de saída for `0` |

**Teste**

```bash
chmod +x scripts/monitor.sh
./scripts/monitor.sh bash      # ✅ está rodando
./scripts/monitor.sh xyz123    # ❌ não está rodando
./scripts/monitor.sh           # mostra o uso
```

### Script 2: `scripts/limpa_sleep.sh`

Lista todos os `sleep` em execução e pergunta se devem ser encerrados.

```bash
#!/bin/bash

# Guarda os PIDs de todos os sleeps numa variável
pids=$(ps | grep sleep | grep -v grep | awk '{print $1}')

if [ -z "$pids" ]; then
  echo "Nenhum sleep rodando."
  exit 0
fi

echo "Sleeps encontrados (PIDs):"
echo "$pids"

read -p "Encerrar todos os sleeps? (s/n) " resp

if [ "$resp" = "s" ]; then
  for pid in $pids; do
    kill "$pid"
  done
  echo "Todos encerrados."
else
  echo "Nada foi encerrado."
fi
```

**Conceitos usados**

- `$(comando)`: guarda a **saída** do comando numa variável.
- `awk '{print $1}'`: extrai a primeira coluna, que no `ps` é o PID.
- `read -p`: pergunta algo e guarda a resposta em uma variável.
- `for ... do ... done`: percorre cada PID.
- `exit 0`: encerra o script indicando sucesso.

**Teste**

```bash
chmod +x scripts/limpa_sleep.sh
sleep 500 &
sleep 600 &
./scripts/limpa_sleep.sh
```

---

### Linux/WSL vs Git Bash

| Tarefa | Linux/WSL | Git Bash |
|---|---|---|
| Ver todos os processos | `ps aux` | `ps -W` |
| Monitor em tempo real | `top`, `htop` | Gerenciador de Tarefas / `tasklist` |
| Buscar por nome | `pgrep nome` | `ps -W \| grep nome` |
| Encerrar por nome | `pkill nome` | `taskkill //F //IM nome.exe` |

---

## 🧪 Labs

```
01-linux-shell/
├── README.md
├── notes.md
└── labs/
    ├── lab01/          # primeiros comandos
    └── scripts/
        ├── ola.sh
        ├── backup.sh
        ├── monitor.sh
        └── limpa_sleep.sh
```

---

## 🐛 Erros que cometi e o que aprendi

| Erro | Causa | Lição |
|---|---|---|
| `syntax error near unexpected token 'fi'` | faltou `;` antes do `then` e havia dois `fi` | cada `if` tem um único `fi`, e o `else` fica dentro dele |
| Script caía sempre no `else` | escrevi `[ -f "arquivo" ]` sem o `$` | sem `$`, o Bash trata como texto literal |
| `cp: -r not specified; omitting directory` | `-f` só vale para arquivos, e passei uma pasta | usar `-d` e `cp -r` para pastas |
| Lógica invertida | mensagem de erro no ramo verdadeiro do `if` | testar sempre os dois caminhos |
| `chmod +zxy` inválido | `z` e `y` não são permissões | só existem `r`, `w` e `x` |
| `bash: $: command not found` | copiei o `$` do prompt junto com o comando | o `$` no início da linha é só o prompt |
| Arquivo criado vazio | o `>` cria o arquivo mesmo quando o comando falha | conferir com `cat arquivo` depois de criar |
| `#!/bin/bash` ignorado | havia uma linha em branco antes dele | o shebang tem que ser a **linha 1** |
| `kill $1` não fazia nada | `$1` é o argumento do script, não os PIDs | guardar os PIDs numa variável e usá-la |
| `awk` sem resultado | não estava ligado ao `ps` por pipe | `awk` lê a entrada padrão: precisa receber dados |
| `$resp` vazio após `\| read` | o `read` depois de pipe roda em subshell | usar `read` sozinho, sem pipe antes |
| `[$resp = "s"]` falhou | faltaram espaços e aspas dentro dos colchetes | o `[` é um comando: `[ "$resp" = "s" ]` |

**Dicas de depuração:** `bash -x ./script.sh` mostra cada linha como o Bash a interpretou, e `bash -n ./script.sh` verifica a sintaxe sem executar.

---

## ✅ Checklist do capítulo

- [x] Navegação e manipulação de arquivos
- [x] Leitura, busca e pipe
- [x] Permissões com `chmod`
- [x] Variáveis
- [x] Primeiro script (`ola.sh`)
- [x] Script de backup (`backup.sh`)
- [x] Processos (`ps`, `jobs`, `kill`) e scripts `monitor.sh` e `limpa_sleep.sh`
- [ ] Instalar o WSL e repetir os labs num Linux de verdade

---

## 📚 Referências

- [roadmap.sh/devops](https://roadmap.sh/devops)
- `man comando` ou `comando --help` para a documentação de qualquer comando

⬅️ [Voltar para a Saga](../README.md) · ➡️ [Próximo: Git & GitHub](../02-git-github)
