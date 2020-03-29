RSpec.describe UserRepository, type: :repository do
  let(:repository) { described_class.new }

  describe "#find_by_email_and_password" do
    let(:email) { "test@example.com" }
    let(:password) { "password" }
    let(:user) do
      repository.create(
        email: email,
        username: "tester",
        encrypted_password: BCrypt::Password.create(password)
      )
    end

    before do
      repository.clear
      user
    end

    describe "existent record" do
      it "retrieves appropriate record" do
        expect(
          repository.find_by_email_and_password(
            email: "test@example.com",
            password: "password"
          )
        ).to eq(user)
      end
    end

    describe "different email address" do
      let(:email) { "wrong@example.com" }

      it do
        expect(
          repository.find_by_email_and_password(
            email: "test@example.com",
            password: "password"
          )
        ).to be_nil
      end
    end

    describe "wrong password" do
      let(:password) { "password123" } # more realistic for a secure password ;)

      it do
        expect(
          repository.find_by_email_and_password(
            email: "test@example.com",
            password: "password"
          )
        ).to be_nil
      end
    end
  end
end
