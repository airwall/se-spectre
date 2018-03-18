shared_examples "authenticated" do
  let(:user) { create(:user) }
  let(:user_no_spectre) { create(:user, spectre_active: false) }

  context "response ok" do
    init_rest_client

    it "return status 200" do
      sign_in user
      request
      expect(response.status).to eq 200
    end
  end

  context "bad request" do
    init_rest_client_fail

    it "redirect if bad request" do
      sign_in user
      request
      expect(response.status).to eq 302
    end
  end
end
