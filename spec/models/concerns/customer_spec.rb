require "rails_helper"

describe Customer do
  let(:identifier) { "identifier0" }
  let(:saltedge) { Saltedge.new("client", "secret") }

  describe ".create" do
    it "send request with success to saltedge" do
      allow(saltedge).to receive(:request)
      allow(RestClient::Request).to receive(:execute).and_return("ok")
      expect(Customer.create(identifier)).to eq "ok"
    end
  end
end
