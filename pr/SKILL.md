---
name: pr
description: Use esta skill ao preparar, revisar, submeter ou criar pull requests. Exige executar todos os testes antes de submeter, bloquear e notificar falhas, criar titulo claro e gerar changelog completo pronto para revisao no corpo do PR.
---

# PR

## Objetivo

Use esta skill para transformar uma branch pronta em um pull request revisavel,
com validacao local completa e documentacao suficiente para a revisao.

O padrao obrigatorio e:

- Rodar todos os testes descobertos antes de submeter.
- Nao criar nem atualizar PR se algum teste falhar.
- Notificar claramente qualquer falha de teste.
- Criar PR com titulo claro.
- Gerar changelog completo pronto para revisao.

## Fluxo

1. Inspecione o estado do repositorio:
   `git status --short --branch`.
2. Confirme a branch atual e a branch base:
   `git branch --show-current` e `git remote show origin`.
3. Leia o historico e o delta que entrara no PR:
   `git log --oneline <base>..HEAD`,
   `git diff --stat <base>...HEAD` e
   `git diff --name-status <base>...HEAD`.
4. Se houver alteracoes sem commit, organize commits antes de abrir o PR.
   Quando a skill `commit` estiver disponivel, use o fluxo dela.
5. Descubra todos os comandos de teste declarados no projeto antes de rodar:
   scripts de `package.json`, arquivos de configuracao de test runners,
   `Makefile`, `justfile`, workflows locais, scripts do repo e convencoes da
   linguagem usada.
6. Execute todos os testes descobertos. Inclua suites unitarias, integracao,
   lint/testes estaticos e typecheck quando o projeto tratar esses comandos
   como parte da validacao normal.
7. Se qualquer teste falhar, interrompa o fluxo antes de push/PR. Notifique o
   usuario com comando, codigo de saida, resumo da falha e proximo passo
   recomendado.
8. Se todos os testes passarem, faca push da branch quando necessario.
9. Crie ou atualize o PR com titulo claro e corpo contendo changelog completo.
10. Ao final, informe link/numero do PR, titulo, comandos de teste executados
    e status final do repositorio.

## Regras De Teste

- "Todos os testes" significa todos os comandos de validacao que o repositorio
  expõe para a mudanca em questao.
- Nao escolha apenas um teste focado quando houver suite completa disponivel.
- Quando houver varios package managers, use o lockfile para decidir:
  `pnpm-lock.yaml`, `yarn.lock`, `package-lock.json` ou `bun.lockb`.
- Em monorepos, rode os testes dos pacotes afetados e qualquer suite raiz que
  agregue validacao do projeto.
- Nao ignore falhas existentes sem evidencia. Se a falha parecer preexistente,
  reporte isso com o comando e a evidencia, mas ainda nao submeta sem
  autorizacao explicita.
- Se nao existir comando de teste claro, explique a busca feita e bloqueie para
  confirmacao antes de submeter.

## Titulo Do PR

O titulo deve ser curto, claro e especifico:

- Descreva a mudanca principal, nao o processo.
- Evite `WIP`, `updates`, `misc`, `fix stuff`, `ajustes` ou titulos vagos.
- Use o idioma predominante do repositorio, do historico da branch ou do pedido
  do usuario.
- Nao force Conventional Commits no titulo do PR, a menos que o projeto ja use
  esse padrao para PRs.

Exemplos:

```text
Adiciona skill para commits por escopo
Corrige validacao de assinaturas no Supabase
Add scoped commit skill
Fix subscription RPC authorization
```

## Changelog Do PR

Gere o corpo do PR como documentacao pronta para revisao. Use os commits, o
diff, os arquivos alterados e os testes executados como fonte.

Formato recomendado:

```markdown
## Resumo

- ...

## Changelog

### Adicionado

- ...

### Alterado

- ...

### Corrigido

- ...

### Removido

- ...

## Validacao

- [x] `comando executado`

## Impacto

- ...

## Riscos E Observacoes

- ...
```

Regras:

- Remova secoes vazias ou marque como `Nao se aplica` quando a ausencia for
  importante para revisao.
- Inclua migracoes, variaveis de ambiente, breaking changes, mudancas de API,
  comportamento de usuario, riscos e plano de rollback quando aplicavel.
- O changelog deve explicar o que mudou e por que isso importa para quem
  revisa.
- Se existir template de PR no repositorio, preserve a estrutura obrigatoria do
  template e encaixe o changelog nela.
- Se existir `CHANGELOG.md` e a mudanca exigir registro permanente, atualize o
  arquivo alem do corpo do PR.

## Submissao

- Use a ferramenta disponivel no ambiente: GitHub app, `gh pr create`,
  `gh pr edit` ou equivalente do provedor.
- Prefira draft PR quando a mudanca ainda precisar de revisao humana antes de
  ficar pronta para merge.
- Depois de criar ou atualizar o PR, confira se o link existe e se o corpo
  contem o changelog completo.
- Nao use auto-merge sem pedido explicito.

## Resposta Ao Usuario

Depois de criar ou atualizar o PR, responda de forma curta com:

- Link/numero do PR.
- Titulo criado.
- Changelog resumido em poucos bullets.
- Lista de testes executados e resultado.
- Falhas encontradas ou pendencias, se houver.
