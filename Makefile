USER = $(shell echo $$USER)
DIR_PATH = $(shell pwd)

all: make

make:
	docker build --build-arg USER=$(USER) -t 42data .
	docker run -it -v $(DIR_PATH)/data:/home/$(USER)/data 42data:latest

stop:
	docker container prune -f
	docker rmi -f 42data:latest
