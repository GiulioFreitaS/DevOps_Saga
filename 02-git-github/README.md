# 02-git-github
# 🔀 Capítulo 02: Git & GitHub

## Etapa 1: os três estados

```
Working directory  →  git add  →  Staging  →  git commit  →  Repositório
```

| Comando | O que faz |
|---|---|
| `git status` | mostra o estado de cada arquivo |
| `git add arq` | marca o que entra no próximo commit |
| `git commit -m "msg"` | grava o staging no histórico |
| `git diff` | working directory vs staging |
| `git diff --staged` | staging vs último commit |
| `git restore arq` | descarta a edição |
| `git restore --staged arq` | tira do staging, mantém a edição |

**`git add` não salva, ele marca o que vai entrar no próximo commit.**
Só o `git commit` grava no histórico.

### Por que o `git diff` ficou vazio depois do `git add`?

O `git diff` compara working directory com staging. Depois do `git add`, os dois
são iguais. A mudança aparece no `git diff --staged`.

## ✅ Checklist

- [x] Os três estados
- [ ] Histórico: `log`, `show`
- [ ] Desfazer: `reset`, `revert`, `amend`
- [ ] Branches e merge
- [ ] Conflitos
- [ ] Remoto e Pull Request
