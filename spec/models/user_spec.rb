require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:customers).dependent(:destroy) }

  let(:user) { build(:user) }

  describe ".create_customer" do
    body = { data: { id: 1, secret: "secret", identifier: "12345678" } }.to_json
    credentials = { response: JSON.parse(body), status: 200 }

    before { allow(user).to receive(:request_customer_credentials).and_return(credentials) }

    context "identifier doesn't exists" do
      it "create new customer" do
        expect { user.save! }.to change(User, :count).by(1).and change(user.customers, :count).by(1)
      end

      it "assign credentials for customer" do
        user.save!
        user.reload
        expect(user.customers.last.customer_id).to eq credentials[:response]['data']['id']
        expect(user.customers.last.secret).to eq credentials[:response]['data']['secret']
        expect(user.customers.last.identifier).to eq credentials[:response]['data']['identifier']
      end

      it "don't create customer if status !200" do
        credentials[:status] = 409
        expect { user.save! }.to change(User, :count).by(1).and change(user.customers, :count).by(0)
      end
    end
  end

  describe ".request_customer_credentials" do
    let(:saltedge) { Saltedge.new("client", "secret") }

    it "create and return customer" do
      response = double("RestClient")
      allow(response).to receive(:code) { 200 }
      allow(response).to receive(:body) {
        { data: { identifier: user.email,
                  secret: "secret",
                  id: 11 } }.to_json
      }

      allow(saltedge).to receive(:request)
      allow(RestClient::Request).to receive(:execute).and_return(response)
      result = { response: JSON.parse(response.body), status: response.code }

      expect(user).to receive(:request_customer_credentials).and_return(result)
      user.save!
    end
  end
end
