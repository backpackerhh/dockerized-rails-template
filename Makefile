APP_ENV := development
DB_NAME := my_new_app_$(APP_ENV) # FIXME: use desired database name
DB_USER := postgres
STEPS := 1
TEST_PATH := spec
PORT := 3000
WORKDIR := /usr/app

export PORT
export WORKDIR

db-connect:
	@docker compose exec db psql -U $(DB_USER) -d $(DB_NAME)

db-create:
	@docker compose exec app bundle exec rails db:create

db-generate-migration:
	@docker compose exec app bundle exec rails g migration $(NAME)

db-migrate:
	@docker compose exec app bundle exec rails db:migrate RAILS_ENV=$(APP_ENV)

db-rollback:
	@docker compose exec app bundle exec rails db:rollback RAILS_ENV=$(APP_ENV) STEP=$(STEPS)

restart-server:
	@docker compose exec app bundle exec rails restart

start:
	@docker compose up -d $(SERVICES)

start-build:
	@docker compose up --build -d $(SERVICES)

stop:
	@docker compose stop

restart:
	make stop
	make start

restart-build:
	make stop
	make start-build

destroy:
	@docker compose down

install:
	@docker compose exec app bundle install

console:
	@docker compose exec app bundle exec rails console -e $(APP_ENV)

routes:
	@docker compose exec app bundle exec rails routes

test:
	@docker compose exec app bundle exec rspec ${TEST_PATH}

lint:
	@docker compose exec app bundle exec rubocop

logs:
	@docker compose logs $(SERVICE) -f

# Do not run from integrated terminal in VSCodium
# control + p, control + q for ending the debugging session
debug:
	@docker attach $$(docker compose ps -q app)
