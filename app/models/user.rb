class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_customer

  private

  def create_customer
    identifier = Digest::MD5.hexdigest("#{SecureRandom.hex(12)}-#{email}")
                          .chars.sample(12).join("")
                          .gsub(/(.)(.?)/) { Regexp.last_match(1).upcase + Regexp.last_match(2).downcase }

    client = Saltedge.new(ENV["SALTEDGE_ID"], ENV["SALTEDGE_SECRET"])
    path = ENV["API_ROOT"] + "customers"
    params = { data: { identifier: identifier } }
    data = client.request("POST", path, params)
  end
end
