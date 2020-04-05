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

  Hash[
    get: "/user",
    put: "/user"
  ].each do |verb, path|
    describe "#{verb} #{path}" do
      describe "correct header" do
        before { header "Authorization", "Token #{authorization_token}" }

        it do
          custom_request verb, path
          expect(last_response).to_not be_unauthorized
        end
      end

      describe "incorrect header" do
        before { header "Authorization", "Token a-totally-wrong-token" }

        it do
          custom_request verb, path
          expect(last_response).to be_bad_request
        end
      end

      describe "empty header" do
        before { header "Authorization", "" }

        it do
          custom_request verb, path
          expect(last_response).to be_unauthorized
        end
      end

      describe "missing header" do
        # No `before` block setting the header

        it do
          custom_request verb, path
          expect(last_response).to be_unauthorized
        end
      end
    end
  end
end
