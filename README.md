# README

Projeto para iniciar uma aplicação ruby on rails cpm postgresql

1. Faça o cline do projeto
   git clone https://github.com/jhonattasantos/start-project-rails.git project-name
2. Entre no diretorio
   cd project-name
3. Rode os comando abaixo:

- make create-api (Vai ser criado o projeto rails no diretorio rails-api)
- `sudo chown -R $USER:$USER rails-api` (Se tiver no linux terá que dá permissao no diretorio)
- make build (Baixar as dependencias do Gemfile)

configurar a conexao com o postgres

```
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: root
  password: root
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test
```

- make dev (subir o projeto)
- make db-create (criar a base de dados)

Acessar localhost:3000
