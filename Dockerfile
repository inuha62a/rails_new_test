#Rubyの2.7.5を使用
FROM ruby:3.4.1

# 必要なライブラリをインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  # nodejsとyarnをインストールするために必要なライブラリのアップデート関連
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn # nodejsとyarnをインストール

# 今回は作業ディレクトリを/appとする
WORKDIR /app

# ローカルの./src（railsのソースコードを入れる場所）以下のソースコードを/app配下にコピー
COPY ./src /app

# RubyのGemfileを一括インストール
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
