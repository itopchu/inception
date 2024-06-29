all:
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re: clean all

clean fclean:
	@docker stop $$(docker ps -qa) > /dev/null 2>&1; \
	docker rm $$(docker ps -qa) > /dev/null 2>&1; \
	docker rmi -f $$(docker images -qa) > /dev/null 2>&1; \
	docker volume rm $$(docker volume ls -q) > /dev/null 2>&1; \
	docker network rm $$(docker network ls -q) > /dev/null 2>&1; \
	sudo rm -rf $(HOME)/data/wordpress; \
	sudo rm -rf $(HOME)/data/mariadb; \

.PHONY: all re down clean fclean
