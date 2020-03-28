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

    it "has appropriate response keys" do
      expect(body.keys).to eq(["user"])
      expect(body["user"].keys).to match_array(
        %w[email username bio image token]
      )
    end

    it "has appropriate response" do
      expect(body["user"]).to include(
        "email" => "test@example.com",
        "username" => "tester"
      )
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
  end
end
