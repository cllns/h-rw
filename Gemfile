source "https://rubygems.org"

gem "rake"
gem "hanami",       "~> 1.3"
gem "hanami-model", "~> 1.3"

gem "sqlite3"

gem "bcrypt"
gem "jwt"

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem "shotgun", platforms: :ruby
  gem "hanami-webconsole"
end

group :test, :development do
  gem "dotenv", "~> 2.4"

  gem "rubocop", "~> 0.68"
  gem "rubocop-performance"
end

group :test do
  gem "rspec"
end

group :production do
  # gem 'puma'
end
