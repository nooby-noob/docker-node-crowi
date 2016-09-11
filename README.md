docker-node-crowi
====


wikiサーバーCrowiを動かせるdockerイメージです。  
Crowiのバージョンは**v1.5.0**です。  
ベースイメージに**node:4.5-slim**を使用しています。

## Supported tags and respective Dockerfile links

- [`v1.5.0` _(v1.5.0/Dockerfile)_](https://github.com/nooby-noob/docker-node-crowi/blob/v1.5.0/Dockerfile)


## Crowiとは

[http://site.crowi.wiki/](http://site.crowi.wiki/)

## 実行に必要なもの

* Docker
* Docker Compose

## インストールと実行

```bash:console
git clone https://github.com/nooby-noob/docker-node-crowi.git
cd docker-node-crowi
docker-compose up
``` 

## 使い方

`docker-compose up`コマンドでcrowiを立ち上げた後、`http://localhost`にアクセスしてください。


## Docker Composeの構成

docker-compose.ymlの内容です。

```yml:docker-compose.yml
version: '2'

services:
    crowi:
        image: noobynoob/docker-node-crowi:v1.5.0
        links:
            - mongo:mogo
            - redis:redis
            - elasticsearch:elasticsearch
        ports:
            - 80:80

    mongo:
        image: mongo

    redis:
        image: redis:alpine
    
    elasticsearch:
        image: elasticsearch
        user: elasticsearch
        ports:
            - 9200:9200
        command:
            - "sh"
            - "-c"
            - "./bin/plugin install analysis-kuromoji; 
               ./bin/plugin install mobz/elasticsearch-head;
               elasticsearch;"
```

Crowiの本体の他にmongodb, redis, elasticsearchのコンテナが起動するようになっています。elasticsearchは起動時のcommandをいじり、elasticsearchが起動する前にpluginのインストールを行うようにしています。

## 環境変数

`docker-entry-point.sh`で環境変数を初期化しています。

```bash
export NODE_ENV=production
export MONGO_URI=${MONGO_URI:-mongodb://mongo:27017/crowi}
export REDIS_URL=${REDIS_URI:-redis://redis:6379/crowi}
export ELASTICSEARCH_URI=${ELASTICSEARCH_URI:-http://elasticsearch:9200/crowi}
```

redisやmongodbのサーバーがすでに用意されている時はDocker Composeを使わずに単体でcrowiを立ち上げてください。

```bash
docker run \
	-e REDIS_URL=redis://REDIS_HOST:REDIS_PORT/path/to/db \
	-e MONGO_URI=mongodb://MONGO_HOST:MONGO_PORT/path/to/db \
	noobynoob/docker-node-crowi:v1.5.0
	
	
```


環境変数の詳細については公式を参考にしてください。  
[https://github.com/crowi/crowi#environment](https://github.com/crowi/crowi#environment)

## Licence

* The MIT License (MIT)
