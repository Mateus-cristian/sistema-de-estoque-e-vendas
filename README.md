# Sistema de Estoque e Vendas

![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-7.2.2.2-red?logo=rubyonrails)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.x-38bdf8?logo=tailwindcss)
![DaisyUI](https://img.shields.io/badge/DaisyUI-5.x-ff69b4?logo=daisyui)
![Devise](https://img.shields.io/badge/Devise-authentication-blueviolet)
![Pundit](https://img.shields.io/badge/Pundit-authorization-orange)
![RSpec](https://img.shields.io/badge/RSpec-tests-ff69b4)

## ✨ Sobre o Projeto

O **Sistema de Estoque e Vendas** é uma aplicação web moderna para controle de produtos, vendas e relatórios, com autenticação, autorização e interface responsiva. Ideal para pequenas e médias empresas que desejam gerenciar seu estoque e fluxo de vendas de forma eficiente.

---

## 🚀 Funcionalidades

- Cadastro, edição e remoção de produtos
- Registro e histórico de vendas
- Relatórios administrativos (vendas, estoque baixo)
- Autenticação de usuários (Devise)
- Controle de permissões (Pundit)
- Interface responsiva com Tailwind CSS + DaisyUI
- Notificações e feedback visual (Turbo, Toast)
- Suporte a múltiplos papéis de usuário (admin, usuário comum)
- Testes automatizados com RSpec

---

## 🖥️ Tecnologias Utilizadas

- **Ruby on Rails 7.2**
- **PostgreSQL**
- **Tailwind CSS 4.x** + **DaisyUI**
- **Devise** (autenticação)
- **Pundit** (autorização)
- **Turbo/Hotwire** (atualizações dinâmicas)
- **RSpec** (testes)
- **Docker** e **docker-compose** (opcional)

---

## ⚡ Instalação e Uso

### Pré-requisitos

- Ruby 3.2.4
- Node.js e Yarn
- PostgreSQL 15+
- Docker (opcional)

### Passos

1. **Clone o repositório**

   ```sh
   git clone https://github.com/seu-usuario/sistema-de-estoque-e-vendas.git
   cd sistema-de-estoque-e-vendas
   ```

2. **Instale as dependências**

   ```sh
   bundle install
   yarn install
   ```

3. **Configure o banco de dados**

   - Copie e ajuste `.env` se necessário.
   - Crie e migre o banco:
     ```sh
     bin/rails db:setup
     ```

4. **Compile os assets**

   ```sh
   yarn build:css
   ```

5. **Inicie o servidor**

   ```sh
   ./bin/dev
   ```

   Ou, para produção:

   ```sh
   RAILS_ENV=production bin/rails assets:precompile
   RAILS_ENV=production bin/rails db:migrate
   RAILS_ENV=production bin/rails server
   ```

6. **Acesse**
   - [http://localhost:3000](http://localhost:3000)

---

## 🧑‍💻 Usuário Admin de Teste

Para criar um usuário admin de teste no ambiente de desenvolvimento, rode manualmente o comando de seed após configurar o banco:

```sh
bin/rails db:seed
```

Isso irá criar (caso não exista) um usuário admin padrão:

- **Email:** user.admin@uorak.com
- **Senha:** @123password

---

## 📝 Testes

Execute a suíte de testes com:

```sh
bundle exec rspec
```

---

## 📦 Docker

Para rodar com Docker:

```sh
docker-compose up --build
```

---

## 📁 Estrutura do Projeto

- [`app`](app) - Código principal da aplicação Rails
- [`app/views`](app/views) - Templates das páginas
- [`app/assets/stylesheets`](app/assets/stylesheets) - CSS (Tailwind)
- [`app/javascript`](app/javascript) - JS (Stimulus, Turbo)
- [`spec`](spec) - Testes automatizados (RSpec)
- [`db`](db) - Migrations e seeds
- [`config`](config) - Configurações do Rails

---

## 📄 Licença

Este projeto está sob a licença MIT.

---

> Feito com ❤️
