APP_ENV := development
DB_NAME := my_new_app_$(APP_ENV) # FIXME: use desired database name
DB_USER := postgres
STEPS := 1
PORT := 3000

db-connect:
	@docker compose exec db psql -U $(DB_USER) -d $(DB_NAME)

start:
	@docker compose up --build -d $(SERVICES)

stop:
	@docker compose stop

restart:
	make stop
	make start

destroy:
	@docker compose down

install:
	@docker compose exec app bundle install

lint:
	@docker compose exec app bundle exec rubocop

logs:
	@docker compose logs $(SERVICE) -f

# Do not run from integrated terminal in VSCodium
# control + p, control + q for ending the debugging session
debug:
	@docker attach $$(docker compose ps -q app)
