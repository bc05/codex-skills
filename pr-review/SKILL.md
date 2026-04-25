---
name: pr-review
description: Use esta skill ao revisar um pull request por numero ou link. Analisa todas as mudancas implementadas, avalia riscos, qualidade de codigo, testes ausentes, seguranca, performance e boas praticas, e comenta de forma descritiva nos pontos encontrados.
---

# PR Review

## Objetivo

Use esta skill para fazer uma revisao tecnica completa de um pull request
existente, dado um numero de PR, link ou identificador equivalente.

O padrao obrigatorio e:

- Analisar todas as mudancas do PR, nao apenas o resumo.
- Priorizar bugs, regressoes, riscos de seguranca, problemas de performance,
  falta de testes e violacoes de boas praticas do projeto.
- Comentar nos pontos encontrados com explicacao clara, impacto e sugestao
  acionavel.
- Evitar comentarios especulativos quando nao houver evidencia suficiente.

## Fluxo

1. Identifique o repositorio, numero do PR, branch base e branch head:
   - Para links GitHub, extraia `owner/repo` e numero do PR.
   - Para numero simples, use o repositorio atual quando houver contexto local.
   - Se o repositorio nao puder ser inferido com seguranca, pare e peca o link
     completo.
2. Busque metadados, descricao, commits, arquivos alterados e diff completo do
   PR usando a ferramenta disponivel: GitHub app, `gh pr view`, `gh pr diff` ou
   equivalente.
3. Leia comentarios e revisoes existentes para evitar duplicar achados ja
   resolvidos ou ja reportados.
4. Se houver acesso ao checkout local, compare base e head:
   `git fetch`, `git diff --stat <base>...<head>`,
   `git diff --name-status <base>...<head>` e leituras focadas dos arquivos
   afetados.
5. Entenda o comportamento pretendido pelo titulo, descricao, issues
   relacionadas e testes alterados.
6. Revise cada arquivo alterado considerando:
   - Correcao funcional e regressoes.
   - Compatibilidade de API, banco, contratos, migrations e configuracoes.
   - Seguranca: autorizacao, autenticacao, vazamento de dados, injecao,
     criptografia, segredos e validacao de entrada.
   - Performance: consultas, loops, memoizacao, concorrencia, I/O, caching,
     renderizacao e tamanho de payload.
   - Qualidade: simplicidade, coesao, duplicacao, tratamento de erros,
     legibilidade, tipagem e aderencia aos padroes locais.
   - Testes: casos felizes, erros, limites, regressoes, integracao, snapshot,
     fixtures, mocks e cobertura das areas de risco.
7. Quando o PR puder ser executado localmente, rode validacoes proporcionais ao
   risco e aos comandos declarados no projeto. Se nao executar testes, explique
   a limitacao no resumo final.
8. Classifique os achados por severidade antes de comentar:
   - `blocker`: bug critico, falha de seguranca, perda de dados ou quebra clara
     que deve impedir merge.
   - `major`: regressao provavel, falta de teste em area critica, problema de
     performance relevante ou contrato quebrado.
   - `minor`: melhoria objetiva de manutencao, clareza ou cobertura com baixo
     risco.
   - `nit`: detalhe pequeno e opcional. Use raramente.
9. Publique comentarios inline nos trechos exatos quando a ferramenta permitir.
   Use comentario geral apenas para achados que atravessam varios arquivos ou
   quando nao houver linha adequada no diff.
10. Envie uma revisao consolidada com a decisao adequada:
    - `REQUEST_CHANGES` quando houver `blocker` ou `major` que deve impedir
      merge.
    - `COMMENT` quando houver observacoes sem bloqueio.
    - `APPROVE` somente se a revisao estiver completa e nao houver achados
      relevantes.

## Padrao Dos Comentarios

Cada comentario deve ser especifico e verificavel. Use este formato como guia,
sem tornar o texto mecanico:

```markdown
**Severidade:** major

Este trecho pode permitir que usuarios sem permissao acessem dados de outro
tenant porque a consulta filtra apenas por `id`, mas nao por `tenant_id`.

Impacto: um usuario autenticado poderia ler ou atualizar registros fora do seu
escopo.

Sugestao: inclua `tenant_id` no predicado e adicione um teste que tente acessar
um registro de outro tenant.
```

Regras:

- Aponte a linha, condicao ou fluxo que sustenta o achado.
- Explique o impacto pratico para usuario, sistema, seguranca ou manutencao.
- Sugira uma correcao concreta quando houver um caminho claro.
- Diferencie certeza de hipotese. Para incerteza, escreva como pergunta
  objetiva e diga qual evidencia resolveria.
- Nao comente estilo pessoal, preferencias sem base no projeto ou refactors
  amplos que nao sejam necessarios para o PR.
- Nao aprove PR com testes ausentes em area critica sem registrar o risco.

## Checklist De Revisao

Antes de finalizar, confirme:

- Todos os arquivos alterados foram lidos ou justificados como gerados/vendor.
- O diff foi analisado contra a base correta.
- Comentarios existentes foram considerados para evitar duplicidade.
- Achados tem severidade, impacto e sugestao.
- Falta de testes foi apontada nos locais de maior risco.
- A decisao final combina com a gravidade dos achados.

## Resposta Ao Usuario

Depois de revisar e comentar o PR, responda de forma curta com:

- Link/numero do PR revisado.
- Resultado da revisao: aprovado, comentado ou mudancas solicitadas.
- Quantidade de comentarios publicados por severidade.
- Validacoes executadas ou motivo para nao executar.
- Principais riscos restantes, se houver.
