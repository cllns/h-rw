RSpec.describe Api::Controllers::Users::Show, type: :action do
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

  describe "with valid Authorization HTTP header" do
    let(:params) do
      Hash["HTTP_AUTHORIZATION" => json_web_token_header(user_id: user.id)]
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
end
