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

## 🧪 Labs

```
01-linux-shell/
├── README.md
├── notes.md
└── labs/
    ├── lab01/          # primeiros comandos
    └── scripts/
        ├── ola.sh
        └── backup.sh
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

**Dica de depuração:** `bash -x ./script.sh` mostra cada linha como o Bash a interpretou.

---

## ✅ Checklist do capítulo

- [x] Navegação e manipulação de arquivos
- [x] Leitura, busca e pipe
- [x] Permissões com `chmod`
- [x] Variáveis
- [x] Primeiro script (`ola.sh`)
- [x] Script de backup (`backup.sh`)
- [ ] Processos (`ps`, `top`, `kill`)
- [ ] Instalar o WSL e repetir os labs num Linux de verdade

---

## 📚 Referências

- [roadmap.sh/devops](https://roadmap.sh/devops)
- `man comando` ou `comando --help` para a documentação de qualquer comando

⬅️ [Voltar para a Saga](../README.md) · ➡️ [Próximo: Git & GitHub](../02-git-github)
