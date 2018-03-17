require "rails_helper"
require "rest-client"

describe Saltedge do
  let(:saltedge)  { Saltedge.new("client", "secret") }
  let(:hash)      do
    {
      method: "GET",
      url: "http://example.com",
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

      expect(RestClient::Request).to receive(:execute).with(
        method:  "GET",
        url:     "http://example.com",
        payload: "",
        log:     "logger",
        headers: {
          "Accept" => "application/json",
          "Content-type"   => "application/json",
          "Expires-at"     => hash[:expires_at],
          "App-Id" => "client",
          "Secret" => "secret"
        }
      )

      saltedge.request("GET", "http://example.com", {})
    end
  end
end
