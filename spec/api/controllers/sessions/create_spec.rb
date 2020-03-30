RSpec.describe Api::Controllers::Sessions::Create, type: :action do
  let(:action) { described_class.new }
  let(:response) { action.call(params) }
  let(:body) { JSON.parse(response[2][0]) }

  before { UserRepository.new.clear }

  describe "with invalid params" do
    let(:params) { Hash[] }

    it "is 422: unprocessable entity" do
      expect(response[0]).to eq 422
      expect(body).to eq(
        Hash[
          "errors" => {
            "user" => ["is missing"]
          }
        ]
      )
    end
  end

  describe "with valid params" do
    before do
      UserRepository.new.create(
        email: "test@example.com",
        username: "tester",
        encrypted_password: BCrypt::Password.create("password")
      )
    end

    let(:params) do
      Hash[
        user: {
          email: "test@example.com",
          password: "password"
        }
      ]
    end

    it "is successful" do
      expect(response[0]).to eq 200
    end

    it "has appropriate response" do
      expect(body.keys).to eq(["user"])
      expect(body["user"]).to match(
        "email" => "test@example.com",
        "username" => "tester",
        "token" => /.+/,
        "bio" => nil,
        "image" => nil
      )
      expect(body).to have_correct_json_web_token
    end
  end
end
