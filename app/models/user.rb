class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_customer

  private

  def create_customer
    client = Saltedge.new(ENV["SALTEDGE_ID"], ENV["SALTEDGE_SECRET"])
    path = ENV["API_ROOT"] + "customers"
    params = { data: { identifier: email } }
    data = client.request("POST", path, params)
  end
end
