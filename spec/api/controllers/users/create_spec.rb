RSpec.describe Api::Controllers::Users::Create, type: :action do
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
    let(:params) do
      Hash[
        user: {
          email: "test@example.com",
          username: "tester",
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
        "bio" => nil,
        "image" => nil,
        "token" => /.+/
      )
      expect(body).to have_correct_json_web_token
    end

    it "persists the User" do
      response # to actually make the request
      expect(UserRepository.new.last.to_h).to include(
        email: "test@example.com",
        username: "tester",
        bio: nil,
        image: nil
      )
    end

    it "stores the password with bcrypt" do
      expect(BCrypt::Password).to receive(:create).with("password").and_call_original
      response
      last_user = UserRepository.new.last
      expect(
        BCrypt::Password.new(last_user.encrypted_password)
      ).to eq("password")
    end
  end
end
