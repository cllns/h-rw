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
    it "includes desired fields (and excludes id and timestamps)" do
      expect(presenter.to_hash).to eq Hash[
        email: "test@example.com",
        username: "tester",
        bio: "An informative bit of text",
        image: "http://example.com/headshot.png",
        token: ""
      ]
    end
  end
end
