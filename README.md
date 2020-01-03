# 'Docker + Rails + Mysql' development environment

# Features

'Docker + Rails + Mysql' development environment templated.

# Requirement

* Ruby 2.6.5
* Rails 5.2.4
* Mysql 5.7

# Installation

Install Docker and docker-compose from the [official site](https://docs.docker.com/compose/install/).

## Setup

```bash
$ git clone git@github.com:yusei-hyodo/docker-rails-dev.git
$ mv rails-docker-temp 'app name' # name change
$ cd 'app name'
$ docker-compose build
$ docker-compose run --rm app bundle update
$ docker-compose run --rm app bundle install
$ docker-compose up -d
$ docker-compose exec app bundle exec rails db:create
$ docker-compose ps
```

Check if processes rails(app), mysql(db), and are running.
```bash
         Name               Command               State                 Ports              
---------------------------------------------------------------------------------------------------
'app name'_app_1   /bin/sh -c rm -f tmp/pids/ ...   Up      0.0.0.0:3000->3000/tcp           
'app name'_db_1    docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp, 33060/tcp
```

Access [localhost:3000](https://localhost:3000)

# Author
 
* Yusei Hyodo
* Twitter : [@yusei_hyodo](https://twitter.com/yusei_hyodo)
* Blog : [ブログ処ひょうどう](https://hyodoblog.com)
 
# License
 
'docker-rails-dev' is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
 
Enjoy rails app development

Thank you!