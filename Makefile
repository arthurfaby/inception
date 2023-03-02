

all: up

up:
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker system prune -af
	docker volume prune -f
	rm -rf /home/afaby/data/mysql/*
	rm -rf /home/afaby/data/wordpress/*

fclean: clean

re: fclean all

.PHONY: all up down clean fclean re
