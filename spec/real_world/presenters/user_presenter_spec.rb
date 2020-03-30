RSpec.describe UserPresenter, type: :presenter do
  let(:presenter) { described_class.new(user) }
  let(:user) do
    User.new(
      id: 100,
      email: "test@example.com",
      username: "tester",
      bio: "An informative bit of text",
      image: "http://example.com/headshot.png",
      encrypted_password: BCrypt::Password.create("password"),
      created_at: Time.now,
      updated_at: Time.now
    )
  end

  describe "#to_hash" do
    let(:now) { Time.now }
    let(:expected_token) do
      JWT.encode(
        Hash[user_id: 100, iat: now.to_i, exp: now.to_i + (60 * 60 * 24 * 7)],
        API_SESSIONS_SECRET,
        "HS512"
      )
    end

    before { allow(Time).to receive(:now).and_return(now) }

    it "includes desired fields (and excludes id and timestamps)" do
      expect(presenter.to_hash).to eq(
        Hash[
          email: "test@example.com",
          username: "tester",
          bio: "An informative bit of text",
          image: "http://example.com/headshot.png",
          token: expected_token
        ]
      )
    end
  end
end
