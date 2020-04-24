# ![RealWorld Example App](logo.png)

> ### [Hanami](https://hanamirb.org) codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the [RealWorld](https://github.com/gothinkster/realworld) spec and API.


### [Demo](https://github.com/gothinkster/realworld)&nbsp;&nbsp;&nbsp;&nbsp;[RealWorld](https://github.com/gothinkster/realworld)


This codebase was created to demonstrate a fully fledged fullstack application built with **[Hanami](https://hanamirb.org)** including CRUD operations, authentication, routing, pagination, and more.

We've gone to great lengths to adhere to the **[Hanami](https://hanamirb.org)** community styleguides & best practices.

For more information on how to this works with other frontends/backends, head over to the [RealWorld](https://github.com/gothinkster/realworld) repo.


# How it works

Hanami supports many apps within a single project.
Because this is a simple demo application, we only have one app in `apps/api`.

We could extract isolated sections of business logic into their own apps,
if this were a real project and we needed a place for new functionality.

For more info, [read the Hanami Architecture Guide](http://guides.hanamirb.org/architecture/overview/).


# Getting started

1. Clone this repository

2. Install dependencies

```shell
bundle install
```

3. Prepare (create and migrate) the database for the **development** environment

```shell
 bundle exec hanami db prepare
```

4. Run the server

```shell
bundle exec hanami server
```

Your API server will now be serving from port *2300* at `http://localhost:2300`.


# Tests

This application has strong test coverage, with RSpec.

1. Prepare (create and migrate) the database for the **test** environment

```shell
HANAMI_ENV=test bundle exec hanami db prepare
```

2. Run the entire test suite

```shell
bundle exec rake
```

(You can also run a single spec with `bundle exec rspec` and the path of the spec file)
