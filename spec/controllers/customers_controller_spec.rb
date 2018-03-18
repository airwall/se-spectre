require "rails_helper"

RSpec.describe CustomersController, type: :controller do
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

  describe "GET :activate" do
    let(:no_spectre) { create(:user, spectre_active: false) }
    let(:user) { create(:user) }
    let(:activate) { get :activate }

    init_rest_client

    context "user don't have customer" do
      it "activate user and redirect" do
        sign_in no_spectre
        activate
        expect(response).to redirect_to(root_path)
        no_spectre.reload
        expect(no_spectre.spectre_active).to eq true
      end
    end

    context "user have active spectre" do
      it "redirect to root" do
        sign_in user
        activate
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
