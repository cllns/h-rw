RSpec.describe Api::Controllers::Users::Update, type: :action do
  include JsonWebTokenHelper

  let(:action) { described_class.new }
  let(:response) { action.call(params) }
  let(:body) { JSON.parse(response[2][0]) }
  let(:user) do
    UserRepository.new.clear
    UserRepository.new.create(
      email: "test@example.com",
      username: "tester",
      password: "password"
    )
  end

  let(:params) do
    Hash[
      "HTTP_AUTHORIZATION" => json_web_token_header(user_id: user.id),
      "user" => user_params
    ]
  end

  describe "updating with valid params" do
    let(:user_params) do
      Hash[
        email: "new@example.com",
        username: "so-new",
        bio: "Not only new, but shiny too.",
        image: "https://example.com/pic.png"
      ]
    end

    it "has appropriate response" do
      response = action.call(params)
      expect(response[0]).to eq(200)
      expect(body["user"]).to match(
        "email" => "new@example.com",
        "username" => "so-new",
        "bio" => "Not only new, but shiny too.",
        "image" => "https://example.com/pic.png",
        "token" => /.+/
      )
    end
  end

  describe "failing to update with invalid params" do
    let(:user_params) do
      Hash[
        email: nil # We require it's filled because it's not-null in the DB.
      ]
    end

    it "has appropriate response" do
      response = action.call(params)
      expect(response[0]).to eq(400)
      expect(body["errors"]).to eq(
        Hash["user" => { "email" => ["must be filled"] }]
      )
    end
  end
end
