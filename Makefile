

all: up

up:
	sudo service docker restart
	sudo docker-compose -f ./srcs/docker-compose.yml up --build 

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down

clean:
	sudo docker system prune -af
	sudo docker volume prune -f

fclean: clean

re: fclean all

.PHONY: all up clean fclean re
