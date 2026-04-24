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

- `commit`: orienta tarefas de Git para criar commits por escopo, usando
  Conventional Commits e inferindo portugues ou ingles pelo historico recente.
- `pr`: orienta criacao de pull requests com todos os testes executados antes
  da submissao, titulo claro e changelog completo para revisao.
