# syntax=docker/dockerfile:1
FROM ruby:3.2.2-slim

# --- Instala dependências essenciais ---
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        libpq-dev \
        nodejs \
        npm \
        curl \
        sed \
    && rm -rf /var/lib/apt/lists/*

# --- Define diretório de trabalho ---
WORKDIR /rails_app

# --- Instala bundler ---
RUN gem install bundler

# --- Copia Gemfile e Gemfile.lock e instala gems ---
COPY meu_app/Gemfile meu_app/Gemfile.lock ./
RUN bundle install

# --- Copia restante do projeto ---
COPY ./meu_app .

# --- Corrige quebras de linha do Windows nos executáveis ---
RUN sed -i 's/\r$//' bin/rails bin/rake

# --- Define variáveis de ambiente para o banco ---
ARG DATABASE_HOST=db_build_fake
ARG DATABASE_USER=user_fake
ARG DATABASE_PASSWORD=pw_fake
ENV DATABASE_HOST=$DATABASE_HOST
ENV DATABASE_USER=$DATABASE_USER
ENV DATABASE_PASSWORD=$DATABASE_PASSWORD

# --- Compila SCSS do Bootstrap ---
RUN bin/rails dartsass:build

# --- Expõe porta ---
EXPOSE 3000

# --- Comando padrão para rodar o Rails ---
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
