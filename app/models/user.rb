class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :create_customer
  has_many :customers, dependent: :destroy

  private

  def create_customer
    credentials = request_customer_credentials
    data = credentials[:response]["data"]
    if credentials[:status] == 200
      customers.new(customer_id: data["id"],
                        identifier:  data["identifier"],
                        secret:      data["secret"])
    end
  end

  def request_customer_credentials
    identifier = Digest::MD5.hexdigest("#{SecureRandom.hex(12)}-#{email}")
                            .chars.sample(12).join("")
                            .gsub(/(.)(.?)/) { Regexp.last_match(1).upcase + Regexp.last_match(2).downcase }

    client = Saltedge.new(ENV["SALTEDGE_ID"], ENV["SALTEDGE_SECRET"])
    path = ENV["API_ROOT"] + "customers"
    params = { data: { identifier: identifier } }
    data = client.request("POST", path, params)
  end
end
