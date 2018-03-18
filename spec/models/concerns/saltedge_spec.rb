require "rails_helper"
require "rest-client"

describe Saltedge do
  let(:saltedge)  { Saltedge.new }
  let(:hash)      do
    {
      method: "GET",
      url: "",
      expires_at: 100,
      params: ""
    }
  end

  describe ".new" do
    it "takes two parameters and returns a Saltedge object" do
      expect(saltedge).to be_an_instance_of(Saltedge)
    end
  end

  describe ".request" do
    it "execute request" do
      allow(Time).to receive(:now).and_return(100 - 60)
      allow(Logger).to receive(:new).with(STDOUT).and_return("logger")

      response = double("RestClient")
      allow(response).to receive(:code) { 200 }
      allow(response).to receive(:body) { { data: { id: 1 } }.to_json }

      expect(RestClient::Request).to receive(:execute).with(
        method:  "GET",
        url:     "www.example.com/",
        payload: "",
        log:     "logger",
        headers: {
          "Accept" => "application/json",
          "Content-type"   => "application/json",
          "Expires-at"     => hash[:expires_at],
          "App-Id" => "client",
          "Secret" => "secret"
        }
      ).and_return(response)

      saltedge.request("GET", "", {})
    end
  end
end
