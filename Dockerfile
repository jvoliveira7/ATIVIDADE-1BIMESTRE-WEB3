# Use a imagem oficial do Ruby
FROM ruby:3.2.2

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm

# Define o diretório de trabalho
WORKDIR /rails_app

# Instala o Bundler
RUN gem install bundler

# Copia o Gemfile para o container e instala as gems
COPY meu_app/Gemfile meu_app/Gemfile.lock ./
RUN bundle install

# Copia o resto do código da aplicação
COPY ./meu_app .

# Expõe a porta 3000 para ser acessada de fora
EXPOSE 3000

# Comando principal para iniciar o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]