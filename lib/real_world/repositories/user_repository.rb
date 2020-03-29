class UserRepository < Hanami::Repository
  def find_by_email_and_password(email:, password:)
    user = users.where(email: email).first
    user if user && BCrypt::Password.new(user.encrypted_password) == password
  end
end
