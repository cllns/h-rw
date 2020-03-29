class UserPresenter
  include Hanami::Presenter

  def to_hash
    super.slice(:email, :username, :bio, :image).merge(token: "")
  end
end
