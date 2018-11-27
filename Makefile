.PHONY: default run clean
default: run ;

run:
	docker-compose up --build -d

clean:
	docker-compose rm --force --stop -v
