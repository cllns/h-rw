class UserPresenter
  include Hanami::Presenter

  def to_hash
    super.slice(:email, :username, :bio, :image).merge(token: json_web_token)
  end

  private

  def json_web_token
    JWT.encode(token_payload, API_SESSIONS_SECRET, "HS512") # Default is 256
  end

  def token_payload
    Hash[
      user_id: id,
      iat: Time.now.to_i,
      exp: days_from_now(7).to_i
    ]
  end

  def days_from_now(number_of_days)
    one_day_in_seconds = (
      60 * # Seconds
      60 * # Minutes
      24   # Hours
    )
    Time.now + (one_day_in_seconds * number_of_days)
  end
end
