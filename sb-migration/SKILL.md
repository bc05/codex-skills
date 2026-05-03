---
name: sb-migration
description: Use esta skill ao transformar arquivos .sql alterados na diff local em uma migration Supabase. Aplica os SQLs no banco local, executa supabase db diff para gerar uma nova migration e decide o idioma do nome analisando as migrations existentes.
---

# SB Migration

## Objetivo

Use esta skill para transformar SQLs locais ainda nao migrados em uma migration
Supabase revisavel.

O padrao obrigatorio e:

- Trabalhar somente contra o banco Supabase local, nunca remoto ou linked sem
  pedido explicito.
- Identificar os arquivos `.sql` criados ou alterados na diff local.
- Aplicar esses SQLs no banco local antes de gerar a migration.
- Analisar migrations existentes para escolher portugues ou ingles no nome.
- Gerar a migration com `supabase db diff -f <nome_da_migration>`.
- Validar que a migration gerada representa apenas a mudanca esperada.

## Fluxo

1. Inspecione o estado do repositorio:
   `git status --short --branch`.
2. Confirme que e um projeto Supabase local:
   `test -f supabase/config.toml`,
   `test -d supabase/migrations` e `supabase --version`.
3. Identifique arquivos SQL na diff local, incluindo staged, unstaged e
   untracked:
   `git diff --name-only --diff-filter=ACMR -- '*.sql'`,
   `git diff --cached --name-only --diff-filter=ACMR -- '*.sql'` e
   `git ls-files --others --exclude-standard -- '*.sql'`.
4. Una a lista, remova duplicados e ordene por caminho. Ignore arquivos
   deletados. Se houver SQLs em `supabase/migrations/`, leia com cuidado:
   - Se forem migrations historicas alteradas, nao aplique manualmente sem
     autorizacao explicita.
   - Se forem uma migration recem-gerada por tentativa anterior, trate como
     artefato a revisar, nao como entrada.
5. Leia os SQLs que serao aplicados para entender dependencias, schemas,
   funcoes, policies, extensoes e dados manipulados. Pare se a ordem de
   aplicacao nao puder ser inferida com seguranca.
6. Analise o idioma e o formato das migrations existentes:
   `find supabase/migrations -maxdepth 1 -type f -name '*.sql' | sort | tail -30`.
   Decida o idioma pelo nome depois do timestamp:
   - Use portugues quando predominarem termos como `cria`, `adiciona`,
     `corrige`, `remove`, `atualiza`, `ajusta`.
   - Use ingles quando predominarem termos como `create`, `add`, `fix`,
     `remove`, `update`, `adjust`.
   - Se houver mistura, use o idioma das migrations mais recentes que seguem o
     padrao do projeto.
   - Se nao houver sinal claro, use portugues.
7. Crie um nome curto, especifico, em ASCII e `snake_case`, sem timestamp.
   Exemplos: `cria_tabela_assinaturas`, `ajusta_politicas_perfil`,
   `create_subscriptions_table`, `fix_profile_policies`.
8. Garanta que a stack local esta rodando. Use o comando do projeto quando ele
   existir (`npx supabase`, `pnpm supabase`, `bunx supabase`) ou `supabase`
   direto quando for o padrao local. Se necessario, rode `supabase start`.
9. Prepare uma base local limpa antes de aplicar os SQLs quando isso for
   aceitavel para o trabalho:
   `supabase db reset --local`.
   Esse comando descarta dados locais fora das migrations e seeds; nao rode
   contra `--linked` ou `--db-url` sem pedido explicito.
10. Obtenha a URL do banco local com `supabase status` e use o valor `DB URL`.
    Aplique cada SQL em ordem, interrompendo no primeiro erro:
    `psql "<DB URL>" -v ON_ERROR_STOP=1 -f <arquivo.sql>`.
11. Gere a migration:
    `supabase db diff --local -f <nome_da_migration>`.
    Se a versao da CLI nao aceitar `--local`, use
    `supabase db diff -f <nome_da_migration>` e registre essa decisao.
12. Leia a migration criada em `supabase/migrations/` e compare com os SQLs de
    entrada. Remova somente ruido que a CLI gerou claramente e preserve
    declaracoes que o diff nao captura bem.
13. Valide a migration gerada:
    `supabase db reset --local`.
    Rode tambem `supabase db lint --local` quando o projeto ja usar lint de
    banco ou quando a mudanca tocar funcoes, policies, triggers ou RLS.
14. Confira o resultado final:
    `git status --short` e
    `git diff --stat -- supabase/migrations`.

## Cuidados

- Nao aplique SQLs em banco remoto para gerar migrations, a menos que o usuario
  peca isso explicitamente.
- Nao continue se um SQL falhar; reporte o arquivo, comando e erro essencial.
- O `db diff` pode nao capturar perfeitamente publicacoes, storage buckets e
  alguns atributos especiais de views. Quando os SQLs de entrada tocarem esses
  pontos, revise a migration manualmente antes de validar.
- Se o diff local incluir dados (`insert`, `update`, `delete`) junto de DDL,
  confirme se esses dados devem virar migration ou seed.
- Nao faca commit da migration a menos que o usuario tambem tenha pedido.

## Resposta Ao Usuario

Depois de gerar a migration, responda de forma curta com:

- Arquivo de migration criado.
- Nome escolhido, idioma usado e motivo com base nas migrations existentes.
- SQLs de entrada aplicados, na ordem.
- Comandos de validacao executados e resultado.
- Pendencias ou riscos, se houver.
