test:
	sudo docker image rm testimage -f
	sudo docker build -t testimage .
	sudo docker run -t -p 3306:3306 testimage
