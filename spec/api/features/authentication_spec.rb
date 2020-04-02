require "spec_helper"
require "rack/test"

RSpec.describe "Authentication", type: :feature do
  include Rack::Test::Methods

  let(:app) { Hanami.app }

  let(:user) do
    UserRepository.new.clear
    UserRepository.new.create(
      email: "test@example.com",
      username: "tester",
      password: "password"
    )
  end

  let(:authorization_token) do
    JWT.encode(
      Hash[
        user_id: user.id,
        iat: Time.now.to_i,
        exp: Time.now.to_i + (60 * 60 * 24 * 7)
      ],
      API_SESSIONS_SECRET,
      "HS512"
    )
  end

  describe "correct Authorization header" do
    before { header "Authorization", "Token #{authorization_token}" }

    it do
      get "/user"
      expect(last_response).to be_ok
    end
  end

  describe "incorrect Authorization header" do
    before { header "Authorization", "Token a-totally-wrong-token" }

    it do
      get "/user"
      expect(last_response).to be_bad_request
    end
  end

  describe "empty Authorization header" do
    before { header "Authorization", "" }

    it do
      get "/user"
      expect(last_response).to be_unauthorized
    end
  end

  describe "missing Authorization header" do
    # No `before` block setting the header

    it do
      get "/user"
      expect(last_response).to be_unauthorized
    end
  end
end
