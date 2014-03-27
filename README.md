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

        SHOW_NAVIGATION_LINES=<true/false>
        SHOW_GHOST=<true/false>
        SHOW_OVERLAY=<true/false>

        # Variables needed in staging & production
        AUTHENTICATE=<true/false>
        HTTP_AUTH_USER=<username>
        HTTP_AUTH_PASS=<password>

        SECRET_TOKEN=<secret token>
        DEVISE_SECRET_KEY=<devise secret token>

        AWS_HOST_NAME=<aws host name>
        AWS_BUCKET=<aws bucket>
        AWS_ACCESS_KEY=<aws access key id>
        AWS_SECRET_ACCESS_KEY=<aws secret access key>

4. Install gems `bundle install`
5. Migrate database `foreman run rake db:migrate`
6. Setup test database `foreman run rake db:test:prepare`
7. [Paperclip](https://github.com/thoughtbot/paperclip) is used for model attachments. It uses [ImageMagick](http://www.imagemagick.org/) as an image processor, so you need to have that installed for working with images. Install with [Homebrew](http://brew.sh/) on Mac OS X:

        brew install imagemagick

## Commands you probably need
Start server:

    foreman start

Migrate database:

    foreman run rake db:migrate

Run console:

    foreman run rails console

Run tests:

    foreman run rake

## Contributing
Feel free to contribute with [pull requests](https://help.github.com/articles/using-pull-requests)!
