
# Checklist — Projet SGBD 2026

## Etapa 1 — Organização e planejamento

- [✅] Formar o grupo de 4 integrantes
- [✅] Inscrever o grupo no Moodle
- [✅] Ler e analisar o enunciado específico do projeto
- [✅] Identificar todas as funcionalidades exigidas
- [✅] Dividir as responsabilidades entre os integrantes
- [✅] Escolher o SGBD: PostgreSQL ou MySQL
- [ ] Definir as ferramentas e o ambiente de desenvolvimento

## Etapa 2 — Modelagem conceitual

- [✅] Descrever o contexto e o objetivo da aplicação
- [✅] Identificar as entidades
- [✅] Identificar os atributos de cada entidade
- [✅] Identificar os identificadores das entidades
- [✅] Identificar os relacionamentos entre as entidades
- [✅] Definir as cardinalidades dos relacionamentos
- [✅] Definir as regras de negócio
- [✅] Registrar hipóteses para informações ambíguas ou ausentes
- [✅] Construir o primeiro diagrama entidade-relacionamento
- [✅] Apresentar o diagrama ao professor de TD
- [✅] Enviar o diagrama inicial e os nomes dos integrantes no Moodle
- [✅] Guardar a versão inicial para incluir no relatório final

## Etapa 3 — Modelagem relacional e normalização

- [✅] Converter o modelo entidade-relacionamento em tabelas relacionais
- [✅] Definir as chaves primárias (PK)
- [✅] Definir as chaves estrangeiras (FK)
- [✅] Identificar as dependências funcionais
- [ ] Verificar a 1ª Forma Normal (1FN)
- [ ] Verificar a 2ª Forma Normal (2FN)
- [ ] Verificar a 3ª Forma Normal (3FN)
- [ ] Corrigir possíveis problemas de normalização
- [ ] Definir as restrições de integridade
- [✅] Produzir o esquema relacional final
- [ ] Documentar e justificar alterações em relação ao primeiro modelo

## Etapa 4 — Implementação do banco de dados

- [ ] Configurar PostgreSQL ou MySQL
- [✅] Criar o arquivo `create.sql`
- [✅] Implementar todas as tabelas e seus tipos de dados
- [✅] Implementar PRIMARY KEY e FOREIGN KEY
- [✅] Implementar NOT NULL, UNIQUE e CHECK quando necessários
- [ ] Implementar outras restrições e triggers necessários
- [✅] Criar o arquivo `insert.sql`
- [ ] Inserir dados de teste relevantes e coerentes
- [✅] Criar o arquivo `drop.sql`
- [ ] Testar a criação do banco do zero
- [ ] Testar inserções válidas e inválidas
- [ ] Testar a exclusão e recriação do banco
- [ ] Avaliar índices e outros mecanismos de eficiência

## Etapa 5 — Consultas e operações SQL

- [ ] Listar todas as consultas exigidas pelo enunciado específico
- [ ] Implementar as consultas de dados (SELECT)
- [ ] Implementar as consultas estatísticas (COUNT, SUM, AVG etc., conforme exigido)
- [ ] Implementar operações de inserção (INSERT)
- [ ] Implementar operações de alteração (UPDATE)
- [ ] Implementar operações de exclusão (DELETE)
- [ ] Parametrizar as consultas sempre que possível
- [ ] Criar o arquivo `select.sql`
- [ ] Criar o arquivo `update.sql`
- [ ] Testar todas as consultas e operações
- [ ] Verificar a legibilidade das consultas e resultados
- [ ] Testar a preservação das restrições de integridade

## Etapa 6 — Interface Web

- [ ] Criar o diretório `src`
- [ ] Configurar o ambiente PHP sem framework
- [ ] Implementar a conexão PHP com o banco de dados
- [ ] Criar as páginas de consulta de dados
- [ ] Criar as páginas de estatísticas
- [ ] Criar formulários para inserção de dados
- [ ] Criar formulários para atualização e exclusão
- [ ] Conectar as funcionalidades às consultas SQL
- [ ] Validar os dados recebidos dos formulários
- [ ] Usar consultas preparadas e parametrizadas
- [ ] Adicionar CSS e JavaScript se necessário
- [ ] Testar todas as funcionalidades pela interface
- [ ] Publicar a aplicação na página acadêmica de um integrante
- [ ] Verificar se a URL pública funciona
- [ ] Garantir a disponibilidade da aplicação até o início de janeiro

## Etapa 7 — Relatório e documentação

- [ ] Descrever o contexto da aplicação
- [ ] Documentar entidades, relacionamentos e regras de negócio
- [ ] Incluir o primeiro diagrama entidade-relacionamento
- [ ] Incluir o modelo conceitual final
- [ ] Explicar as mudanças entre os modelos
- [ ] Explicar a transformação para o modelo relacional
- [ ] Apresentar as dependências funcionais
- [ ] Justificar a normalização até a 3FN
- [ ] Documentar as restrições de integridade
- [ ] Descrever a implementação SQL
- [ ] Documentar consultas, estatísticas e atualizações
- [ ] Descrever o ambiente de execução
- [ ] Descrever as interfaces da aplicação
- [ ] Elaborar o manual de utilização
- [ ] Justificar eventuais otimizações e alterações
- [ ] Incluir a URL pública da aplicação
- [ ] Gerar o arquivo `rapport.pdf`
- [ ] Criar `README.md` com instruções de instalação e execução

## Etapa 8 — Testes finais e entrega

- [ ] Verificar que todos os scripts SQL estão presentes
- [ ] Testar os scripts na ordem correta em um banco limpo
- [ ] Verificar que os dados de teste são suficientes
- [ ] Testar todas as funcionalidades da aplicação
- [ ] Testar casos inválidos e restrições de integridade
- [ ] Verificar se o relatório está completo
- [ ] Verificar se o README permite reproduzir a instalação
- [ ] Conferir a URL da aplicação no relatório e no README
- [ ] Criar o pacote de códigos-fonte `.tgz`
- [ ] Montar o ZIP com relatório, README, sql, src e demais arquivos
- [ ] Nomear o ZIP como `NOM1_NOM2_NOM3_NOM4.zip`
- [ ] Testar a extração e a estrutura do ZIP
- [ ] Enviar o arquivo final pelo Moodle dentro do prazo
- [ ] Preparar a apresentação oral (soutenance)
- [ ] Garantir que todos os integrantes dominam o código e o projeto

---

## Estrutura esperada do projeto

```text
NOM1_NOM2_NOM3_NOM4/
├── README.md
├── rapport.pdf
├── sql/
│   ├── create.sql
│   ├── insert.sql
│   ├── select.sql
│   ├── update.sql
│   └── drop.sql
└── src/
    └── ...
```

## Prazos

| Data | Entrega |
|---|---|
| 14/10/2026 | Inscrição do grupo no Moodle |
| 23/10/2026 | Primeiro diagrama entidade-relacionamento |
| 10/12/2026 | Entrega final (confirmar horário exato) |
| Início de janeiro de 2027 | Aplicação deve continuar disponível |

## Divisão de responsabilidades

| Integrante | Responsabilidade principal |
|---|---|
| Pessoa 1 | Modelagem conceitual e relacional |
| Pessoa 2 | Implementação do banco e restrições de integridade |
| Pessoa 3 | Consultas SQL, estatísticas e operações |
| Pessoa 4 | Interface PHP e publicação |
| Todos | Testes, documentação, relatório e apresentação |

> **Observação:** todos os integrantes devem compreender o funcionamento do projeto e dominar o código para a apresentação oral.
