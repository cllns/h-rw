require "bundler/setup"
require "hanami/setup"
require "hanami/model"
require_relative "../lib/real_world"
require_relative "../apps/api/application"

Hanami.configure do
  mount Api::Application, at: "/"

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/real_world_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/real_world_development'
    #    adapter :sql, 'mysql://localhost/real_world_development'
    #
    adapter :sql, ENV.fetch("DATABASE_URL")

    ##
    # Migrations
    #
    migrations "db/migrations"
    schema     "db/schema.sql"
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch("SMTP_HOST"), port: ENV.fetch("SMTP_PORT")
    end
  end
end
