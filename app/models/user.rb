class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :create_customer

  def activate_spectre!
    create_customer
    self.save!
    self.spectre_active
  end

  private

  def create_customer
    identifier = Digest::MD5.hexdigest("#{SecureRandom.hex(12)}-#{email}")
                            .chars.sample(12).join("")
                            .gsub(/(.)(.?)/) { Regexp.last_match(1).upcase + Regexp.last_match(2).downcase }

    client = Saltedge.new
    path = "customers"
    params = { data: { identifier: identifier } }
    data = client.request("POST", path, params)
    connected = data[:status] == 200 ? true : false
    self.spectre_active = connected
  end
end
