RSpec.describe Api::Controllers::Users::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:response) { action.call(params) }
  let(:body) { JSON.parse(response[2][0]) }

  it "is successful" do
    expect(response[0]).to eq 200
  end

  it "has appropriate keys" do
    expect(body.keys).to eq(["user"])
    expect(body["user"].keys).to match_array(
      %w[email username bio image token]
    )
  end
end
