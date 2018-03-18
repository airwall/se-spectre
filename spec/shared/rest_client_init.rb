module RestClientInit
  def init_rest_client
    before do
      response = double("RestClient")
      allow(response).to receive(:code) { 200 }
      allow(response).to receive(:body) {
        { data: { identifier: "12345678",
                  secret: "secret",
                  id: 11, connect_url: "www.url.com" } }.to_json
      }
      allow(RestClient::Request).to receive(:execute).and_return(response)
    end
  end

  def init_rest_client_fail
    before do
      response = double("RestClient")
      allow(response).to receive(:code) { 409 }
      allow(response).to receive(:body) {
        { data: { identifier: "12345678",
                  secret: "secret",
                  id: 11, connect_url: "www.url.com" } }.to_json
      }
      allow(RestClient::Request).to receive(:execute).and_return(response)
    end
  end
end
