

all: up

up:
	mkdir -p /home/afaby/data/mysql
	mkdir -p /home/afaby/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker system prune -af
	docker volume prune -f
	sudo rm -rf /home/afaby/data/mysql/*
	sudo rm -rf /home/afaby/data/wordpress/*

fclean: clean

re: fclean all

.PHONY: all up down clean fclean re
