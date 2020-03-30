RSpec::Matchers.define :have_correct_json_web_token do
  match do |body|
    payload = JWT.decode(
      body.dig("user", "token"),
      API_SESSIONS_SECRET,
      true,
      { algorithm: "HS512" }
    ).first
    expect(payload.keys).to match_array(%w[user_id iat exp])
    expect(payload["user_id"]).to be_an(Integer)
    expect(payload["iat"]).to be_within(10).of(Time.now.to_i)
    expect(payload["exp"]).to be_within(10).of(Time.now.to_i + (60 * 60 * 24 * 7))
  end
end
