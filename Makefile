# Build and run the bot
run:
	docker-compose up --build -d

# Stop and remove all containers
clean:
	docker-compose rm --force --stop -v
	docker-compose -f docker-compose.test.yml rm --force --stop -v

# Run tests
test:
	docker-compose -f docker-compose.test.yml up --build

# Continuously run tests on filesystem changes
tdd:
	while true; do fswatch . --one-event; make test; done

.PHONY: run clean test tdd
