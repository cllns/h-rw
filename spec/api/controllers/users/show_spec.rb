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

    it "is successful" do
      response = action.call(params)
      expect(response[0]).to eq 200
      expect(body["Token"]).to eq("Token #{authorization_token}")
    end
  end
end
