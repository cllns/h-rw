RSpec.describe Api::Controllers::Users::Show, type: :action do
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

  describe "with valid Authorization HTTP header" do
    let(:params) do
      Hash["HTTP_AUTHORIZATION" => "Token #{authorization_token}"]
    end

    it "has appropriate response" do
      response = action.call(params)
      expect(response[0]).to eq 200
      expect(body["user"]).to match(
        "email" => "test@example.com",
        "username" => "tester",
        "bio" => nil,
        "image" => nil,
        "token" => /.+/
      )
    end
  end

  describe "with invalid Authorization HTTP header" do
    let(:params) do
      Hash["HTTP_AUTHORIZATION" => "Token #{authorization_token} x-y-z!"]
    end

    it "returns at 400: Bad Request" do
      response = action.call(params)
      expect(response[0]).to eq 400
      expect(response[2][0]).to eq("Bad Request")
    end
  end

  describe "with missing Authorization HTTP header" do
    let(:params) { Hash[] }

    it "returns at 401: Unauthorized" do
      response = action.call(params)
      expect(response[0]).to eq 401
      expect(response[2][0]).to eq("Unauthorized")
    end
  end

  describe "with an empty Authorization HTTP header" do
    let(:params) { Hash["HTTP_AUTHORIZATION" => ""] }

    it "returns at 401: Unauthorized" do
      response = action.call(params)
      expect(response[0]).to eq 401
      expect(response[2][0]).to eq("Unauthorized")
    end
  end
end
