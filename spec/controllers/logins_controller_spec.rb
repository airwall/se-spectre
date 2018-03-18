require "rails_helper"

RSpec.describe LoginsController, type: :controller do
  describe "GET :index" do
    let(:get_index) { get :index, params: {} }

    it_behaves_like "unauthenticated" do
      let(:redirect) { get_index }
    end

    it_behaves_like "authenticated" do
      let(:request) { get_index }
    end
  end

  describe "GET :show" do
    let(:get_show) { get :show, params: { id: 1 } }

    it_behaves_like "unauthenticated" do
      let(:redirect) { get_show }
    end

    it_behaves_like "authenticated" do
      let(:request) { get_show }
    end
  end

  describe "POST :token" do
    let(:post_token) { post :token, params: { customer_id: 1 } }
    let(:user) { create(:user) }

    it_behaves_like "unauthenticated" do
      let(:redirect) { post_token }
    end

    init_rest_client

    it "redirect to authorize url" do
      sign_in user
      post_token
      expect(response.status).to eq 302
    end
  end

  describe "POST :refresh" do
    let(:post_refresh) { post :refresh, params: { login_id: 1 } }
    let(:user) { create(:user) }

    it_behaves_like "unauthenticated" do
      let(:redirect) { post_refresh }
    end

    init_rest_client

    it "redirect to authorize url" do
      sign_in user
      post_refresh
      expect(response.status).to eq 302
    end
  end

  describe "POST :reconnect" do
    let(:post_reconnect) { post :reconnect, params: { login_id: 1 } }
    let(:user) { create(:user) }

    it_behaves_like "unauthenticated" do
      let(:redirect) { post_reconnect }
    end

    init_rest_client

    it "redirect to authorize url" do
      sign_in user
      post_reconnect
      expect(response.status).to eq 302
    end
  end

  describe "POST :destroy" do
    let(:post_destroy) { post :destroy, params: { login_id: 1 } }
    let(:user) { create(:user) }

    it_behaves_like "unauthenticated" do
      let(:redirect) { post_destroy }
    end

    init_rest_client

    it "redirect to authorize url" do
      sign_in user
      post_destroy
      expect(response.status).to eq 200
    end
  end
end
