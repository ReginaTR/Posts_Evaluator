# Posts Evaluator API

API RESTful desenvolvida com Ruby on Rails, PostgreSQL e RSpec, para criação e avaliação de posts.

## Metodologias Ágeis
Este projeto segue a metodologia ágil, utilizando o **Kanban** para gerenciar o fluxo de trabalho e **Issues** para acompanhar o progresso das tarefas. Abaixo estão os links para as respectivas páginas:
- **Kanban**: [Link para o Kanban do projeto](https://github.com/users/ReginaTR/projects/10)
- **Issues**: [Link para as Issues do GitHub](https://github.com/ReginaTR/Posts_Evaluator/issues?q=is%3Aissue%20state%3Aclosed)

##  Configuração Inicial

### Requisitos

- Ruby (>= 3.3.1)
- Rails (~> 8.0.2)
- PostgreSQL
- Bundler
- Sidekiq
- Redis
- Rspec

### Gems utilizadas

- gem "factory_bot_rails"
- gem "rubocop"
- gem "sidekiq"
- gem "faker"
- gem "shoulda-matchers"

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/posts-evaluator-api.git
cd posts-evaluator-api
```
2. Instale as dependências:
```bash
bundle install
```
3. Configure o banco de dados:

Crie um arquivo .env com as variáveis de ambiente necessárias:

```bash
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```
4. Crie e configure o banco de dados:
```bash
rails db:create db:migrate
```
5. Excecute os testes:

```bash
bundle exec rspec
```

6. Execute o lint do Rubocop:
```bash
bundle exec rubocop
```

## Funcionalidades

### 1. Criação de Posts

Cria um novo post associado a um usuário (identificado por login). Se o usuário ainda não existir, ele é criado automaticamente.

#### Parâmetros esperados:

```json
{
  "login": "user_login",
  "title": "My post",
  "body": "This is my post.",
  "ip": "192.168.0.1"
}
```

#### Resposta de sucesso (201 Created):

```json
{
  "user": {
    "id": 1,
    "login": "user_login"
  },
  "post": {
    "id": 1,
    "title": "My post",
    "body": "This is my post.",
    "ip": "192.168.0.1",
    "user_id": 1
  }
}
```
#### Resposta de erro (422 Unprocessable Entity):

```json
{
  "errors": [
    "Title can't be blank",
    "Body can't be blank"
  ]
}
```

### 2. Criação de Ratings

Permite que um usuário avalie um post. Um usuário só pode avaliar um post uma vez. A resposta inclui a média das avaliações do post.

#### Parâmetros esperados:

```json
{
  "post_id": 1,
  "user_id": 2,
  "value": 4
}
```
#### Resposta de sucesso (200 OK):
```json
{
  "post": {
    "id": 1,
    "title": "My post",
    "body": "This is my post.",
    "ip": "192.168.0.1",
    "user_id": 1
  },
  "rating": {
    "user_id": 2,
    "value": 4
  },
  "average_rating": 4.2
}
```
#### Resposta de erro (422 Unprocessable Entity):

```json
{
  "errors": [
    "Value must be between 1 and 5",
    "User has already rated this post"
  ]
}
```

### 3. Obter os N Melhores Posts por Média de Avaliação
Retorna os top posts com a maior média de avaliações.

#### Parâmetros esperados:
```json
{
  "limit": 10
}
```
#### Resposta de sucesso (200 OK):

[
  {
    "id": 1,
    "title": "My first post",
    "body": "This is a great post!",
    "average_rating": 4.8
  },
  {
    "id": 2,
    "title": "My second post",
    "body": "Another great post!",
    "average_rating": 4.7
  }
]
### 4. Obter Lista de IPs Utilizados por Diferentes Autores
Retorna uma lista de IPs utilizados para criar posts, junto com os logins dos usuários que usaram cada IP.

#### Resposta de sucesso (200 OK)
```json
[
  {
    "ip": "192.168.0.1",
    "logins": ["user1", "user2"]
  },
  {
    "ip": "192.168.0.2",
    "logins": ["user3"]
  }
]
```

### 5. Criar script de seeds com dados realista
A aplicação inclui um script de seeds.rb responsável por popular o banco de dados com dados consistentes e realistas.

#### Descrição:

- Cria 100 usuários com logins únicos.

- Gera 200.000 posts, distribuídos entre os usuários, com aproximadamente 50 IPs únicos.

- Cerca de 75% dos posts recebem ratings (avaliações).

- Cada usuário avalia um post no máximo uma vez, com valores entre 1 e 5.

- O processo é realizado de forma assíncrona utilizando Sidekiq, garantindo performance e não bloqueando a aplicação.

#### Execução:

Inicie o servidor Rails:
```bash
rails server
```
Inicie o redis (em outro terminal):
```bash
redis-server
```
Inicie o Sidekiq (em outro terminal, dentro do projeto):
```bash
bundle exec sidekiq
```
Execute o seed (no terminal principal do projeto):
```bash
rails db:seed
```
#### Para validação no console:

```bash
User.count            # Deve retornar 100
Post.count            # Deve retornar cerca de 200_000
Rating.count          # Aproximadamente 75% dos posts devem ter avaliações

Post.first.ratings    # Ver avaliações do primeiro post
User.first.posts      # Ver posts criados por um usuário
```
## Considerações Finais

Este projeto foi desenvolvido com foco em boas práticas, testes automatizados e estrutura escalável.
O mesmo abrange uso de APIs com Rails, processamento assíncrono com Sidekiq e simulação de dados em larga escala.