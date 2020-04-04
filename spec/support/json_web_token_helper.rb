module JsonWebTokenHelper
  def json_web_token_header(user_id:)
    seven_days_from_now = Time.now.to_i + (60 * 60 * 24 * 7)
    [
      "Token",
      JWT.encode(
        Hash[user_id: user_id, iat: Time.now.to_i, exp: seven_days_from_now],
        API_SESSIONS_SECRET,
        "HS512"
      )
    ].join(" ")
  end
end
