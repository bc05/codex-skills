# codex-skills

Skills locais para uso com o Codex.

## Instalacao

```sh
./scripts/install-skills.sh
```

O script cria symlinks das skills deste repositorio em `~/.codex/skills`.
Para usar outro destino, defina `CODEX_SKILLS_DIR`:

```sh
CODEX_SKILLS_DIR=/caminho/para/skills ./scripts/install-skills.sh
```

## Skills

- `arquiteto`: orienta decisoes de arquitetura com modelo-alvo Codex 5.5,
  comparando alternativas, riscos e planos de implementacao.
- `commit`: orienta tarefas de Git para criar commits por escopo, usando
  Conventional Commits e inferindo portugues ou ingles pelo historico recente.
- `estagiario`: orienta triagem, levantamento de contexto e tarefas simples com
  modelo-alvo Codex 5.3, escalando riscos para perfis mais seniores.
- `implementador-pleno`: orienta implementacoes seguras com modelo-alvo Codex
  5.4, escopo pequeno, consistencia com o projeto e validacao proporcional.
- `implementador-senior`: orienta implementacoes criticas com modelo-alvo Codex
  5.5, julgamento senior, postura critica e validacao de riscos de producao.
- `pr`: orienta criacao de pull requests com todos os testes executados antes
  da submissao, titulo claro e changelog completo para revisao.
- `pr-review`: orienta revisoes tecnicas completas de pull requests por numero
  ou link, com analise de riscos e comentarios descritivos no diff.
- `revisor`: orienta revisoes tecnicas rigorosas com modelo-alvo Codex 5.5,
  priorizando bugs, riscos, seguranca, performance e testes ausentes.
- `sb-migration`: orienta a aplicacao de SQLs da diff local no Supabase local,
  gera uma nova migration com `supabase db diff` e infere o idioma do nome pelo
  historico de migrations.
