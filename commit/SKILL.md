---
name: commit
description: Use esta skill ao criar, organizar, revisar ou explicar commits Git. Aplica Conventional Commits, separa commits por escopo e escolhe entre portugues ou ingles analisando as mensagens recentes do historico do repositorio.
---

# Commit

## Objetivo

Use esta skill para transformar alteracoes locais em commits Git pequenos,
coerentes e rastreaveis. O padrao obrigatorio e:

- Conventional Commits.
- Um commit por escopo funcional ou tecnico.
- Mensagens no mesmo idioma predominante do historico recente do repositorio:
  portugues ou ingles.

## Fluxo

1. Inspecione o estado do repositorio:
   `git status --short --branch`.
2. Analise o idioma do historico recente antes de escrever mensagens:
   `git log --format=%s -n 30`.
3. Decida o idioma do resumo e do corpo do commit:
   - Use portugues quando a maioria das mensagens recentes estiver em
     portugues.
   - Use ingles quando a maioria das mensagens recentes estiver em ingles.
   - Se houver empate, historico insuficiente ou mistura forte, use o idioma
     das mensagens mais recentes que seguem o padrao do projeto.
   - Se ainda nao houver sinal claro, use portugues.
4. Leia as alteracoes antes de preparar commits:
   `git diff`, `git diff --cached` e, quando houver arquivos novos,
   `git diff --no-index /dev/null <arquivo>` ou leitura direta do arquivo.
5. Identifique escopos independentes. Um escopo e a menor area responsavel
   que explica a mudanca, como `auth`, `supabase`, `docs`, `ci`, `ui`,
   `finance`, `tests` ou o nome de um modulo local.
6. Agrupe arquivos e hunks por escopo. Use `git add <paths>` para escopos
   simples e `git add -p` quando o mesmo arquivo misturar mudancas de
   escopos diferentes.
7. Valide o que sera commitado com `git diff --cached --check` e
   `git diff --cached --stat`. Rode testes, lint ou typecheck relevantes
   quando forem baratos e proporcionais ao risco.
8. Crie um commit por escopo. Depois de cada commit, confira que o proximo
   escopo ainda esta limpo com `git status --short`.
9. Ao final, mostre os commits criados com `git log --oneline -n <quantidade>`,
   o idioma escolhido e as validacoes executadas.

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
type(scope): resumo no idioma escolhido
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
- O resumo deve estar no idioma escolhido, em minusculas, sem ponto final.
- Em portugues, prefira verbos claros no presente: `adiciona`, `corrige`,
  `ajusta`, `remove`, `documenta`, `separa`, `simplifica`, `atualiza`.
- Em ingles, prefira verbos claros no presente: `add`, `fix`, `adjust`,
  `remove`, `document`, `split`, `simplify`, `update`.
- Evite resumos genericos como `update`, `changes`, `ajustes`, `wip`, `misc`
  ou `corrige coisas`.
- Use corpo no mesmo idioma do cabecalho quando a motivacao ou o impacto nao
  couberem no resumo.
- Para breaking changes, use `!` no cabecalho e inclua corpo com
  `BREAKING CHANGE:`.

## Exemplos

Portugues:

```text
feat(auth): adiciona reaproveitamento transitorio do perfil
fix(supabase): corrige autorizacao das rpcs de assinatura
docs(git): documenta fluxo de commits por escopo
test(finance): cobre renegociacao sem parcelas pagas
refactor(ui): separa estado visual do card de renovacao
ci(eas): ajusta pipeline de build preview
```

Ingles:

```text
feat(auth): add transient profile reuse
fix(supabase): fix subscription rpc authorization
docs(git): document scoped commit flow
test(finance): cover renegotiation without paid installments
refactor(ui): split renewal card view state
ci(eas): adjust preview build pipeline
```

## Resposta Ao Usuario

Depois de criar commits, responda de forma curta com:

- Lista dos commits criados, com hash curto e mensagem.
- Escopo de cada commit quando houver mais de um.
- Idioma escolhido e motivo breve, com base no historico recente.
- Validacoes executadas ou motivo para nao executar.
- Estado final do `git status --short`.
