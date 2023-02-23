

all: up

up:
	
	sudo docker-compose -f ./srcs/docker-compose.yml up --build 

clean:
	sudo docker system prune -af

fclean: clean
