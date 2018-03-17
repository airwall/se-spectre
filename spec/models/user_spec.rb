require "rails_helper"

RSpec.describe User, type: :model do

  let(:user) { build(:user) }
  let(:saltedge)  { Saltedge.new("client", "secret") }

  describe ".create_customer" do
    it "create and return customer" do
      response = double('RestClient')
      allow(response).to receive(:code) { 200 }
      allow(response).to receive(:body) { { data: { identifier: user.email }}.to_json }

      allow(saltedge).to receive(:request)
      allow(RestClient::Request).to receive(:execute).and_return(response)
      result = { :response => JSON.parse(response.body), status: response.code }

      expect(user).to receive(:create_customer).and_return(result)
      user.run_callbacks :create
    end
  end
end
