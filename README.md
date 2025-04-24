# Posts Evaluator API

API RESTful desenvolvida com Ruby on Rails, PostgreSQL e RSpec, para criação e avaliação de posts.

##  Configuração Inicial

### Requisitos

- Ruby (>= 3.3.x)
- Rails (~> 8.0.2)
- PostgreSQL
- Bundler
- Rspec

### Instalação

1. Clone o repositório:

        git clone https://github.com/seu-usuario/posts-evaluator-api.git
        cd posts-evaluator-api
2. Instale as dependências:

        bundle install

3. Configure o banco de dados:

    Crie um arquivo .env com as variáveis de ambiente necessárias: 
        POSTGRES_USER=postgres
        POSTGRES_PASSWORD=postgres

4. Crie e configure o banco de dados:

        rails db:create db:migrate

5. Excecute os testes:

        bundle exec rspec
### Funcionalidades(em construção)





