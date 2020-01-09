# DockerHubのイメージ
FROM ruby:2.6.5

# 更新・必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
    libssl-dev \
    libpq-dev \
    nodejs \
    cron \
    vim

# 環境変数の設定
ENV APP_ROOT /app

# 作業ディレクトリの作成、設定
RUN mkdir $APP_ROOT 
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

ADD . $APP_ROOT

CMD /bin/sh -c "rm -f tmp/pids/server.pid && cron && bundle exec rails s -p 8080 -b '0.0.0.0'"