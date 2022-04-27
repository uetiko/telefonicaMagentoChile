D_COMPOSE=docker-compose
D_EXEC=docker exec -it
D_SERVICE_FPM=magento-phpfpm

build:
	$(D_COMPOSE) build

up:
	$(D_COMPOSE) up -d

down:
	$(D_COMPOSE) down

up-full: up
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh planes-full

planes-static:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh planes-static

planes-full:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh planes-full

all-static:
	$(D_EXEC) $(D_SERVICE_FPM) ./deploy-compile.sh frontend



stats: up
	docker stats
