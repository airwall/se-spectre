require "json"
require "rest-client"

class Saltedge
  attr_reader :app_id, :secret
  EXPIRATION_TIME = 60

  def initialize(app_id, secret)
    @app_id      = app_id
    @secret      = secret
  end

  def request(method, url, params={})
    hash = {
      method:     method,
      url:        url,
      expires_at: (Time.now + EXPIRATION_TIME).to_i,
      params:     as_json(params)
    }

    RestClient::Request.execute(
      method:  hash[:method],
      url:     hash[:url],
      payload: hash[:params],
      log:     Logger.new(STDOUT),
      headers: {
        "Accept"       => "application/json",
        "Content-type" => "application/json",
        "Expires-at"   => hash[:expires_at],
        "App-Id"       => app_id,
        "Secret"       => secret
      }
    )
  rescue RestClient::Exception => error
    pp JSON.parse(error.response)
  end

  private

  def as_json(params)
    return "" if params.empty?
    params.to_json
  end
end
