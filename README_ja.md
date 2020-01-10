# Nginx | PHP | MySQL on Docker Compose <!-- omit in toc --> 
あなたのWordpressプラグイン/テーマの開発を助けるプロジェクト。

## 必要パッケージ
- [Composer](https://getcomposer.org/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com/)

---

## 概要
### 機能
- [x] 自動でWordpressをインストール
- [x] 最新のWordpress、PHP、Nginxを利用可能
- [ ] roots/sageを使ったテーマ開発のサポート
- [ ] 1ファイルを編集するだけ！
- [ ] SSLサポート？

### プロジェクトの構造
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

- `.env`はdockerの変数を格納しています。
- `Dockerfile`はphp-fpm用のビルドスクリプトが書かれています。
- `bedrock`はroots/bedrockのディレクトリです。これがWordpressの自動インストールを助けてくれます。
- `config`はconfやiniを格納しています。
- `data`はデータを格納しています。基本は、MySQLのデータしか格納していません。
- `docker-compose.yml`はdockerのコンテナが書かれています。

## 目次 <!-- omit in toc --> 
- [必要パッケージ](#%e5%bf%85%e8%a6%81%e3%83%91%e3%83%83%e3%82%b1%e3%83%bc%e3%82%b8)
- [概要](#%e6%a6%82%e8%a6%81)
  - [機能](#%e6%a9%9f%e8%83%bd)
  - [プロジェクトの構造](#%e3%83%97%e3%83%ad%e3%82%b8%e3%82%a7%e3%82%af%e3%83%88%e3%81%ae%e6%a7%8b%e9%80%a0)
- [インストール](#%e3%82%a4%e3%83%b3%e3%82%b9%e3%83%88%e3%83%bc%e3%83%ab)
  - [テンプレートをクローン](#%e3%83%86%e3%83%b3%e3%83%97%e3%83%ac%e3%83%bc%e3%83%88%e3%82%92%e3%82%af%e3%83%ad%e3%83%bc%e3%83%b3)
  - [bedrockをインストール](#bedrock%e3%82%92%e3%82%a4%e3%83%b3%e3%82%b9%e3%83%88%e3%83%bc%e3%83%ab)
  - [envファイルを設定](#env%e3%83%95%e3%82%a1%e3%82%a4%e3%83%ab%e3%82%92%e8%a8%ad%e5%ae%9a)
  - [Bedrockのenvファイルを設定](#bedrock%e3%81%aeenv%e3%83%95%e3%82%a1%e3%82%a4%e3%83%ab%e3%82%92%e8%a8%ad%e5%ae%9a)
  - [Wordpressがきちんと動作しているか、テスト・確認](#wordpress%e3%81%8c%e3%81%8d%e3%81%a1%e3%82%93%e3%81%a8%e5%8b%95%e4%bd%9c%e3%81%97%e3%81%a6%e3%81%84%e3%82%8b%e3%81%8b%e3%83%86%e3%82%b9%e3%83%88%e3%83%bb%e7%a2%ba%e8%aa%8d)
- [クレジット](#%e3%82%af%e3%83%ac%e3%82%b8%e3%83%83%e3%83%88)
- [手伝ってください！](#%e6%89%8b%e4%bc%9d%e3%81%a3%e3%81%a6%e3%81%8f%e3%81%a0%e3%81%95%e3%81%84)

## インストール
### テンプレートをクローン

リポジトリをクローンしてください。
```
git clone https://github.com/rikusen0335/bedrock-nginx-docker-compose.git
```


### bedrockをインストール

このコマンドを使用すると、roots/bedrockをプロジェクトのルートディレクトリにインストールします。
```
composer create-project roots/bedrock bedrock
```


### envファイルを設定

`.env`を開き、下記のように編集してください。
```bash
#!/usr/bin/env bash

# See https://docs.docker.com/compose/environment-variables/#the-env-file

# バージョンを指定

NGINX_VERSION=alpine
# alpineが軽いっぽい？

MYSQL_VERSION=5.7.28
# caching_sha2_password問題があるため、5.7にしている

# Nginx
NGINX_HOST=localhost # <--- IPを変更(任意)(ローカルでプロジェクトを動かす場合、localhostのままが良いです)

# MySQL (編集項目(任意))
MYSQL_HOST=mysql
MYSQL_DATABASE=test
MYSQL_ROOT_USER=root
MYSQL_ROOT_PASSWORD=root
MYSQL_USER=dev
MYSQL_PASSWORD=dev
```

### Bedrockのenvファイルを設定

`bedrock/.env`を開いて、下記のように編集し、キーを書き加えてください。
DBのユーザー、パスワードを変えた場合は、そちらも修正してください。
```bash
DB_NAME=test # <--- 編集
DB_USER=dev # <--- 編集
DB_PASSWORD=dev # <--- 編集

# Optionally, you can use a data source name (DSN)
# When using a DSN, you can remove the DB_NAME, DB_USER, DB_PASSWORD, and DB_HOST variables
# DATABASE_URL=mysql://database_user:database_password@database_host:database_port/database_name

# Optional variables
DB_HOST=mysql # <--- 編集
# DB_PREFIX=wp_

WP_ENV=development
WP_HOME=http://localhost:8000 # <--- 編集
WP_SITEURL=${WP_HOME}/wp

# このサイトでキーを生成してください: https://roots.io/salts.html
AUTH_KEY='generateme'
SECURE_AUTH_KEY='generateme'
LOGGED_IN_KEY='generateme'
NONCE_KEY='generateme'
AUTH_SALT='generateme'
SECURE_AUTH_SALT='generateme'
LOGGED_IN_SALT='generateme'
NONCE_SALT='generateme'
```

### Wordpressがきちんと動作しているか、テスト・確認

Do `docker-compose up` and you are good to go!
Initial build may take a long time.

## クレジット
### ほんまにありがとうございます <!-- omit in toc --> 
[docker-nginx-php-mysql](https://github.com/nanoninja/docker-nginx-php-mysql)を参考にさせていただきました。
@nanoninjaさん、本当にありがとうございます!

## 手伝ってください！
どんなフィードバックでも受け付けています！[Twitter](https://twitter.com/RikuS3n)か、もしくは他の方法で送ってみてください！
