# Nginx | PHP | MySQL on Docker Compose <!-- omit in toc --> 
This project helps your Wordpress theme/plugin development.

## Prerequisites
- [Composer](https://getcomposer.org/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com/)

---

### 日本語をお探しですか？ <!-- omit in toc --> 
日本語をご利用の方は、こちらのREADMEをお読みください->[README_ja](README_ja.md)

---

## Overview
### Features
- [x] Automated Wordpress installation with roots/bedrock
- [x] Latest Wordpress, PHP, Nginx available 
- [ ] roots/sage theme developing support
- [ ] Edit only 1 file
- [ ] SSL support?

### Project structure
```
├── .env
├── Dockerfile
├── bedrock
├── config
│   ├── nginx
│   │   ├── default.conf
│   │   └── default.template.conf
│   └── php
│       └── php.ini
├── data
├──
└── docker-compose.yml
```

- `.env` store docker environment variables.
- `Dockerfile` is written php-fpm build script.
- `bedrock` is roots/bedrock. This helps automated Wordpress installation.
- `config` store conf, ini.
- `data` store datas. Usually include mysql data.
- `docker-compose.yml` is written docker containers.

## Contents <!-- omit in toc --> 
- [Prerequisites](#prerequisites)
- [Overview](#overview)
  - [Features](#features)
  - [Project structure](#project-structure)
- [Installation](#installation)
  - [Clone the template](#clone-the-template)
  - [Install bedrock](#install-bedrock)
  - [Configure env file](#configure-env-file)
  - [Configure Bedrock env file](#configure-bedrock-env-file)
  - [Test and verify your Wordpress is running](#test-and-verify-your-wordpress-is-running)
- [Credits](#credits)
- [Improve us](#improve-us)

## Installation
### Clone the template

Clone the repository
```
git clone https://github.com/rikusen0335/bedrock-nginx-docker-compose.git
```


### Install bedrock

This will install bedrock on your project root directory
```
composer create-project roots/bedrock bedrock
```


### Configure env file

Open `.env` file and edit like:
```bash
#!/usr/bin/env bash

# See https://docs.docker.com/compose/environment-variables/#the-env-file

# Specify versions

NGINX_VERSION=alpine
# alpineが軽いっぽい？

MYSQL_VERSION=5.7.28
# caching_sha2_password問題があるため、5.7にしている

# Nginx
NGINX_HOST=localhost # <--- Change to your ip (on local this could be `localhost`)

# MySQL (Change these value (Optional))
MYSQL_HOST=mysql
MYSQL_DATABASE=test
MYSQL_ROOT_USER=root
MYSQL_ROOT_PASSWORD=root
MYSQL_USER=dev
MYSQL_PASSWORD=dev
```

### Configure Bedrock env file

Open `bedrock/.env` and edit like below, and generate your keys.
If you changed db user, password, then also change these.
```bash
DB_NAME=test
DB_USER=dev
DB_PASSWORD=dev

# Optionally, you can use a data source name (DSN)
# When using a DSN, you can remove the DB_NAME, DB_USER, DB_PASSWORD, and DB_HOST variables
# DATABASE_URL=mysql://database_user:database_password@database_host:database_port/database_name

# Optional variables
DB_HOST=mysql
# DB_PREFIX=wp_

WP_ENV=development
WP_HOME=http://localhost:8000 # <--- Change this if you fix the ip.
WP_SITEURL=${WP_HOME}/wp

# Generate your keys here: https://roots.io/salts.html
AUTH_KEY='generateme'
SECURE_AUTH_KEY='generateme'
LOGGED_IN_KEY='generateme'
NONCE_KEY='generateme'
AUTH_SALT='generateme'
SECURE_AUTH_SALT='generateme'
LOGGED_IN_SALT='generateme'
NONCE_SALT='generateme'
```

### Test and verify your Wordpress is running

Do `docker-compose up` and you are good to go!
Initial build may take a long time.

## Credits
### Special thanks <!-- omit in toc --> 
I reffered to [docker-nginx-php-mysql](https://github.com/nanoninja/docker-nginx-php-mysql).
Thanks @nanoninja!

## Improve us
We're taking any feedback! Please send it to my [Twitter](https://twitter.com/RikuS3n) or any contact.