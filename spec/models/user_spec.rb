require "rails_helper"

RSpec.describe User, type: :model do
  describe ".create_customer" do
    let(:saltedge) { Saltedge.new }
    let(:user) { build(:user) }
    let(:response) { double("RestClient") }

    it "create and return customer with status active" do
      allow(response).to receive(:code) { 200 }
      allow(response).to receive(:body) {
        { data: { identifier: user.email,
                  secret: "secret",
                  id: 11 } }.to_json
      }

      allow(RestClient::Request).to receive(:execute).and_return(response)
      result = { response: JSON.parse(response.body), status: response.code }
      allow(saltedge).to receive(:request).and_return(result)

      user.save!
      user.reload
      expect(user.spectre_active).to eq true
    end

    it "create and return customer with status disabled" do
      allow(response).to receive(:code) { 409 }
      allow(response).to receive(:body) {
        { data: { identifier: user.email,
                  secret: "secret",
                  id: 11 } }.to_json
      }

      allow(RestClient::Request).to receive(:execute).and_return(response)
      result = { response: JSON.parse(response.body), status: response.code }
      allow(saltedge).to receive(:request).and_return(result)

      user.save!
      user.reload
      expect(user.spectre_active).to eq false
    end
  end
end
