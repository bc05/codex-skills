---
name: git-conventional-commits-pt-br
description: Use esta skill ao criar, organizar, revisar ou explicar commits Git. Aplica Conventional Commits com mensagens em portugues do Brasil e separa commits por escopo, revisando status e diff antes de staged/commit.
---

# Git Conventional Commits PT-BR

## Objetivo

Use esta skill para transformar alteracoes locais em commits Git pequenos,
coerentes e rastreaveis. O padrao obrigatorio e:

- Conventional Commits.
- Mensagens de commit em portugues do Brasil.
- Um commit por escopo funcional ou tecnico.

## Fluxo

1. Inspecione o estado do repositorio:
   `git status --short --branch`.
2. Leia as alteracoes antes de preparar commits:
   `git diff`, `git diff --cached` e, quando houver arquivos novos,
   `git diff --no-index /dev/null <arquivo>` ou leitura direta do arquivo.
3. Identifique escopos independentes. Um escopo e a menor area responsavel
   que explica a mudanca, como `auth`, `supabase`, `docs`, `ci`, `ui`,
   `finance`, `tests` ou o nome de um modulo local.
4. Agrupe arquivos e hunks por escopo. Use `git add <paths>` para escopos
   simples e `git add -p` quando o mesmo arquivo misturar mudancas de
   escopos diferentes.
5. Valide o que sera commitado com `git diff --cached --check` e
   `git diff --cached --stat`. Rode testes, lint ou typecheck relevantes
   quando forem baratos e proporcionais ao risco.
6. Crie um commit por escopo. Depois de cada commit, confira que o proximo
   escopo ainda esta limpo com `git status --short`.
7. Ao final, mostre os commits criados com `git log --oneline -n <quantidade>`
   e informe as validacoes executadas.

## Regras De Escopo

- Nunca faca um commit unico para mudancas independentes.
- Prefira um commit que contenha implementacao e teste do mesmo comportamento.
- Separe documentacao, configuracao, CI, refactors e correcoes quando forem
  independentes.
- Nao use `git add .` quando houver mais de um escopo ou arquivos nao
  relacionados.
- Nao inclua alteracoes preexistentes do usuario sem entender o escopo delas.
- Se nao for possivel separar escopos com seguranca, pare e explique o conflito.

## Formato Da Mensagem

Use sempre:

```text
type(scope): resumo em portugues
```

Tipos permitidos:

- `feat`: nova funcionalidade.
- `fix`: correcao de bug.
- `docs`: documentacao.
- `test`: testes.
- `refactor`: refatoracao sem mudar comportamento.
- `perf`: melhoria de desempenho.
- `style`: formatacao sem mudanca funcional.
- `build`: build, dependencias ou empacotamento.
- `ci`: pipelines e automacoes.
- `chore`: manutencao que nao se encaixa melhor nos outros tipos.
- `revert`: reversao.

Regras do cabecalho:

- O `scope` deve ser curto, sem espacos e sem acentos. Use kebab-case se
  precisar de mais de uma palavra.
- O resumo deve estar em portugues, em minusculas, sem ponto final.
- Prefira verbos claros no presente: `adiciona`, `corrige`, `ajusta`,
  `remove`, `documenta`, `separa`, `simplifica`, `atualiza`.
- Evite resumos genericos como `update`, `ajustes`, `wip`, `misc` ou
  `corrige coisas`.
- Use corpo em portugues quando a motivacao ou o impacto nao couberem no
  cabecalho.
- Para breaking changes, use `!` no cabecalho e inclua corpo com
  `BREAKING CHANGE:`.

## Exemplos

```text
feat(auth): adiciona reaproveitamento transitorio do perfil
fix(supabase): corrige autorizacao das rpcs de assinatura
docs(git): documenta fluxo de commits por escopo
test(finance): cobre renegociacao sem parcelas pagas
refactor(ui): separa estado visual do card de renovacao
ci(eas): ajusta pipeline de build preview
```

## Resposta Ao Usuario

Depois de criar commits, responda de forma curta com:

- Lista dos commits criados, com hash curto e mensagem.
- Escopo de cada commit quando houver mais de um.
- Validacoes executadas ou motivo para nao executar.
- Estado final do `git status --short`.
