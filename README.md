# Mossutställningar

## Setup
1. Install [Postgres](http://postgresapp.com/) if you don't have it already.
Create a development and test database, and quit psql:

        $psql
        CREATE DATABASE <database_development>;
        CREATE DATABASE <database_test>;
        \q

2. Create a .env file

        touch .env

3. Populate .env file with these variables

        DB_USERNAME=<username>
        DB_PASSWORD=<password>
        DB_DATABASE_DEV=<database_development>
        DB_DATABASE_TEST=<database_test>

4. Install gems `bundle install`
5. Migrate database `rake db:migrate`
6. Setup test database `rake db:test:setup`

## Commands you probably need
Start server:

    foreman start

Run console:

    foreman run rails console

Run tests:

    foreman run rake

## Contributing
Feel free to contribute with [pull requests](https://help.github.com/articles/using-pull-requests)!
