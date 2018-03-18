require "rails_helper"

RSpec.describe AccountsController, type: :controller do
  describe "GET :index" do
    let(:get_index) { get :index, params: {} }

    it_behaves_like "unauthenticated" do
      let(:redirect) { get_index }
    end

    it_behaves_like "authenticated" do
      let(:request) { get_index }
    end
  end
end
