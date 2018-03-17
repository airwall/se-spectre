require "rails_helper"

RSpec.describe User, type: :model do
  describe ".create_customer" do
    let(:user) { build(:user) }
    let(:user_persisted) { create(:user) }

    it "new job in queue" do
      expect { user.run_callbacks :create }.to change(Delayed::Job, :count).by(1)
    end
  end
end
