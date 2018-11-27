.PHONY: build run

build:
	docker build -t awesomo .

run: build
	docker run awesomo
