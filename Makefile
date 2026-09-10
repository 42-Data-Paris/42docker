USER = $(shell echo $$USER)
DIR_PATH = $(shell pwd)

all: make

make:
	mkdir -p $(DIR_PATH)/data
	chmod 777 $(DIR_PATH)/data
	docker build --build-arg USER=$(USER) -t 42data .
	docker run -it -v $(DIR_PATH)/data:/home/$(USER)/data 42data:latest

stop:
	docker container prune -f
	docker rmi -f 42data:latest

fclean: stop
	rm -rf data

