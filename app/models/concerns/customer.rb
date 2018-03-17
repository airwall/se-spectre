module Customer
  def self.create(identifier)
    client = Saltedge.new(ENV["SALTEDGE_ID"], ENV["SALTEDGE_SECRET"])
    path = ENV["API_ROOT"] + "customers"
    params = { data: { identifier: identifier } }
    response = client.request("POST", path, params)
  end
end
