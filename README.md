# Dockerized Rails template

This template aims to create a simple Rails application with Docker, testing tools and linter already configured.

Especially intended for coding challenges.

## Up and running

Add database configuration:

```bash
$ cp config/database.yml{.sample,}
```

Change the database name for **development** and **test** environments. Look for the *FIXME* comments inside that file.

Specify the same database name as the default value of `DB_NAME` in `Makefile`, keeping the environment as suffix.

In `docker-compose.yml` file, specify the desired image name.

Add `.ruby-version` file with the desired version.

### Commands

The first time you will need to build the application:

```bash
$ make start-build [SERVICES="<whitespace-separated services>"] [WORKDIR="<absolute path>"] [PORT=<port>]
```

Examples:

```bash
$ make start-build
$ make start-build SERVICES="app db"
$ make start-build WORKDIR=/rails
$ make start-build PORT=3001
```

Combine options as needed.

The server will be running on port 3000 by default, unless otherwise specified.

Start containers without building them:

```bash
$ make start [PORT=<port>]
```

Restart containers:

```bash
$ make restart-build [PORT=<port>]
$ make restart [PORT=<port>]
```

Stop containers:

```bash
$ make stop
```

Destroy containers:

```bash
$ make destroy
```

Restart server without restarting containers:

```bash
$ make restart-server
```

Check `Makefile` for other useful commands.

## Application

The application has been generated using latest Rails version at the moment of writing. I'll try to keep it updated as new versions are released.

The same goes for Ruby.

Ensure you use the same version in `.ruby-version` file and the `RUBY_VERSION` argument in every Dockerfile.

The application was generated with following command:

```bash
$ docker compose exec app bundle exec rails new . --database postgresql --skip-git --skip-keeps --skip-asset-pipeline --skip-turbolinks --skip-test --skip-system-test --skip-spring --skip-bootsnap --skip-jbuilder --skip-javascript
```

If you need an only API application, configure it accordingly. Follow the [official documentation](https://guides.rubyonrails.org/api_app.html#changing-an-existing-application).

Note that you could remove any directory or file that you know you won't need.

## Database

This code assumes Postgres is used. In case you prefer to use another database, change the configuration accordingly.

Run following command:

```bash
$ docker compose exec app rails db:system:change --to=<new database>
```

Change it manually in other Dockerfiles.

More details [here](https://gorails.com/episodes/rails-6-db-system-change-command).

## Testing

[RSpec](https://github.com/rspec/rspec-rails) is the testing framework of choice.

Check the configuration in following files to adapt it if necessary:

* `.rspec`
* `spec/rails_helper.rb`
* `spec/spec_helper.rb`

[FactoryBot](https://github.com/thoughtbot/factory_bot_rails) is used instead of fixtures.

[Database Cleaner Adapter for ActiveRecord](https://github.com/DatabaseCleaner/database_cleaner-active_record) is used to clean the database after running the test suite. For that, you need to specify the type `database`.

Example:

```bash
RSpec.describe "Create user", type: %i[request database] do
  # omitted
end
```

## Linter

[RuboCop](https://github.com/rubocop/rubocop) is the linter of choice.

Check the configuration in `.rubocop.yml` file to adapt it if necessary.

## Possible improvements

A non-root user is configured to run the application. To be able to successfully add new gems to the project, the owner of the Bundler path, defined in every `Dockerfile`, is changed in the final stage of the build process. Notice that that process is quite slow at this moment.
