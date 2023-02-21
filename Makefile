D_COMPOSE=docker-compose
D_EXEC=docker exec -it
D_SERVICE_FPM=magento-phpfpm

build:
	$(D_COMPOSE) build
	docker build -f php/7.4/Dockerfile --tag=dev ./php/7.4/

up:
	$(D_COMPOSE) up -d

down:
	$(D_COMPOSE) down

up-full: up
	time $(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh

planes-full:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh planes-full

planes-static:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh planes-static

fullprice-static:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh fullprice-static

fullprice-full:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh fullprice-full

static:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh frontend

compile:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh compile

cache:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh cache

logs:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh logs

reindex:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh reindex

stats: up
	docker stats

test:
	$(D_EXEC) $(D_SERVICE_FPM) vendor/bin/phpunit

compile-partial:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh upgrade
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh compile

stats: up
	docker stats
	
into-container:
	$(D_EXEC) $(D_SERVICE_FPM) fish

cron:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh cron
